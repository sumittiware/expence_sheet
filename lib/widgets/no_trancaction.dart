import 'package:flutter/material.dart';

class NoTransactions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraints) {
      return Column(
        children: <Widget>[
          Text(
            'No trancactions made yet!',
            style: Theme.of(context).textTheme.title,
          ),
          SizedBox(
            height: 10,
          ),
          Container(
              height: constraints.maxHeight * 0.8,
              child: Image.asset('assets/image/expenceproject.png',
                  fit: BoxFit.cover))
        ],
      );
    });
  }
}
