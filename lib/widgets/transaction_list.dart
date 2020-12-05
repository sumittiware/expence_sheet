import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../models/transaction.dart';
import './no_trancaction.dart';

class TransactionList extends StatelessWidget {
  Widget build(BuildContext context) {
    final deleteFn =
        Provider.of<Transactions>(context, listen: false).deleteTransaction;
    return FutureBuilder(
      future:
          Provider.of<Transactions>(context, listen: false).fetchTransactions(),
      builder: (ctx, snapshot) => (snapshot.connectionState ==
              ConnectionState.waiting)
          ? Center(child: CircularProgressIndicator())
          : Consumer<Transactions>(
              child: NoTransactions(),
              builder: (context, transactions, child) {
                return (transactions.transactions.length == 0)
                    ? child
                    : ListView.builder(
                        itemBuilder: (ctx, index) {
                          return Card(
                            margin: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 8),
                            elevation: 5,
                            child: ListTile(
                              leading: CircleAvatar(
                                  radius: 30,
                                  child: Padding(
                                    padding: EdgeInsets.all(6),
                                    child: FittedBox(
                                        child: Text(
                                            '\₹${transactions.transactions[index].amount}')),
                                  )),
                              title: Text(
                                transactions.transactions[index].title,
                                style: Theme.of(context).textTheme.title,
                              ),
                              subtitle: Text(DateFormat.yMMMd().format(
                                  transactions.transactions[index].date)),
                              trailing: IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () => showDialog(
                                      context: ctx,
                                      barrierDismissible: false,
                                      child: AlertDialog(
                                        title: Text('Are you sure'),
                                        content: Text(
                                            'Do you really want to delete this transaction?'),
                                        actions: [
                                          FlatButton(
                                              onPressed: () {
                                                deleteFn(transactions
                                                    .transactions[index].id);
                                                Navigator.pop(context);
                                              },
                                              child: Text(
                                                'Yes',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Theme.of(context)
                                                        .primaryColor),
                                              )),
                                          FlatButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text(
                                                'No',
                                                style: TextStyle(fontSize: 20),
                                              ))
                                        ],
                                      ))),
                            ),
                          );
                        },
                        itemCount: transactions.transactions.length,
                      );
              },
            ),
    );
  }
}
