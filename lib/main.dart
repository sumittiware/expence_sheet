import 'package:expence_caluclator/widgets/chart.dart';
import 'package:expence_caluclator/widgets/new_transactions.dart';
import 'package:expence_caluclator/widgets/transaction_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './models/transaction.dart';

void main() => runApp(MyApp()); //main function of the code

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Transactions(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Expence Sheet',
        theme: ThemeData(
            primarySwatch: Colors.blue,
            accentColor: Colors.blueGrey,
            fontFamily: 'Quicksand',
            textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.cyan),
                button: TextStyle(color: Colors.white)),
            appBarTheme: AppBarTheme(
                textTheme: ThemeData.light().textTheme.copyWith(
                    title: TextStyle(
                        fontFamily: 'OpenSans',
                        fontSize: 23,
                        fontWeight: FontWeight.bold)))),
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  //String titleInput;
  //String amountInput;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  void _addNewItemToList(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: NewTransactions(),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final appbar = AppBar(
      title: Text('Expence Sheet'),
    );
    final listTx = Container(
        height: (mediaQuery.size.height -
                appbar.preferredSize.height -
                mediaQuery.padding.top) *
            0.7,
        child: TransactionList());
    return Scaffold(
      appBar: appbar,
      body: SingleChildScrollView(
          child: Column(
        // mainAxisAlignment: MainAxisAlignment
        // .spaceEvenly, //alignment of the column along the main-axis i.e. downwards in columns
        crossAxisAlignment: CrossAxisAlignment
            .stretch, //alignment of the row along the cross-axis i.e. sidewise in columns
        children: <Widget>[
          Container(
              height: (mediaQuery.size.height -
                      appbar.preferredSize.height -
                      mediaQuery.padding.top) *
                  0.3,
              child:
                  Consumer<Transactions>(builder: (context, transactions, _) {
                return Chart(transactions.rescentTransactions);
              })),
          listTx,
        ],
      )),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add), onPressed: () => _addNewItemToList(context)),
    );
  }
}
