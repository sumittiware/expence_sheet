import 'package:expence_caluclator/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
//import './user_transactions.dart';

class NewTransactions extends StatefulWidget {
  @override
  _NewTransactionsState createState() => _NewTransactionsState();
}

class _NewTransactionsState extends State<NewTransactions> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime _selecteddate;
  void _chooseDate() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime.now())
        .then((_pickeddate) {
      if (_pickeddate == null) {
        return;
      }
      setState(() {
        _selecteddate = _pickeddate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final transactions = Provider.of<Transactions>(context, listen: false);
    void _submitDetail() {
      if (titleController.text.isEmpty) {
        return;
      }
      String enteredTitle = titleController.text;
      int enteredAmount = int.parse(amountController.text);
      if (enteredTitle.isEmpty || enteredAmount <= 0 || _selecteddate == null) {
        return;
      }
      transactions.addTransactions(Transaction(
          id: DateTime.now().toString(),
          title: enteredTitle,
          amount: enteredAmount,
          date:
              _selecteddate)); //widget. is used to access the function or the parameter
      // passed to the widget.

      Navigator.of(context).pop();
    }

    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                //onChanged: (value) => titleInput = value,
                controller: titleController,
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                //onChanged: (value) => amountInput = value),
                controller: amountController,
                keyboardType: TextInputType
                    .number, //that opens only the number keyboard so that we can add no, only
                onSubmitted: (_) => _submitDetail(),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text(_selecteddate == null
                        ? 'No. Date chossen'
                        : 'Picked Date : ${DateFormat.yMd().format(_selecteddate)}'),
                  ),
                  FlatButton(
                    child: Text(
                      'Choose Date',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor),
                    ),
                    onPressed: _chooseDate,
                  )
                ],
              ),
              RaisedButton(
                child: Text('Add'),
                color: Theme.of(context).primaryColor,
                textColor: Theme.of(context).textTheme.button.color,
                onPressed: () {
                  _submitDetail();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
