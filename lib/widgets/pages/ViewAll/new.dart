
// Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Row(
                //     children: [
                //       Container(
                //           decoration: BoxDecoration(
                //               color: const Color(0xFF0A5C82),
                //               borderRadius: BorderRadius.circular(10)),
                //           padding: const EdgeInsets.all(7),
                //           child: const Icon(
                //             Icons.menu_sharp,
                //             size: 18,
                //             color: Colors.white,
                //           )),
                //       const SizedBox(
                //         width: 20,
                //       ),
                //       Consumer<CategoryDBProvide>(
                //         builder: (context, CategoryDBProvide, child) =>
                //             DropdownButton<String>(
                //           hint: Text(widget.category.name),
                //           value: _categoryID,
                //           items: (_selectedCategorytype == CategoryType.income
                //                   ? CategoryDBProvide.incomeCategoryList.value
                //                   : CategoryDBProvide.expenseCategoryList.value)
                //               .map((e) {
                //             return DropdownMenuItem(
                //               value: e.id,
                //               child: Text(e.name),
                //               onTap: () {
                //                 log(" fff ${CategoryDBProvide.incomeCategoryList.value.length}");
                //                 _selectedCategoryModel = e;
                //               },
                //             );
                //           }).toList(),
                //           onChanged: (selectedValue) {
                //             _categoryID = selectedValue;
                //             // You no longer need to call setState here
                //           },
                //         ),
                //       ),
                //     ],
                //   ),
                // ),