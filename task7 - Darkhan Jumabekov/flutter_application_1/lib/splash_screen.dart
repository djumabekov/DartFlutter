import 'dart:async';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/repo/repo_settings.dart';
import 'constants/app_assets.dart';
import 'login_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'generated/l10n.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/repo/repo_settings.dart';

class SplashScreen extends StatefulWidget {
  final String nextRoute;
  SplashScreen({required this.nextRoute});
  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    final repoSettings = Provider.of<RepoSettings>(
      context,
      listen: false,
    );
    repoSettings.init().whenComplete(() async {
      var defaultLocale = const Locale('ru', 'RU');
      final locale = await repoSettings.readLocale();
      if (locale == 'en') {
        defaultLocale = const Locale('en');
      }
      S.load(defaultLocale).whenComplete(() {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const LoginScreen(
              title: '',
            ),
          ),
        );
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              AppAssets.images.splash,
            ),
          ),
        ],
      ),
    );
  }
}
