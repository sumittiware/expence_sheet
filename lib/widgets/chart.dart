import 'package:expence_caluclator/widgets/chartbar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> rescentTransactions;

  Chart(this.rescentTransactions);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      var totalSum = 0;
      for (var i = 0; i < rescentTransactions.length; i++) {
        if (rescentTransactions[i].date.day == weekDay.day &&
            rescentTransactions[i].date.month == weekDay.month &&
            rescentTransactions[i].date.year == weekDay.year) {
          totalSum += rescentTransactions[i].amount;
        }
      }

      /*print(DateFormat.E().format(weekDay));
      print(totalSum);*/

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum
      };
    }).reversed.toList();
  }

  int get totalspending {
    return groupedTransactionValues.fold(0, (sum, item) {
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionValues.map((data) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                  data['day'],
                  data['amount'],
                  totalspending == 0
                      ? 0
                      : (data['amount'] as int) / totalspending),
            );
          }).toList(),
        ),
      ),
    );
  }
}
