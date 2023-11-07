import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../models/category/category_model.dart';

const CATEGORY_DB_NAME = 'category-database';

class CategoryDBProvide with ChangeNotifier {
  List<CategoryModel> incomeCategoryList = [];
  List<CategoryModel> expenseCategoryList = [];
  DateTime? _selectedDate;

  void updateSelectedDate(DateTime selectedDate) {
    _selectedDate = selectedDate;
    notifyListeners();
  }

  DateTime? getSelectedDate() {
    return _selectedDate;
  }

  Future<void> insertCategory(CategoryModel value) async {
    final categoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    await categoryDB.put(value.id, value);
    notifyListeners();
  }

  Future<void> refreshUI() async {
    final allCategories = await getCategories();
    incomeCategoryList = allCategories
        .where((category) => category.type == CategoryType.income)
        .toList();
    expenseCategoryList = allCategories
        .where((category) => category.type == CategoryType.expense)
        .toList();
    notifyListeners();
  }

  Future<List<CategoryModel>> getCategories() async {
    final categoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    return categoryDB.values.toList();
  }

  Future<void> deleteCategory(String categoryID) async {
    final categoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    await categoryDB.delete(categoryID);
    refreshUI();
  }

  List<DropdownMenuItem<String>> getIncomeCategoryItems() {
    final List<DropdownMenuItem<String>> items =
        incomeCategoryList.map((category) {
      return DropdownMenuItem<String>(
        value: category.id,
        child: Text(category.name),
      );
    }).toList();
    return items;
  }

  List<DropdownMenuItem<String>> getExpenseCategoryItems() {
    final List<DropdownMenuItem<String>> items =
        expenseCategoryList.map((category) {
      return DropdownMenuItem<String>(
        value: category.id,
        child: Text(category.name),
      );
    }).toList();
    return items;
  }

  List<DropdownMenuItem<String>> getCategoryItems(CategoryType categoryType) {
    final List<DropdownMenuItem<String>> items = [];
    if (categoryType == CategoryType.income) {
      for (var category in incomeCategoryList) {
        items.add(
          DropdownMenuItem<String>(
            value: category.id,
            child: Text(category.name),
          ),
        );
      }
    } else if (categoryType == CategoryType.expense) {
      for (var category in expenseCategoryList) {
        items.add(
          DropdownMenuItem<String>(
            value: category.id,
            child: Text(category.name),
          ),
        );
      }
    }
    return items;
  }
}
