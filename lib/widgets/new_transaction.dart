import 'package:flutter/material.dart';

class  NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  void submitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if(enteredTitle.isEmpty || enteredAmount <= 0){
      return;//沒輸入或者比0小 就回到這段  後面就不執行
    }

     widget.addTx(
            enteredTitle,
            enteredAmount,
     );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
         elevation: 5,
         child: Container(
          padding: EdgeInsets.all(10), 
          child: Column(
             crossAxisAlignment: CrossAxisAlignment.end,
             children: <Widget>[
           TextField(
             decoration: InputDecoration(labelText: 'Title'),
             controller: titleController,
             onSubmitted: (_) => submitData,
            //  onChanged: (val) { //輸入的值有改變就會觸發
                // titleInput = val; 
              //  } ,
             ),
           TextField(
             decoration: InputDecoration(labelText: 'Amount'),
             controller: amountController,
             keyboardType: TextInputType.number,
             onSubmitted: (_) => submitData, //匿名函式  可以不需要參數的彈性寫法 加上底線
            //  onChanged: (val) => amountInput = val,
             ),
             FlatButton(child: Text('Add Transaction'),
             textColor: Colors.purple,
             onPressed: submitData,
             ),
            ],
           ),
          ),
         );
  }
}