import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:innovabank/models/transaction_model.dart';

class FirestoreTransactionService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addTransaction(TransactionModel transaction) async {
    await _firestore.collection('transactions').add(transaction.toMap());
  }
}
