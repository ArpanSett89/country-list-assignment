import 'package:flutter/material.dart';
import 'package:testdrawer/historybody.dart';
class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
    child: Container(
    child: Text('Drawer Demo HISTORY'),
    ),
      ),
    );
  }
}
