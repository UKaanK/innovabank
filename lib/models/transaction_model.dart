class Transaction {
  final String transactionId;
  final String fromAccountId;
  final String toAccountId;
  final double amount;
  final String transactionType;
  final DateTime timestamp;
  final String description;

  Transaction({
    required this.transactionId,
    required this.fromAccountId,
    required this.toAccountId,
    required this.amount,
    required this.transactionType,
    required this.timestamp,
    required this.description,
  });
}
