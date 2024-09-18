import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits_app/core/services/get_it_service.dart';
import 'package:fruits_app/features/auth/domain/repos/auth_repo.dart';
import 'package:fruits_app/features/auth/presentation/views/cubits/signin/signin_cubit.dart';

import 'package:fruits_app/widgets/custom_appbar.dart';
import 'package:fruits_app/widgets/signin-bloc-consumer.dart';

class SigninView extends StatelessWidget {
  const SigninView({super.key});

  static const String routeName = 'LoginView';
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SigninCubit(
        getIt.get<AuthRepo>(),
      ),
      child: Scaffold(
        appBar: customAppBar(context, title: 'تسجيل دخول'),
        body: SigninViewBodyBlocConsumer(),
      ),
    );
  }
}
