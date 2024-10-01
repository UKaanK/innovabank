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
}
