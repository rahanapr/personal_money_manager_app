import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:personalmoneymanagerapp/models/transaction_model/transaction_model.dart';

// ignore: constant_identifier_names
const TRANSACTION_DB_NAME ='Transaction-database';

abstract class TransactionDbFunctions{
  Future<void> addTransaction(TransactionModel obj);
  Future <List<TransactionModel>> getAllTransactions();
  Future<void>deleteTransaction(String id);
}

class TransactionDb implements TransactionDbFunctions{
TransactionDb._internal();

static TransactionDb instance =TransactionDb._internal();

factory TransactionDb(){
  return instance;
}

ValueNotifier<List<TransactionModel>> transactionListNotifier = ValueNotifier([]);

  @override
 Future<void> addTransaction(TransactionModel obj) async{
   final _transactionDb = await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
   await _transactionDb.put(obj.id, obj);
  }

 Future<void> refresh() async{
   final _list = await getAllTransactions();
   _list.sort((first,second)=>second.date.compareTo(first.date));
   transactionListNotifier.value.clear();
   transactionListNotifier.value.addAll(_list);
   transactionListNotifier.notifyListeners();
 }
  @override
  Future<List<TransactionModel>> getAllTransactions() async {

    final _transactionDb = await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    return _transactionDb.values.toList();
    
  }

  @override
  Future<void> deleteTransaction(String id) async {
   final _transactionDb = await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
   await _transactionDb.delete(id);
   refresh();
  }
}