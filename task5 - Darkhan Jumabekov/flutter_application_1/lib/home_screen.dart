import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'generated/l10n.dart';

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
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Container(
                alignment: Alignment.topCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('${S.of(context).language}: '),
                    DropdownButton<String>(
                        value: Intl.getCurrentLocale(),
                        items: [
                          DropdownMenuItem(
                            value: 'en',
                            child: Text(
                              S.of(context).english,
                            ),
                          ),
                          DropdownMenuItem(
                            value: 'ru_RU',
                            child: Text(
                              S.of(context).russian,
                            ),
                          ),
                        ],
                        onChanged: (value) async {
                          if (value == 'ru_RU') {
                            await S.load(
                              const Locale('ru', 'RU'),
                            );
                            setState(() {});
                          } else if (value == 'en') {
                            await S.load(
                              const Locale('en'),
                            );
                            setState(() {});
                          }
                        }),
                  ],
                )),
            Container(
              alignment: Alignment.center,
              child: Column(
                children: <Widget>[
                  Text(
                    S.of(context).counterValue,
                  ),
                  Text(
                    '$_counter',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(60, 40),
                      primary: Colors.blue,
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                    ),
                    onPressed: _incrementCounter,
                    child: const Text(
                      '+',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(60, 40),
                      primary: Colors.blue,
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                    ),
                    onPressed: _decrementCounter,
                    child: const Text(
                      '-',
                      style: TextStyle(fontSize: 12),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
