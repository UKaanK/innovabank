import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:innovabank/utils/iban_generator.dart';

class AccountService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
 // Yeni bir hesap ekleme fonksiyonu
  Future<void> addAccount(String customerId, String accountType, double balance) async {
    String iban = generateIban(); // IBAN oluşturuyoruz

    var docRef = await _firestore.collection('accounts').add({
      'customerId': customerId,
      'accountType': accountType,
      'balance': balance,
      'iban': iban, // Oluşturulan IBAN burada saklanacak
      'createdAt': DateTime.now(),
    });

    print('Hesap eklendi: ${docRef.id}, IBAN: $iban');
  }
  //Hesap Sorgulama
   Future<bool> hasExistingAccount(String customerId) async {
    // Müşteri ID'sine göre hesapları sorgulayın
    QuerySnapshot snapshot = await _firestore
        .collection('accounts')
        .where('customerId', isEqualTo: customerId)
        .where('accountType', whereIn: ['Vadeli', 'Vadesiz']) // Vadeli veya Vadesiz hesapları kontrol et
        .get();
    return snapshot.docs.isNotEmpty; // Eğer döküman varsa true döndür
  }

 Future<List<Map<String, dynamic>>> getAccounts(String customerId) async {
    var querySnapshot = await _firestore
        .collection('accounts') // Hesapların bulunduğu koleksiyon
        .where('customerId', isEqualTo: customerId) // Müşteri ID'sine göre filtreleme
        .get();

    return querySnapshot.docs.map((doc) => doc.data()).toList();
  }
}