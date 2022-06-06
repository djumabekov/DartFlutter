import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      if (_counter > 0) {
        _counter--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Значение счетчика:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            width: 50.0,
            height: 30.0,
            child: FloatingActionButton(
              onPressed: _incrementCounter,
              tooltip: 'Increment',
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(6)),
              ),
              elevation: 10,
              highlightElevation: 10,
              child: const Icon(
                Icons.add,
                size: 10,
              ),
            ),
          ),
          SizedBox(
            width: 50.0,
            height: 30.0,
            child: FloatingActionButton(
              onPressed: _decrementCounter,
              tooltip: 'Decrement',
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(6)),
              ),
              elevation: 10,
              highlightElevation: 10,
              child: const Icon(
                Icons.remove,
                size: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
