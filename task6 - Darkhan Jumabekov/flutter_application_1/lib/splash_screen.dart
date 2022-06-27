import 'dart:async';
import 'dart:core';
import 'package:flutter/material.dart';
import 'constants/app_assets.dart';

class SplashScreen extends StatefulWidget {
  final String nextRoute;
  SplashScreen({required this.nextRoute});
  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacementNamed(widget.nextRoute);
    });
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
