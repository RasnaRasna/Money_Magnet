import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:provider/provider.dart';

import '../../../db/category/category_db.dart';
import '../../../db/providers/addtransaction_provider.dart';
import '../../../models/category/category_model.dart';
import 'add_category_popup.dart';

class AddTransaction extends StatelessWidget {
  const AddTransaction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AddTransactionProvider(),
      child: _AddTransactionScreen(),
    );
  }
}

class _AddTransactionScreen extends StatefulWidget {
  @override
  State<_AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<_AddTransactionScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<AddTransactionProvider>(context, listen: false)
        .initializeState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AddTransactionProvider>(context);

    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: <Color>[
                Color.fromARGB(255, 10, 92, 130),
                Color.fromARGB(255, 221, 210, 210),
                Color.fromARGB(255, 10, 92, 130),
              ])),
        ),
        title: const Text(
          'Add transaction',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
            key: provider.formKey,
            child: ListView(children: [
              Column(
                children: [
                  Row(
                    children: [
                      Row(
                        children: [
                          Radio<CategoryType>(
                            activeColor: const Color.fromARGB(255, 10, 92, 130),
                            value: CategoryType.income,
                            groupValue: provider.selectedCategoryType,
                            onChanged: (_) => provider
                                .setSelectedCategoryType(CategoryType.income),
                          ),
                          const Text('Income'),
                          const SizedBox(width: 16.0),
                          Radio<CategoryType>(
                            activeColor: const Color.fromARGB(255, 10, 92, 130),
                            value: CategoryType.expense,
                            groupValue: provider.selectedCategoryType,
                            onChanged: (_) => provider
                                .setSelectedCategoryType(CategoryType.expense),
                          ),
                          const Text('Expense'),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 10, 92, 130),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.all(7),
                        child: const Icon(
                          Icons.description,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: provider.categoryID,
                          items: provider.selectedCategoryType ==
                                  CategoryType.income
                              ? CategoryDB().getIncomeCategoryItems()
                              : CategoryDB().getExpenseCategoryItems(),
                          onChanged: (value) => provider.selectCategory(value!),
                          validator: provider.validateCategory,
                          decoration: InputDecoration(
                            labelText: 'Category',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 10, 92, 130),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.all(7),
                        child: const Icon(
                          Icons.description,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: TextFormField(
                          controller: provider.purposeEditingController,
                          decoration: InputDecoration(
                              labelText: 'Purpose', border: InputBorder.none),
                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              return 'Please enter a purpose';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 10, 92, 130),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.all(7),
                        child: const Icon(
                          Icons.description,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: TextFormField(
                          controller: provider.amountEditingController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Amount',
                            border: InputBorder.none,
                          ),
                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              return 'Please enter an amount';
                            }
                            final parseAmount = double.tryParse(value!);
                            if (parseAmount! <= 0 || parseAmount == null) {
                              return 'Please enter a valid amount';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 10, 92, 130),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.all(8),
                          child: const Icon(
                            Icons.calendar_month,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                      Expanded(
                        child: TextButton(
                          onPressed: () => provider.selectDate(context),
                          child: Container(
                            height: 56.0,
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                children: [
                                  Text(
                                    provider.selectedDate == null
                                        ? 'Select Date'
                                        : DateFormat.yMd()
                                            .format(provider.selectedDate!),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 10, 92, 130),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.all(8),
                          child: const Icon(
                            Icons.calendar_month,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: TextButton(
                          onPressed: () => addPopupOnly(
                            context: context,
                            selectedCategoryType:
                                provider.selectedCategoryType!,
                          ),
                          child: const Text(
                            'Add  New Category',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 10, 92, 130),
                    ),
                    onPressed: () {
                      if (provider.formKey.currentState!.validate()) {
                        provider.addTransaction(context);
                        Navigator.of(context).pop();
                      }
                    },
                    child: Text(
                      'Submit',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ])),
      ),
    );
  }
}
