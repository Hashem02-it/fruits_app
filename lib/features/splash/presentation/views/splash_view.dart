import 'package:flutter/material.dart';
import 'package:fruits_app/widgets/splashview_body.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  static const routeName = 'spalsh';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SplashViewBody(),
    );
  }
}
