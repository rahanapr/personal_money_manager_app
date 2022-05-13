import 'package:flutter/material.dart';
import 'package:personalmoneymanagerapp/db/category_db/category_db.dart';
import 'package:personalmoneymanagerapp/models/category_model/category_model.dart';

class ExpenseCategoryList extends StatelessWidget {
  const ExpenseCategoryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: CategoryDb().expenseCategoryListListener,
        builder:
            (BuildContext context, List<CategoryModel> newList, Widget? _) {
          return ListView.separated(
            padding: const EdgeInsets.all(8.0),
            itemCount: newList.length,
            separatorBuilder: (BuildContext ctx, int index) {
              return const SizedBox(
                height: 10,
              );
            },
            itemBuilder: (BuildContext context, int index) {
              final category = newList[index];
              return Card(
                child: ListTile(
                  title: Text(category.name),
                  trailing: IconButton(
                    onPressed: () {
                      CategoryDb.instance.deleteCategory(category.id);
                    },
                    icon: const Icon(Icons.delete),
                  ),
                ),
              );
            },
          );
        });
  }
}
