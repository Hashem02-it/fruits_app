import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits_app/constants.dart';
import 'package:fruits_app/core/utils/app_colors.dart';
import 'package:fruits_app/core/utils/app_images.dart';
import 'package:fruits_app/core/utils/app_text_styles.dart';
import 'package:fruits_app/features/auth/presentation/views/cubits/signin/signin_cubit.dart';
import 'package:fruits_app/widgets/custom_button.dart';
import 'package:fruits_app/widgets/custom_textfield.dart';
import 'package:fruits_app/widgets/donthave_account.dart';
import 'package:fruits_app/widgets/or_devider.dart';
import 'package:fruits_app/widgets/password_field.dart';
import 'package:fruits_app/widgets/social_login_button.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class SigninViewBody extends StatefulWidget {
  const SigninViewBody({super.key});
  static const String routeName = 'LoginViewBody';

  @override
  State<SigninViewBody> createState() => _SigninViewBodyState();
}

class _SigninViewBodyState extends State<SigninViewBody> {
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  late String email;
  late String password;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kHorizantalPadding),
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          autovalidateMode: autovalidateMode,
          child: Column(
            children: [
              SizedBox(
                height: 24,
              ),
              CustomTextFormField(
                onSaved: (vlaue) {
                  email = vlaue!;
                },
                hintText: 'البريد الإلكتروني',
              ),
              SizedBox(
                height: 24,
              ),
              PasswordField(
                onSaved: (value) {
                  password = value!;
                },
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'نسيت كلمة المرور؟',
                    style: TextStyles.semiBold13
                        .copyWith(color: AppColors.lightprimaryColor),
                  ),
                ],
              ),
              SizedBox(
                height: 33,
              ),
              CustomButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                      context.read<SigninCubit>().signinUser(email, password);
                    } else {
                      autovalidateMode = AutovalidateMode.always;
                      setState(() {});
                    }
                  },
                  text: 'تسجيل دخول'),
              SizedBox(
                height: 33,
              ),
              DontHaveAccountWidget(),
              SizedBox(
                height: 33,
              ),
              OrDevider(),
              SizedBox(
                height: 16,
              ),
              SocialLoginButton(
                onPressed: () {
                  context.read<SigninCubit>().signinWithGoogle();
                },
                image: Assets.assetsImagesGoogle,
                title: ' تسجيل بواسطة جوجل',
              ),
              SizedBox(
                height: 16,
              ),
              Platform.isIOS
                  ? Column(
                      children: [
                        SocialLoginButton(
                          onPressed: () {
                            context.read<SigninCubit>().signinWithApple();
                          },
                          image: Assets.assetsImagesApple,
                          title: 'تسجيل بواسطة أبل',
                        ),
                        SizedBox(
                          height: 16,
                        ),
                      ],
                    )
                  : Container(),
              SocialLoginButton(
                onPressed: () {
                  context.read<SigninCubit>().signinWithFacebook();
                },
                image: Assets.assetsImagesFacebook,
                title: 'تسجيل بواسطة فيسبوك',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
