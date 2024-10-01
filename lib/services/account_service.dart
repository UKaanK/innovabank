import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:innovabank/models/account_model.dart';

class AccountService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addAccount(Account account) async {
    await _firestore.collection('accounts').add({
      'accountId': account.accountId,
      'customerId': account.customerId,
      'accountType': account.accountType,
      'iban': account.iban,
      'balance': account.balance,
      'createdAt': account.createdAt,
    });
  }

  Future<Account?> getAccount(String accountId) async {
    var docSnapshot = await _firestore.collection('accounts').doc(accountId).get();
    if (docSnapshot.exists) {
      var data = docSnapshot.data()!;
      return Account(
        accountId: data['accountId'],
        customerId: data['customerId'],
        accountType: data['accountType'],
        iban: data['iban'],
        balance: data['balance'],
        createdAt: (data['createdAt'] as Timestamp).toDate(),
      );
      
    }
    return null;
  }
}