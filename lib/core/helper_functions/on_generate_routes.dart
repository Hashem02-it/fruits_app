import 'package:flutter/material.dart';
import 'package:fruits_app/features/auth/login_view.dart';
import 'package:fruits_app/features/splash/presentation/views/on_boarding/presentation/views/on_boarding.dart';
import 'package:fruits_app/features/splash/presentation/views/splash_view.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SplashView.routeName:
      return MaterialPageRoute(builder: (context) => const SplashView());
    case LoginView.routeName:
      return MaterialPageRoute(builder: (context) => const LoginView());

    case OnBoardingView.routeName:
      return MaterialPageRoute(builder: (context) => const OnBoardingView());
    default:
      return MaterialPageRoute(builder: (context) => const Scaffold());
  }
}
