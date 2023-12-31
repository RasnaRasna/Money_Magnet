import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../models/category/category_model.dart';

// ignore: constant_identifier_names
const CATEGORY_DB_NAME = 'category-database';

abstract class CategoryDbFunctions {
  List<DropdownMenuItem<String>> getCategoryItems(CategoryType categoryType);

  Future<List<CategoryModel>> getCategories();
  Future<void> insertCategory(CategoryModel value);
  Future<void> deleteCategory(String categoryID);
  List<DropdownMenuItem<String>> getIncomeCategoryItems();
  List<DropdownMenuItem<String>> getExpenseCategoryItems();
}

class CategoryDB implements CategoryDbFunctions {
  CategoryDB._internal();
  static CategoryDB instance = CategoryDB._internal();

  factory CategoryDB() {
    return instance;
  }

  // ignore: non_constant_identifier_names
  ValueNotifier<List<CategoryModel>> incomeCategoryList = ValueNotifier([]);
  ValueNotifier<List<CategoryModel>> expenseCategoryList = ValueNotifier([]);

  @override
  Future<void> insertCategory(CategoryModel value) async {
    final categoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    await categoryDB.put(value.id, value);
    // refreshUI();
  }

  Future<void> refreshUI() async {
    final allCategories = await getCategories();
    incomeCategoryList.value = allCategories
        .where((category) => category.type == CategoryType.income)
        .toList();
    expenseCategoryList.value = allCategories
        .where((category) => category.type == CategoryType.expense)
        .toList();
    incomeCategoryList.notifyListeners();
    expenseCategoryList.notifyListeners();
  }

  @override
  Future<List<CategoryModel>> getCategories() async {
    final categoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    return categoryDB.values.toList();
  }

  @override
  Future<void> deleteCategory(String categoryID) async {
    final categoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    await categoryDB.delete(categoryID);
    refreshUI();
  }

  @override
  List<DropdownMenuItem<String>> getIncomeCategoryItems() {
    final List<DropdownMenuItem<String>> items = [];
    incomeCategoryList.value.forEach((category) {
      items.add(
        DropdownMenuItem<String>(
          value: category.id,
          child: Text(category.name),
        ),
      );
    });
    return items;
  }

  @override
  List<DropdownMenuItem<String>> getExpenseCategoryItems() {
    final List<DropdownMenuItem<String>> items = [];
    expenseCategoryList.value.forEach((category) {
      items.add(
        DropdownMenuItem<String>(
          value: category.id,
          child: Text(category.name),
        ),
      );
    });
    return items;
  }

  @override
  List<DropdownMenuItem<String>> getCategoryItems(CategoryType categoryType) {
    final List<DropdownMenuItem<String>> items = [];
    if (categoryType == CategoryType.income) {
      incomeCategoryList.value.forEach((category) {
        items.add(
          DropdownMenuItem<String>(
            value: category.id,
            child: Text(category.name),
          ),
        );
      });
    } else if (categoryType == CategoryType.expense) {
      expenseCategoryList.value.forEach((category) {
        items.add(
          DropdownMenuItem<String>(
            value: category.id,
            child: Text(category.name),
          ),
        );
      });
    }
    return items;
  }
}
