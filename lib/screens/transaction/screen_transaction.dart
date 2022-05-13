import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:personalmoneymanagerapp/db/category_db/category_db.dart';
import 'package:personalmoneymanagerapp/db/transaction_db/transaction_db.dart';
import 'package:personalmoneymanagerapp/models/category_model/category_model.dart';
import 'package:personalmoneymanagerapp/models/transaction_model/transaction_model.dart';

class ScreenTransaction extends StatelessWidget {
  const ScreenTransaction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TransactionDb.instance.refresh();
    CategoryDb.instance.refreshUI();
    return ValueListenableBuilder(
        valueListenable: TransactionDb.instance.transactionListNotifier,
        builder: (BuildContext ctx, List<TransactionModel> newList, Widget? _) {
          return ListView.separated(
            padding: const EdgeInsets.all(10),

            //Values

            itemBuilder: ((ctx, index) {
              final _value = newList[index];
              return Slidable(
                key: Key(_value.id!),
                startActionPane: ActionPane(motion:const ScrollMotion(), children:[
                  SlidableAction(
                    onPressed: ((context) {
                      TransactionDb.instance.deleteTransaction(_value.id!);
                    }),
                    icon: Icons.delete,

                  ),
                ]),
                child: Card(
                  elevation: 0,
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 50,
                      child: Text(
                        parseDate(_value.date),
                        textAlign: TextAlign.center,
                      ),
                      backgroundColor: _value.type == CategoryType.income
                          ? Colors.green[100]
                          : Colors.red[100],
                    ),
                    title: Text('Rs ${_value.amount}'),
                    subtitle: Text(_value.purpose),
                    trailing: Text(_value.category.name),
                  ),
                ),
              );
            }),
            separatorBuilder: (ctx, index) {
              return const SizedBox(
                height: 10,
              );
            },
            itemCount: newList.length,
          );
        });
  }

  String parseDate(DateTime date) {
    final _date = DateFormat.MMMd().format(date);
    final _splitDate = _date.split(' ');
    return "${_splitDate.last}\n${_splitDate.first}";
    // return '${date.day}\n${date.month}';
  }
}
