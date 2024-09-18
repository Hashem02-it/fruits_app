import 'package:flutter/material.dart';

import 'package:fruits_app/features/auth/presentation/views/widgets/signin_view_body.dart';
import 'package:fruits_app/widgets/custom_appbar.dart';

class SigninView extends StatelessWidget {
  const SigninView({super.key});

  static const String routeName = 'LoginView';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, title: 'تسجيل دخول'),
      body: SigninViewBody(),
    );
  }
}
