import 'package:collection/collection.dart';
import 'package:flutter/Material.dart';

import '../../models/category/category_model.dart';
import '../../models/transactions/transaction_model.dart';
import '../category/category_db.dart';
import '../transaction/transaction_db.dart';

class AddTransactionProvider extends ChangeNotifier {
  DateTime? selectedDate;
  CategoryType? selectedCategoryType;
  CategoryModel? selectedCategoryModel;
  String? categoryID;

  final purposeEditingController = TextEditingController();
  final amountEditingController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  String? validateCategory(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select a category';
    }
    return null;
  }

  void initializeState() {
    selectedCategoryType = CategoryType.income;
    selectedDate = null;
    selectedCategoryModel = null;
    categoryID = null;
    purposeEditingController.text = '';
    amountEditingController.text = '';
    formKey.currentState?.reset();
  }

  void setSelectedCategoryType(CategoryType categoryType) {
    selectedCategoryType = categoryType;
    notifyListeners();
  }

  void selectCategory(String selectedValue) {
    categoryID = selectedValue;
    final categoryList = selectedCategoryType == CategoryType.income
        ? CategoryDB.instance.incomeCategoryList.value
        : CategoryDB.instance.expenseCategoryList.value;

    selectedCategoryModel = categoryList.firstWhereOrNull(
      (category) => category.id == selectedValue,
    );

    notifyListeners();
  }

  DateTime? selectedDatee;

  void updateDate(DateTime date) {
    selectedDatee = date;
  }

  Future<void> selectDate(BuildContext context) async {
    final selectDateTemp = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 10 * 365)),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.fromSwatch(
              primarySwatch: Colors.blueGrey,
            ),
          ),
          child: child!,
        );
      },
    );

    if (selectDateTemp != null) {
      selectedDate = selectDateTemp;
      notifyListeners();
    }
  }

  Future<void> addTransaction(BuildContext context) async {
    final purposeText = purposeEditingController.text;
    final amountText = amountEditingController.text;

    if (purposeText.isEmpty ||
        amountText.isEmpty ||
        categoryID == null ||
        selectedDate == null ||
        selectedCategoryModel == null) {
      return;
    }

    final parseAmount = double.tryParse(amountText);
    if (parseAmount == null) {
      return;
    }
    final model = transactionModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      purpose: purposeText,
      amount: parseAmount,
      date: selectedDate!,
      type: selectedCategoryType!,
      category: selectedCategoryModel!,
    );

    await TransactionDB().addTransaction(model);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Transaction added successfully'),
      ),
    );

    initializeState();
  }
}
