import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';

import '../../models/transactions/transaction_model.dart';

const TRANSACTION_DB_NAME = 'transactio_db';

class TransactionDBProvider extends ChangeNotifier {
  List<transactionModel> transactionListNotifier = [];

  Future<void> addTransactions(transactionModel obj) async {
    final db = await Hive.openBox<transactionModel>(TRANSACTION_DB_NAME);
    await db.put(obj.id, obj);
    notifyListeners(); // Notify listeners after adding a transaction
  }

  Future<void> refresh() async {
    final list = await getAllTransactions();
    transactionListNotifier.clear();
    transactionListNotifier.addAll(list);
    notifyListeners();
  }

  Future<List<transactionModel>> getAllTransactions() async {
    final db = await Hive.openBox<transactionModel>(TRANSACTION_DB_NAME);
    return db.values.toList();
  }

  Future<void> deleteTransaction(String id) async {
    final db = await Hive.openBox<transactionModel>(TRANSACTION_DB_NAME);
    await db.delete(id);
    refresh();
  }

  Future<void> updateTransaction(transactionModel updatedTransaction) async {
    final db = await Hive.openBox<transactionModel>(TRANSACTION_DB_NAME);
    final transaction = db.get(updatedTransaction.id);
    if (transaction != null) {
      await db.put(updatedTransaction.id, updatedTransaction);
      await refresh();
    }
  }
}
