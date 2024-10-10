import 'package:cloud_firestore/cloud_firestore.dart';

class Account {
  final String accountId;
  final String customerId;
  final String accountType;
  final String iban;
  final double balance;
  final DateTime createdAt;

  Account({
    required this.accountId,
    required this.customerId,
    required this.accountType,
    required this.iban,
    required this.balance,
    required this.createdAt,
  });

  // Firestore'dan veri çekerken kullanılacak factory fonksiyonu
  factory Account.fromMap(Map<String, dynamic> data, String accountId) {
    return Account(
      accountId: accountId,
      customerId: data['customerId'] ?? '',
      accountType: data['accountType'] ?? '',
      iban: data['iban'] ?? '',
      balance: data['balance']?.toDouble() ?? 0.0,
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }

  // Firestore'a yazarken kullanılacak map fonksiyonu
  Map<String, dynamic> toMap() {
    return {
      'customerId': customerId,
      'accountType': accountType,
      'iban': iban,
      'balance': balance,
      'createdAt': createdAt,
    };
  }
}
