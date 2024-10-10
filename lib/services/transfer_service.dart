import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:innovabank/models/transaction_model.dart';

class FirestoreTransactionService {
  // Firestore instance'ını oluşturuyoruz.
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Para transferi işlemini gerçekleştiren asenkron bir metod.
  Future<void> performTransaction({
    required String fromAccountId,   // Gönderen hesabın ID'si
    required String toAccountIban,   // Alıcı hesabın IBAN'ı
    required double amount,           // Transfer edilecek miktar
    required String recipientName,     // Alıcının ismi
    required String description,       // İşlem açıklaması
  }) async {
    // Firestore'da işlem yaparken atomik bir işlem yapabilmek için runTransaction kullanıyoruz.
    return _firestore.runTransaction((transaction) async {
      // Gönderen hesabın referansını alıyoruz.
      DocumentReference fromAccountRef = _firestore.collection('accounts').doc(fromAccountId);
      
      // Gönderen hesabın mevcut verilerini almak için belgeyi alıyoruz.
      DocumentSnapshot fromAccountSnapshot = await transaction.get(fromAccountRef);

      // Eğer gönderen hesap mevcut değilse, hata fırlatıyoruz.
      if (!fromAccountSnapshot.exists) {
        throw Exception("Gönderen hesap bulunamadı.");
      }

      // Gönderen hesabın bilgilerini alıyoruz.
      Map<String, dynamic> fromAccountData = fromAccountSnapshot.data() as Map<String, dynamic>;
      double fromAccountBalance = fromAccountData['balance']; // Gönderen hesabın bakiyesi

      // Yetersiz bakiye kontrolü yapıyoruz.
      if (fromAccountBalance < amount) {
        throw Exception("Yetersiz bakiye."); // Eğer bakiye yetersizse hata fırlatıyoruz.
      }

      // Alıcı hesabı IBAN ile buluyoruz.
      QuerySnapshot toAccountSnapshot = await _firestore.collection('accounts')
          .where('iban', isEqualTo: toAccountIban).limit(1).get();
      
      // Eğer alıcı hesap bulunamazsa hata fırlatıyoruz.
      if (toAccountSnapshot.docs.isEmpty) {
        throw Exception("Alıcı hesap bulunamadı.");
      }

      // Alıcı hesabın referansını alıyoruz.
      DocumentReference toAccountRef = toAccountSnapshot.docs.first.reference;
      // Alıcı hesabın verilerini alıyoruz.
      Map<String, dynamic> toAccountData = toAccountSnapshot.docs.first.data() as Map<String, dynamic>;
      double toAccountBalance = toAccountData['balance']; // Alıcı hesabın bakiyesi

      // Gönderen ve alıcı bakiyelerini güncelleyerek yeni bakiyeleri hesaplıyoruz.
      double updatedFromAccountBalance = fromAccountBalance - amount; // Gönderenin yeni bakiyesi
      double updatedToAccountBalance = toAccountBalance + amount; // Alıcının yeni bakiyesi

      // Gönderen ve alıcı hesapların bakiyelerini güncelliyoruz.
      transaction.update(fromAccountRef, {'balance': updatedFromAccountBalance});
      transaction.update(toAccountRef, {'balance': updatedToAccountBalance});

      // Yeni bir transaction kaydı oluşturuyoruz.
      DocumentReference transactionRef = _firestore.collection('transactions').doc();
      TransactionModel newTransaction = TransactionModel(
        fromAccountId: fromAccountId,     // Gönderen hesap ID'si
        toAccountIban: toAccountIban,      // Alıcı IBAN'ı
        amount: amount,                    // Transfer edilen miktar
        transactionType: 'Transfer',       // İşlem türü
        timestamp: DateTime.now(),         // İşlem zamanı
        description: description,           // İşlem açıklaması
        recipientName: recipientName,       // Alıcı ismi
      );

      // Transaction kaydını Firestore'a ekliyoruz.
      transaction.set(transactionRef, newTransaction.toMap());
    });
  }
}
