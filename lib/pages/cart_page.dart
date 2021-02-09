import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';
import '../provide/counter.dart';

class CartPage extends StatelessWidget {
  final Counter notifier = Counter();
  CartPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: Center(
          child: ChangeNotifierProvider(
              create: (_) => Counter(),
              child: MyHomePage(title: 'Flutter Demo Home Page')),
        ),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;

  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(111);
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '${context.watch<Counter>().obj['num']}',
              style: Theme.of(context).textTheme.headline4,
            ),
            _button(context)
          ],
        ),
      ),
    );
  }

  Widget _button(context) {
    Counter notifier = Provider.of(context,
        listen: false); //通过Provider.of(context)获取MyChangeNotifier
    return FloatingActionButton(
      onPressed: notifier.increment, //点击时我们期望输出点击次数
      tooltip: 'Increment',
      child: Icon(Icons.add),
    );
  }
}

// class Number extends StatelessWidget {
//   // final Counter notifier;
//   const Number({Key key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     Counter notifier = Provider.of(context);
//     // Counter notifier = Provider.of(context);

//     return Container(
//       margin: EdgeInsets.only(top: 100.0),
//       child: Text(
//         '${notifier.count}',
//         // '${localNotifier.count}',
//       ),
//     );
//   }
// }

// class FooWidget extends StatelessWidget {
//   const FooWidget({Key key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     print('this is FooWidget');
//     return Container(
//       child: null,
//     );
//   }
// }

// class BarWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     print('this is BarWidget');
//     return Container(
//       child: null,
//     );
//   }
// }

// class Parent extends StatelessWidget {
//   const Parent({Key key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (_) => User(),
//       child: Container(
//         child: InkWell(
//           onTap: () {},
//           child: Consumer<User>(
//             builder: (_, local1, __) => BarWidget(),
//             child: FooWidget(),
//           ),
//         ),
//       ),
//     );
//   }
// }

class MyButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Counter notifier = Provider.of(context);
    // Counter notifier = Counter();
    return Container(
      child: RaisedButton(
        child: Text('递增'),
        onPressed: () {
          // context.read<Counter>().increment();
          notifier.increment();
        },
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   final CounterStorage storage = new CounterStorage();

  //   print('11111');
  //   storage.writeCounter(111);
  //   storage.readCounter().then((value) => print('data:$value'));
  //   return Container(
  //       child: RaisedButton(
  //     child: Text('递增'),
  //     onPressed: () {
  //       // context.read<Counter>().increment();
  //       notifier.increment();
  //       // localNotifier.increment();
  //     },
  //   ));
  // }
}

// class CounterStorage {
//   Future<String> get _localPath async {
//     final directory = await getApplicationDocumentsDirectory();

//     return directory.path;
//   }

//   Future<File> get _localFile async {
//     final path = await _localPath;
//     return File('$path/cart_page.dart');
//   }

//   Future readCounter() async {
//     try {
//       final file = await _localFile;

//       // Read the file
//       String contents = await file.readAsString();

//       return (contents);
//     } catch (e) {
//       // If encountering an error, return 0
//       return e;
//     }
//   }

//   Future<File> writeCounter(int counter) async {
//     final file = await _localFile;

//     // Write the file
//     return file.writeAsString('$counter');
//   }
// }
