import 'package:flutter/material.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  final username = 'qwerty';
  final pass = '123456ab';
  final _minNameLength = 3;
  final _minPassLength = 8;
  final _maxNameLength = 8;
  final _maxPassLength = 16;
  String errorName = '';
  String errorPass = '';

  _auth() {
    final name = _nameController.text;
    final password = _passwordController.text;

    if (name == username && password == pass) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeScreen(
            title: 'Авторизация прошла успешно!',
          ),
        ),
      );
    } else {
      showAlertDialog(context);
    }
  }

  showAlertDialog(BuildContext context) {
    Widget okButton = TextButton(
        child: const Text("Закрыть"), onPressed: () => Navigator.pop(context));

    AlertDialog alert = AlertDialog(
      title: const Text("Попробуйте снова"),
      actions: [
        okButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  _checkName(name) {
    if (name.length < _minNameLength) {
      setState(() {
        errorName = 'Логин должен содержать не менее $_minNameLength символов';
      });
    } else {
      setState(() {
        errorName = '';
      });
    }
  }

  _checkPass(pass) {
    if (pass.length < _minPassLength) {
      setState(() {
        errorPass =
            'Пароль должен содержать не менее $_minPassLength  символов';
      });
    } else {
      setState(() {
        errorPass = '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Авторизация'),
        ),
        body: Padding(
            padding: const EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    child: const Text(
                      'Введите логин и пароль',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    )),
                Container(
                  alignment: Alignment.topLeft,
                  child: Stack(
                    children: <Widget>[
                      TextField(
                        onChanged: (name) {
                          _checkName(name);
                        },
                        maxLength: _maxNameLength,
                        controller: _nameController,
                        decoration: const InputDecoration(
                          labelText: 'Логин',
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 60),
                        child: Text(
                          errorName,
                          style:
                              const TextStyle(color: Colors.red, fontSize: 8),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: Stack(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TextField(
                        onChanged: (pass) {
                          _checkPass(pass);
                        },
                        maxLength: _maxPassLength,
                        obscureText: true,
                        controller: _passwordController,
                        decoration: const InputDecoration(
                          labelText: 'Пароль',
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 60),
                        child: Text(
                          errorPass,
                          style:
                              const TextStyle(color: Colors.red, fontSize: 8),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                    padding: const EdgeInsets.fromLTRB(10, 70, 0, 10),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.0),
                        )),
                      ),
                      child: const Text(
                        'Вход',
                        style: TextStyle(fontSize: 12),
                      ),
                      onPressed: () {
                        _auth();
                      },
                    )),
              ],
            )));
  }
}
