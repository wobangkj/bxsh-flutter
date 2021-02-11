import 'package:flutter/material.dart';

class Counter with ChangeNotifier {
  Map<String, int> _obj = {'num': 1};

  Map get obj => _obj;

  // set count => _count = count;

  void increment() {
    // _count.num = 1;
    _obj['num'] += 1;
    notifyListeners();
  }
}
