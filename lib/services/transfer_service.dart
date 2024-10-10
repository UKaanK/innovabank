import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:innovabank/models/transaction_model.dart';

class FirestoreTransactionService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> performTransaction({
    required String fromAccountId,
    required String toAccountIban,
    required double amount,
    required String recipientName,
    required String description,
  }) async {
    return _firestore.runTransaction((transaction) async {
      // Gönderen hesabı al
      DocumentReference fromAccountRef = _firestore.collection('accounts').doc(fromAccountId);
      DocumentSnapshot fromAccountSnapshot = await transaction.get(fromAccountRef);

      if (!fromAccountSnapshot.exists) {
        throw Exception("Gönderen hesap bulunamadı.");
      }

      // Gönderen hesabın bilgilerini al
      Map<String, dynamic> fromAccountData = fromAccountSnapshot.data() as Map<String, dynamic>;
      double fromAccountBalance = fromAccountData['balance'];

      // Yetersiz bakiye kontrolü
      if (fromAccountBalance < amount) {
        throw Exception("Yetersiz bakiye.");
      }

      // Alıcı hesabı IBAN ile bul
      QuerySnapshot toAccountSnapshot = await _firestore.collection('accounts')
          .where('iban', isEqualTo: toAccountIban).limit(1).get();
      
      if (toAccountSnapshot.docs.isEmpty) {
        throw Exception("Alıcı hesap bulunamadı.");
      }

      DocumentReference toAccountRef = toAccountSnapshot.docs.first.reference;
      Map<String, dynamic> toAccountData = toAccountSnapshot.docs.first.data() as Map<String, dynamic>;
      double toAccountBalance = toAccountData['balance'];

      // Gönderen ve alıcı bakiyelerini güncelle
      double updatedFromAccountBalance = fromAccountBalance - amount;
      double updatedToAccountBalance = toAccountBalance + amount;

      // Hesapların bakiyelerini güncelle
      transaction.update(fromAccountRef, {'balance': updatedFromAccountBalance});
      transaction.update(toAccountRef, {'balance': updatedToAccountBalance});

      // Transaction kaydını oluştur
      DocumentReference transactionRef = _firestore.collection('transactions').doc();
      TransactionModel newTransaction = TransactionModel(
        fromAccountId: fromAccountId,
        toAccountIban: toAccountIban,
        amount: amount,
        transactionType: 'Transfer',
        timestamp: DateTime.now(),
        description: description,
        recipientName: recipientName,
      );

      // Transaction kaydını Firestore'a ekle
      transaction.set(transactionRef, newTransaction.toMap());
    });
  }
}
