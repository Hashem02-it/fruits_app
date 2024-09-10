import 'package:flutter/material.dart';

import 'package:fruits_app/features/auth/presentation/views/widgets/login_view_body.dart';
import 'package:fruits_app/widgets/custom_appbar.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  static const String routeName = 'LoginView';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(context, title: 'تسجيل دخول'),
      body: LoginViewBody(),
    );
  }
}
