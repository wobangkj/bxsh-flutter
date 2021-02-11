import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import '../provide/cart.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<String> testList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('购物车'),
      ),
      body: Consumer<CartProvide>(
        // create: (_) => CartProvide(),
        builder: (_, localer, child) => RaisedButton(
          child: Text('bbb'),
          onPressed: () {
            localer.show();
          },
        ),
      ),
    );
  }
}
