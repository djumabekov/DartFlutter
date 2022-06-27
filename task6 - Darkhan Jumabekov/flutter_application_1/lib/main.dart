import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'generated/l10n.dart';
import 'login_screen.dart';
import 'splash_screen.dart';
//import 'persons_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // We form application routing
  final routes = <String, WidgetBuilder>{
    // The path that creates the Home Screen
    '/Login': (BuildContext context) => const LoginScreen(title: 'Login')
  };

  MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: const Locale('ru', 'Ru'),
      supportedLocales: S.delegate.supportedLocales,
      home: SplashScreen(nextRoute: '/Login'),
      routes: routes,
    );
  }
}
