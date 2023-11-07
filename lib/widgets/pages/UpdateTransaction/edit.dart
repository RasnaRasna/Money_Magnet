
// import 'dart:developer';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:money_management2/db/providers/category_provider.dart';
// import 'package:money_management2/db/providers/updateprovider.dart';
// import 'package:money_management2/db/transaction/transaction_db.dart';
// import 'package:money_management2/models/category/category_model.dart';
// import 'package:money_management2/models/transactions/transaction_model.dart';
// import 'package:provider/provider.dart';
// import '../../../db/category/category_db.dart';
// import '../../../db/providers/addtransaction_provider.dart';
// import '../Addtranscation/add_category_popup.dart';
// import '../search/search.dart';

// class EditTransaction extends StatefulWidget {
//   String? id;
//   CategoryType type;
//   double amount;
//   String pupose;
//   final DateTime date;
//   final CategoryModel category;

//   EditTransaction({
//     super.key,
//     required this.id,
//     required this.type,
//     required this.amount,
//     required this.pupose,
//     required this.date,
//     required this.category,
//   });

//   @override
//   State<EditTransaction> createState() => _EditTransactionState();
// }

// class _EditTransactionState extends State<EditTransaction> {
//   CategoryType? _selectedCategorytype;
//   CategoryModel? _selectedCategoryModel;
//   String? _categoryID;
//   DateTime _selectedDate = DateTime.now();
//   late TextEditingController transactionamount;
//   late TextEditingController transactionpupose;
//   // late TextEditingController transactionnote;
//   // CategoryModel? transactioncategory;

//   @override
//   void initState() {
//     _selectedCategorytype = widget.type;
//     transactionpupose = TextEditingController(text: widget.pupose);
//     transactionamount = TextEditingController(text: widget.amount.toString());
//     _selectedCategoryModel = widget.category;
//     _selectedDate = widget.date;
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<AddTransactionProvider>(context);

//     // history = box.values.toList();
//     // log(history);
//     return Scaffold(
//       appBar: AppBar(
//         flexibleSpace: Container(
//           decoration: const BoxDecoration(
//               gradient: LinearGradient(
//                   begin: Alignment.centerLeft,
//                   end: Alignment.centerRight,
//                   colors: <Color>[
//                 Color.fromARGB(255, 10, 92, 130),
//                 Color.fromARGB(255, 221, 210, 210),
//                 Color.fromARGB(255, 10, 92, 130),
//               ])),
//         ),
//         backgroundColor: Colors.blue,
//         centerTitle: true,
//         title: const Text(
//           'Update',
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(10),
//         child: ListView(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 ChoiceChip(
//                   selectedColor: Colors.white,
//                   label: const Text('Income'),
//                   selected:
//                       provider.selectedCategoryType == CategoryType.income,
//                   onSelected: (_) =>
//                       provider.setSelectedCategoryType(CategoryType.income),
//                 ),
//                 const SizedBox(width: 16.0),
//                 ChoiceChip(
//                   selectedColor: Colors.white,
//                   label: const Text('Expense'),
//                   selected:
//                       provider.selectedCategoryType == CategoryType.expense,
//                   onSelected: (_) =>
//                       provider.setSelectedCategoryType(CategoryType.expense),
//                 ),
//               ],
//             ),
//             const SizedBox(
//               width: 20,
//             ),
//             Row(
//               children: [
//                 Container(
//                   decoration: BoxDecoration(
//                     color: const Color.fromARGB(255, 10, 92, 130),
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   padding: const EdgeInsets.all(7),
//                   child: const Icon(
//                     Icons.description,
//                     color: Colors.white,
//                     size: 20,
//                   ),
//                 ),
//                 const SizedBox(width: 20),
//                 Expanded(
//                     child: DropdownButtonFormField<String>(
//                   value: provider.categoryID,
//                   items: provider.selectedCategoryType == CategoryType.income
//                       ? CategoryDB().getIncomeCategoryItems()
//                       : CategoryDB().getExpenseCategoryItems(),
//                   onChanged: (value) => provider.selectCategory(value!),
//                   validator: provider.validateCategory,
//                   decoration: InputDecoration(
//                     labelText: 'Category',
//                     border: InputBorder.none,
//                   ),
//                 )),
//               ],
//             ),
//             Column(
//               children: [
//                 // Padding(
//                 //   padding: const EdgeInsets.all(8.0),
//                 //   child: Row(
//                 //     children: [
//                 //       Container(
//                 //           decoration: BoxDecoration(
//                 //               color: const Color(0xFF0A5C82),
//                 //               borderRadius: BorderRadius.circular(10)),
//                 //           padding: const EdgeInsets.all(7),
//                 //           child: const Icon(
//                 //             Icons.menu_sharp,
//                 //             size: 18,
//                 //             color: Colors.white,
//                 //           )),
//                 //       const SizedBox(
//                 //         width: 20,
//                 //       ),
//                 //       Consumer<CategoryDBProvide>(
//                 //         builder: (context, CategoryDBProvide, child) =>
//                 //             DropdownButton<String>(
//                 //           hint: Text(widget.category.name),
//                 //           value: _categoryID,
//                 //           items: (_selectedCategorytype == CategoryType.income
//                 //                   ? CategoryDBProvide.incomeCategoryList.value
//                 //                   : CategoryDBProvide.expenseCategoryList.value)
//                 //               .map((e) {
//                 //             return DropdownMenuItem(
//                 //               value: e.id,
//                 //               child: Text(e.name),
//                 //               onTap: () {
//                 //                 log(" fff ${CategoryDBProvide.incomeCategoryList.value.length}");
//                 //                 _selectedCategoryModel = e;
//                 //               },
//                 //             );
//                 //           }).toList(),
//                 //           onChanged: (selectedValue) {
//                 //             _categoryID = selectedValue;
//                 //             // You no longer need to call setState here
//                 //           },
//                 //         ),
//                 //       ),
//                 //     ],
//                 //   ),
//                 // ),
//                 const SizedBox(
//                   height: 15,
//                 ),
//                 Column(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.only(left: 7),
//                       child: Row(
//                         children: [
//                           Container(
//                               decoration: BoxDecoration(
//                                   color: const Color.fromARGB(255, 10, 92, 130),
//                                   borderRadius: BorderRadius.circular(10)),
//                               padding: const EdgeInsets.all(7),
//                               child: const Icon(
//                                 Icons.description,
//                                 color: Colors.white,
//                                 size: 20,
//                               )),
//                           const SizedBox(
//                             width: 20,
//                           ),
//                           Expanded(
//                               child: Provider.of<updateprovider>(context)
//                                   .textfield(
//                                       fieldcontroller: transactionpupose,
//                                       hintText: "purpose")),
//                         ],
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 20,
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(left: 7),
//                       child: Row(
//                         children: [
//                           Container(
//                               decoration: BoxDecoration(
//                                   color: const Color.fromARGB(255, 10, 92, 130),
//                                   borderRadius: BorderRadius.circular(10)),
//                               padding: const EdgeInsets.all(7),
//                               child: const Icon(
//                                 Icons.attach_money,
//                                 size: 20,
//                                 color: Colors.white,
//                               )),
//                           const SizedBox(
//                             width: 20,
//                           ),
//                           Expanded(
//                               child: Provider.of<updateprovider>(context)
//                                   .textfield(
//                                       fieldcontroller: transactionamount,
//                                       hintText: 'Enter Amount',
//                                       // border: Border(),
//                                       keyboardType: TextInputType.number)),
//                         ],
//                       ),
//                     ),

//                     const SizedBox(
//                       height: 25,
//                     ),
//                     //calender

//                     Align(
//                       alignment: Alignment.bottomLeft,
//                       child: TextButton.icon(
//                         onPressed: () async {
//                           final selectDateTemp = await showDatePicker(
//                             context: context,
//                             initialDate: DateTime.now(),
//                             firstDate: DateTime.now()
//                                 .subtract(const Duration(days: 10 * 365)),
//                             lastDate: DateTime.now(),
//                             // Remove extra parenthesis and move Theme widget outside of showDatePicker
//                             builder: (BuildContext context, Widget? child) {
//                               return Theme(
//                                 data: ThemeData.light().copyWith(
//                                   colorScheme: ColorScheme.fromSwatch(
//                                     primarySwatch: Colors.blueGrey,
//                                   ),
//                                 ),
//                                 child: child!,
//                               );
//                             },
//                           );
//                           if (selectDateTemp == null) {
//                             return;
//                           } else {
//                             print(selectDateTemp.toString());
//                             setState(() {
//                               _selectedDate = selectDateTemp;
//                             });
//                           }
//                         },
//                         icon: Padding(
//                           padding: const EdgeInsets.only(right: 10),
//                           child: Container(
//                               decoration: BoxDecoration(
//                                   color: const Color.fromARGB(255, 10, 92, 130),
//                                   borderRadius: BorderRadius.circular(10)),
//                               padding: const EdgeInsets.all(8),
//                               child: const Icon(
//                                 Icons.calendar_month,
//                                 color: Colors.white,
//                                 size: 20,
//                               )),
//                         ),
//                         label: Text(
//                           _selectedDate == null
//                               ? 'select date'
//                               : parseDate(_selectedDate),
//                           style: const TextStyle(
//                               color: Color.fromARGB(255, 83, 82, 82)),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 25,
//                     ),
//                     Row(
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.only(right: 10, left: 10),
//                           child: Container(
//                               decoration: BoxDecoration(
//                                   color: const Color.fromARGB(255, 10, 92, 130),
//                                   borderRadius: BorderRadius.circular(10)),
//                               padding: const EdgeInsets.all(8),
//                               child: const Icon(
//                                 Icons.calendar_month,
//                                 color: Colors.white,
//                                 size: 20,
//                               )),
//                         ),
//                         Align(
//                           alignment: Alignment.bottomLeft,
//                           child: TextButton(
//                             onPressed: () => addPopupOnly(
//                               context: context,
//                               selectedCategoryType:
//                                   provider.selectedCategoryType!,
//                             ),
//                             child: const Text(
//                               'Add Category',
//                               style: TextStyle(color: Colors.grey),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),

//                     const SizedBox(
//                       height: 25,
//                     ),
//                     SizedBox(
//                       height: 40,
//                       width: 100,
//                       child: ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor:
//                                 const Color.fromARGB(255, 10, 92, 130),
//                           ),
//                           onPressed: () {
//                             updateTransaction();
//                             Navigator.pop(context);
//                           },
//                           child: const Text(
//                             'Submit',
//                             style: TextStyle(color: Colors.white),
//                           )),
//                     )
//                   ],
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Future updateTransaction() async {
//     if (_selectedCategoryModel == null) {
//       return;
//     }
//     widget.amount = double.parse(transactionamount.text);
//     widget.pupose = transactionpupose.text;
//     final model = transactionModel(
//       id: widget.id,
//       category: _selectedCategoryModel!,
//       type: widget.type,
//       date: _selectedDate,
//       amount: widget.amount,
//       purpose: widget.pupose,
//     );

//     TransactionDB.instance.editTransaction(model);
//     TransactionDB.instance.refresh();
//     overViewListNotifier.notifyListeners();
//   }
// }

// String parseDate(DateTime selectedDate) {
//   return DateFormat.MMMd().format(selectedDate);
// }
