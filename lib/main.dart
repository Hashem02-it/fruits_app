import 'package:flutter/material.dart';
import 'package:fruits_app/features/splash/presentation/views/splash_view.dart';

void main() {
  runApp(const FrtuitHub());
}

class FrtuitHub extends StatelessWidget {
  const FrtuitHub({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashView(),
    );
  }
}
