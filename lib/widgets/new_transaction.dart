import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class  NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  void _submitData() {
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if(enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null ){
      return;//沒輸入或者比0小 或者日期為空值就回到這段  後面就不執行
    }

     widget.addTx(
            enteredTitle,
            enteredAmount,
            _selectedDate,
     );
     
     Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context, 
      initialDate: DateTime.now(), 
      firstDate: DateTime(2020), 
      lastDate: DateTime.now(),
      ).then((pickedDate) {
        if(pickedDate == null) {
          return;
        }
        setState(() {
          _selectedDate = pickedDate;
        });
      });
      print('...');
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
             controller: _titleController,
             onSubmitted: (_) => _submitData,
            //  onChanged: (val) { //輸入的值有改變就會觸發
                // titleInput = val; 
              //  } ,
             ),
           TextField(
             decoration: InputDecoration(labelText: 'Amount'),
             controller: _amountController,
             keyboardType: TextInputType.number,
             onSubmitted: (_) => _submitData, //匿名函式  可以不需要參數的彈性寫法 加上底線
            //  onChanged: (val) => amountInput = val,
             ),
             Container(
               height: 70,
               child: Row(
                 children: <Widget>[
                 Expanded(
                   child: Text(
                     _selectedDate == null 
                          ? 'No Date Chosen!' 
                          : 'Picked Date: ${DateFormat.yMd().format(_selectedDate)}',
                   ),
                 ),
                 FlatButton(
                   textColor: Theme.of(context).primaryColor,
                   child: Text(
                     'Choose Date', 
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                   ),
                   ), 
                   onPressed: _presentDatePicker,
                   ),
               ],
               ),
             ),
             RaisedButton(child: Text('Add Transaction'),
             color: Theme.of(context).primaryColor,
             textColor: Theme.of(context).textTheme.button.color,
             onPressed: _submitData,
             ),
            ],
           ),
          ),
         );
  }
}