import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/app_assets.dart';
import 'package:flutter_application_1/constants/app_colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'constants/app_styles.dart';
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
  String msgDescr = '';
  bool isNameRespond = false;
  bool isPassRespond = false;

  _auth() {
    final name = _nameController.text;
    final password = _passwordController.text;
    if (!isNameRespond || !isPassRespond) {
      setState(() {
        msgDialog = S.of(context).error;
        msgDescr = S.of(context).inputLoginAndPassword;
      });
      showAlertDialog(context, msgDialog, msgDescr);
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
        msgDialog = S.of(context).error;
        msgDescr = S.of(context).loginAndPasswordIncorrect;
      });
      showAlertDialog(context, msgDialog, msgDescr);
    }
  }

  showAlertDialog(BuildContext context, String msgDialog, String msgDescr) {
    AlertDialog alert = AlertDialog(
      title: Text(msgDialog),
      content: Text(msgDescr),
      contentTextStyle: AppStyles.s16w400,
      actionsPadding: const EdgeInsets.only(
        left: 16.0,
        right: 16.0,
        bottom: 16.0,
      ),
      insetPadding: const EdgeInsets.symmetric(
        horizontal: 24.0,
      ),
      actions: [
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  textStyle: AppStyles.s16w400.copyWith(
                    color: AppColors.primary,
                  ),
                  side: const BorderSide(
                    color: AppColors.primary,
                    width: 1.0,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 10.0,
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(S.of(context).ok),
              ),
            ),
          ],
        ),
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
        body: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Image.asset(
                  AppAssets.images.logo,
                  width: 250,
                  height: 250,
                ),
                const Padding(
                  padding: EdgeInsets.all(10.0),
                ),
                Container(
                  alignment: Alignment.center,
                  child: Stack(
                    children: <Widget>[
                      Text(
                        S.of(context).login,
                        style: AppStyles.s10w500.copyWith(
                          height: -3.0,
                          leadingDistribution: TextLeadingDistribution.even,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      TextField(
                        onChanged: (name) {
                          _checkName(name);
                        },
                        controller: _nameController,
                        decoration: InputDecoration(
                          hintText: S.of(context).login,
                          hintStyle: AppStyles.s16w400.copyWith(
                            color: AppColors.neutral2,
                          ),
                          filled: true,
                          fillColor: AppColors.neutral1,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: BorderSide.none,
                          ),
                          prefixIcon: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                            ),
                            child: SvgPicture.asset(
                              AppAssets.svg.account,
                              width: 16.0,
                              color: AppColors.neutral2,
                            ),
                          ),
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
                      Text(
                        S.of(context).password,
                        style: AppStyles.s10w500.copyWith(
                          height: -3.0,
                          leadingDistribution: TextLeadingDistribution.even,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      TextField(
                        onChanged: (pass) {
                          _checkPass(pass);
                        },
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: S.of(context).password,
                          hintStyle: AppStyles.s16w400.copyWith(
                            color: AppColors.neutral2,
                          ),
                          filled: true,
                          fillColor: AppColors.neutral1,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: BorderSide.none,
                          ),
                          prefixIcon: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                            ),
                            child: SvgPicture.asset(
                              AppAssets.svg.password,
                              width: 16.0,
                              color: AppColors.neutral2,
                            ),
                          ),
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
                      minimumSize: const Size(400, 60),
                      primary: AppColors.primary,
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                    ),
                    child: Text(
                      S.of(context).signIn,
                      style:
                          AppStyles.s16w500.copyWith(color: AppColors.neutral1),
                    ),
                    onPressed: () {
                      _auth();
                    },
                  ),
                ),
                const SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Text('${S.of(context).dontHaveAcc}?'),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        primary: AppColors.more1,
                        textStyle: AppStyles.s16w400,
                      ),
                      child: Text(
                        S.of(context).create,
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            )));
  }
}
