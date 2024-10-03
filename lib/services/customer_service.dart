import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:innovabank/models/customer_model.dart';

class CustomerService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addCustomer(Customer customer) async {
    var docRef = await _firestore.collection('customers').add({
      'customerId': customer.customerId,
      'name': customer.name,
      'email': customer.email,
      'phoneNumber': customer.phoneNumber,
      'createdAt': customer.createdAt,
      'password' : customer.password
    });
    print('Müşteri eklendi: ${docRef.id}'); // ID'yi yazdır
  }

  Future<Customer?> getCustomer(String customerId) async {
    var querySnapshot = await _firestore
        .collection('customers')
        .where('customerId',
            isEqualTo: customerId) // Burada customerId ile sorgulama yapıyoruz
        .limit(1) // En fazla bir belge almak için limit ekleyin
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      var data = querySnapshot.docs.first.data();

      return Customer(
        customerId: data['customerId'] as String,
        name: data['name'],
        email: data['email'],
        phoneNumber: data['phoneNumber'],
        createdAt: (data['createdAt'] as Timestamp).toDate(),
        password: data["password"],
      );
    }

    return null; // Belge bulunamazsa null döndür
  }
}
