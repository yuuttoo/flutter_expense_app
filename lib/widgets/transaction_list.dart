import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:expense_app/models/transaction.dart';

class TransactionList extends StatelessWidget{
  final List<Transaction> transactions;
  final Function deleteTx;

  TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      //加入無資料時的條件
      child: transactions.isEmpty
        ? LayoutBuilder(builder: (ctx, constraints) {
          return  Column(
          children: <Widget>[
            Text(
              'No transacitons added yet!',
              style: Theme.of(context).textTheme.title,
            ),
            SizedBox(
              height: 20,
              ),
            Container(
              height: constraints.maxHeight * 0.6,
              child: Image.asset(
                'assets/images/waiting.png', 
                fit: BoxFit.cover,
                )),
              ],
            );
        })

          : ListView.builder(
            itemBuilder: (ctx, index) {
              return Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(                 
                  vertical: 8,
                  horizontal: 5,                 
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30, 
                    child: Padding(
                      padding: const EdgeInsets.all(6),
                      child: FittedBox(
                        child: Text('\$${transactions[index].amount}'),
                        ),
                    ),
                  ),
                  title: Text(
                    transactions[index].title,
                    style: Theme.of(context).textTheme.title,
                  ),
                  subtitle: Text(
                    DateFormat.yMMMd().format(transactions[index].date),
                    ),
                    trailing: MediaQuery.of(context).size.width > 460 
                      ? FlatButton.icon(
                        icon: Icon(Icons.delete),
                        label: Text('Delete'),
                        textColor: Theme.of(context).errorColor,
                        onPressed: () => deleteTx(transactions[index].id),
                        )
                        : IconButton(
                      icon: Icon(Icons.delete), 
                      color: Theme.of(context).errorColor,//預設為紅色 也可以自己回main設定
                      onPressed: () => deleteTx(transactions[index].id),
                      ),
                ),
              );
            },
            itemCount: transactions.length,
      ),
    );
  }
}