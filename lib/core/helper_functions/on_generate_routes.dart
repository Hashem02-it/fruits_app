import 'package:flutter/material.dart';
import 'package:fruits_app/features/auth/signin_view.dart';
import 'package:fruits_app/features/auth/presentation/views/signup_view.dart';
import 'package:fruits_app/features/splash/presentation/views/on_boarding/presentation/views/on_boarding.dart';
import 'package:fruits_app/features/splash/presentation/views/splash_view.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SplashView.routeName:
      return MaterialPageRoute(builder: (context) => const SplashView());
    case SigninView.routeName:
      return MaterialPageRoute(builder: (context) => const SigninView());

    case OnBoardingView.routeName:
      return MaterialPageRoute(builder: (context) => const OnBoardingView());

    case SignupView.routeName:
      return MaterialPageRoute(builder: (context) => const SignupView());

    default:
      return MaterialPageRoute(builder: (context) => const Scaffold());
  }
}
