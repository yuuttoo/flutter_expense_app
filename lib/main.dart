import 'package:flutter/material.dart';

import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import 'widgets/chart.dart';
import './models/transaction.dart';




void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override 
  Widget build(BuildContext context) {
    return MaterialApp (
      title: 'Personal Expenses',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        fontFamily: 'QuickSand',
        textTheme: ThemeData.light().textTheme.copyWith(
          title: TextStyle(
            fontFamily: 'OpenSans', 
            fontWeight: FontWeight.bold,
            fontSize: 18,
            ),
            button: TextStyle(color: Colors.white),
        ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
           title: TextStyle(
             fontFamily: 'OpenSans',
             fontSize: 20,
             fontWeight: FontWeight.bold,
            ),
         ),
      )),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
 
  // String titleInput;
  // String amountInput;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

 final List<Transaction> _userTransactions = [
    // Transaction(
    //   id: 't1', 
    //   title: 'New Shoes', 
    //   amount: 69.72, 
    //   date: DateTime.now(),
    //   ),
    // Transaction(
    //   id: 't2', 
    //   title: 'Weekly Groceries', 
    //   amount: 16.22, 
    //   date: DateTime.now(),
    //   ),  
  ];

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(
        Duration(days: 7),
      ));
    }).toList();
  }

  //建構新的transaction

  void _addNewTransaction(String txTitle, double txAmount, DateTime chosenDate) {
    final newTx = Transaction(
      title: txTitle, 
      amount: txAmount, 
      date: chosenDate, 
      id: DateTime.now().toString()
      );

      setState(() {//用add才不會破壞_userTransactions的final
        _userTransactions.add(newTx);
      });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(context: ctx, 
    builder: (_) {
    return GestureDetector(
      onTap: () {},
      child: NewTransaction(_addNewTransaction),
      behavior: HitTestBehavior.opaque,
      );
    },
    );
  }

  void _deleteTransaction(String id) {//目前以id作為刪除判斷依據（上面的日期）
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);//選取的id  與 資料id相符, 刪除
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar (
        title: Text('Personal Expenses', style: TextStyle(fontFamily: 'OpenSans')),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.add), 
          onPressed:() => _startAddNewTransaction(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
              child: Column(
            //mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Chart(_recentTransactions),
              TransactionList(_userTransactions, _deleteTransaction), 
          ],
        ),
      ),  
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
        ),      
    );
  }
}