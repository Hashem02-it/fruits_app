import 'package:flutter/material.dart';
import 'package:fruits_app/features/auth/presentation/views/widgets/signup_view_body.dart';
import 'package:fruits_app/widgets/custom_appbar.dart';

class SignupView extends StatelessWidget {
  const SignupView({super.key});
  static const String routeName = 'SignupView';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, title: 'حساب جديد'),
      body: SignupViewBody(),
    );
  }
}
