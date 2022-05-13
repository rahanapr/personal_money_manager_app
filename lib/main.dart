import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:personalmoneymanagerapp/db/category_db/category_db.dart';
import 'package:personalmoneymanagerapp/models/category_model/category_model.dart';
import 'package:personalmoneymanagerapp/models/transaction_model/transaction_model.dart';
import 'package:personalmoneymanagerapp/screens/home/screen_home.dart';
import 'package:personalmoneymanagerapp/screens/transaction/widget/add_transaction.dart';

Future<void> main() async {
  final obj1 = CategoryDb();
  final obj2 = CategoryDb();
  print("object compairing");
  print(obj1 == obj2);

  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  if (!Hive.isAdapterRegistered(CategoryTypeAdapter().typeId)) {
    Hive.registerAdapter(CategoryTypeAdapter());
  }

  if (!Hive.isAdapterRegistered(CategoryModelAdapter().typeId)) {
    Hive.registerAdapter(CategoryModelAdapter());
  }

  if (!Hive.isAdapterRegistered(TransactionModelAdapter().typeId)) {
    Hive.registerAdapter(TransactionModelAdapter());
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.purple),
      title: 'Personal Money Management Application',
      home: const ScreenHome(),
      routes: {
        ScreenAddTransaction.routeName:(ctx) => const ScreenAddTransaction(),
      },
    );
  }
}
