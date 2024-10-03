import 'package:cloud_firestore/cloud_firestore.dart';

class Customer {
  final String customerId;
  final String name;
  final String email;
  final String phoneNumber;
  final DateTime createdAt;
  final String password;

  Customer( {
    required this.customerId,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.createdAt,
    required this.password
  });


   // Firestore'dan dönen veriyi Customer nesnesine dönüştüren fabrika fonksiyonu
  factory Customer.fromFirestore(Map<String, dynamic> data) {
    return Customer(
      customerId: data['customerId'],
      name: data['name'],
      email: data['email'],
      phoneNumber: data['phoneNumber'],
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      password: data["password"]
    );
  }

  // Customer nesnesini Firestore'a kaydetmek için map formatına çeviren fonksiyon
  Map<String, dynamic> toFirestore() {
    return {
      'customerId': customerId,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'createdAt': createdAt,
      'password' : password
    };
  }
}
