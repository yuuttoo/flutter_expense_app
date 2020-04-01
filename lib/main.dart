import 'package:flutter/material.dart';

import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import './models/transaction.dart';




void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override 
  Widget build(BuildContext context) {
    return MaterialApp (
      title: 'Flutter App',
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
    Transaction(
      id: 't1', 
      title: 'New Shoes', 
      amount: 69.72, 
      date: DateTime.now(),
      ),
    Transaction(
      id: 't2', 
      title: 'Weekly Groceries', 
      amount: 16.22, 
      date: DateTime.now(),
      ),  
  ];

  //建構新的transaction

  void _addNewTransaction(String txTitle, double txAmount) {
    final newTx = Transaction(
      title: txTitle, 
      amount: txAmount, 
      date: DateTime.now(), 
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar (
        title: Text('Flutter App'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.add), 
          onPressed:() => _startAddNewTransaction(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
              child: Column(
            //mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
            Container(
              width: double.infinity,
              child: Card(
                color: Colors.blue,
                child: Text('CHART!'),
                elevation: 5,
              ),
           ),
            TransactionList(_userTransactions),
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