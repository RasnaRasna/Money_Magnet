import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../../OnbordingScreen/splash.dart';
import '../../../db/providers/treansation_db.dart';
import '../../../models/category/category_model.dart';
import '../../../models/transactions/transaction_model.dart';

Future<void> resetAllData(BuildContext context) async {
  // final shared = await Hive.openBox<Splashscreens>("Splashscreens");
  // shared.clear();

  if (Splashscreens.getdata().isEmpty) {
    log('is empty');
  } else {
    await Splashscreens.getdata().clear();
  }

  final categoryDB = await Hive.openBox<CategoryModel>('category-database');

  categoryDB.clear();

  // ignore: non_constant_identifier_names
  final TransactionDB =
      await Hive.openBox<transactionModel>(TRANSACTION_DB_NAME);
  TransactionDB.clear();

  Navigator.of(context).pushReplacement(
    MaterialPageRoute(
      builder: (context) => const HomePage(),
    ),
  );
}
