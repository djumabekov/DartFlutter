import 'package:flutter/material.dart';
import 'generated/l10n.dart';
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
  String msgDialog = '';
  bool isNameRespond = false;
  bool isPassRespond = false;

  _auth() {
    final name = _nameController.text;
    final password = _passwordController.text;
    if (!isNameRespond || !isPassRespond) {
      setState(() {
        msgDialog = S.of(context).loginAndPasswordIncorrect;
      });
      showAlertDialog(context, msgDialog);
      return;
    }

    if (name == username && password == pass) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(
            title: S.of(context).authorizeSuccess,
          ),
        ),
      );
    } else {
      setState(() {
        msgDialog = S.of(context).tryAgain;
      });
      showAlertDialog(context, msgDialog);
    }
  }

  showAlertDialog(BuildContext context, String msgDialog) {
    Widget okButton = TextButton(
        child: Text(S.of(context).close),
        onPressed: () => Navigator.pop(context));

    AlertDialog alert = AlertDialog(
      title: Text(msgDialog),
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
        errorName = '${S.of(context).loginLengthsIncorrect} $_minNameLength';
      });
      setState(() {
        isNameRespond = false;
      });
    } else {
      setState(() {
        errorName = '';
      });
      setState(() {
        isNameRespond = true;
      });
    }
  }

  _checkPass(pass) {
    if (pass.length < _minPassLength) {
      setState(() {
        errorPass = '${S.of(context).passwordLengthsIncorrect} $_minPassLength';
      });
      setState(() {
        isPassRespond = false;
      });
    } else {
      setState(() {
        errorPass = '';
      });
      setState(() {
        isPassRespond = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).auth),
        ),
        body: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                    alignment: Alignment.topCenter,
                    child: Text(
                      S.of(context).inputLoginAndPassword,
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold),
                    )),
                Container(
                  alignment: Alignment.center,
                  child: Stack(
                    children: <Widget>[
                      TextField(
                        onChanged: (name) {
                          _checkName(name);
                        },
                        maxLength: _maxNameLength,
                        controller: _nameController,
                        decoration: InputDecoration(
                          labelText: S.of(context).login,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 60),
                        child: Text(
                          errorName,
                          style:
                              const TextStyle(color: Colors.red, fontSize: 10),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: Stack(
                    children: <Widget>[
                      TextField(
                        onChanged: (pass) {
                          _checkPass(pass);
                        },
                        maxLength: _maxPassLength,
                        obscureText: true,
                        controller: _passwordController,
                        decoration: InputDecoration(
                          labelText: S.of(context).password,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 60),
                        child: Text(
                          errorPass,
                          style:
                              const TextStyle(color: Colors.red, fontSize: 10),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                    alignment: Alignment.bottomCenter,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(400, 40),
                        primary: Colors.blue,
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                      ),
                      child: Text(
                        S.of(context).signIn,
                        style: const TextStyle(fontSize: 12),
                      ),
                      onPressed: () {
                        _auth();
                      },
                    )),
              ],
            )));
  }
}
