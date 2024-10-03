class TransactionModel {
  final String fromAccountId;
  final String toAccountIban;
  final double amount;
  final String transactionType;
  final DateTime timestamp;
  final String description;
  final String recipientName;

  TransactionModel({
    required this.fromAccountId,
    required this.toAccountIban,
    required this.amount,
    required this.transactionType,
    required this.timestamp,
    required this.description,
    required this.recipientName,
  });

  // Firestore'a yazarken kullanacağımız bir map fonksiyonu
  Map<String, dynamic> toMap() {
    return {
      'fromAccountId': fromAccountId,
      'toAccountIban': toAccountIban,
      'amount': amount,
      'transactionType': transactionType,
      'timestamp': timestamp.toIso8601String(),
      'description': description,
      'recipientName': recipientName,
    };
  }
}
