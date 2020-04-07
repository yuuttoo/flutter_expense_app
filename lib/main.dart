import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import 'widgets/chart.dart';
import './models/transaction.dart';




void main() {
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);
  runApp(MyApp());
}

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

  bool _showChart = false;

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
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final appBar = AppBar(
        title: Text(
          'Personal Expenses', 
          ),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.add), 
          onPressed:() => _startAddNewTransaction(context),
          ),
        ],
      );
      final txListWidget = Container(
                height: (mediaQuery.size.height - 
                        appBar.preferredSize.height -
                        mediaQuery.padding.top) *
                    0.7,
                child: TransactionList(_userTransactions, _deleteTransaction),
              );
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
              child: Column(
            //mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              if(isLandscape) Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                Text('Show Chart'),
                Switch.adaptive(
                  activeColor: Theme.of(context).accentColor,
                  value: _showChart, 
                  onChanged: (val) {
                  setState(() {
                    _showChart = val;
                    });
                  },
                 ),
               ],
              ),
              if(!isLandscape) Container(
                height: (mediaQuery.size.height - 
                        appBar.preferredSize.height - 
                        mediaQuery.padding.top) *
                    0.3,
                child: Chart(_recentTransactions),
                ),
              if(!isLandscape)  txListWidget, 
              if(isLandscape) _showChart 
              ? Container(
                height: (mediaQuery.size.height - 
                        appBar.preferredSize.height - 
                        mediaQuery.padding.top) *
                    0.7,
                child: Chart(_recentTransactions),
                )
              : txListWidget 
          ],
        ),
      ),  
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Platform.isIOS 
      ? Container() 
      : FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
        ),      
    );
  }
}