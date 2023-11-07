import 'package:flutter/Material.dart';

import '../../../db/category/category_db.dart';
import '../../../models/category/category_model.dart';

Future<void> addPopupOnly(
    {required BuildContext context,
    required CategoryType selectedCategoryType}) async {
  final nameEditingController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  await showDialog(
    context: context,
    builder: (ctx) {
      return SimpleDialog(
        title: const Text("Add Category"),
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Form(
              key: formKey,
              child: TextFormField(
                controller: nameEditingController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter category';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  hintText: 'Category name',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              if (formKey.currentState != null &&
                  formKey.currentState!.validate()) {
                final name = nameEditingController.text;
                if (name.isEmpty) {
                  return;
                }

                final category = CategoryModel(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  name: name,
                  type: selectedCategoryType,
                );
                await CategoryDB.instance.insertCategory(category);
                CategoryDB.instance.refreshUI();
                Navigator.of(ctx).pop();
              }
            },
            child: const Text('Add'),
          ),
        ],
      );
    },
  );
}
