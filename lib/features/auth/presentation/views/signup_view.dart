import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits_app/core/services/get_it_service.dart';
import 'package:fruits_app/features/auth/domain/repos/auth_repo.dart';
import 'package:fruits_app/features/auth/presentation/views/cubits/signup_cubit/signup_cubit.dart';
import 'package:fruits_app/features/auth/presentation/views/widgets/signup_view_blocconsumer.dart';
import 'package:fruits_app/widgets/custom_appbar.dart';

class SignupView extends StatelessWidget {
  const SignupView({super.key});
  static const String routeName = 'SignupView';
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupCubit(
        getIt<AuthRepo>(),
      ),
      child: Scaffold(
        appBar: customAppBar(context, title: 'حساب جديد'),
        body: SignUpViewBodyBlocConsumer(),
      ),
    );
  }
}
