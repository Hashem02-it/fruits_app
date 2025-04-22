import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits_app/constants.dart';
import 'package:fruits_app/core/helper_functions/errorsnackbar.dart';
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
  bool isEmailVerified = false;
  //bool isEmailVerifieds = FirebaseAuth.instance.currentUser!.emailVerified;
  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
    } on Exception catch (e) {
      SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red);
    }
  }

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });
  }

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
              const SizedBox(
                height: 24,
              ),
              CustomTextFormField(
                onSaved: (vlaue) {
                  email = vlaue!;
                },
                hintText: 'البريد الإلكتروني',
              ),
              const SizedBox(
                height: 24,
              ),
              PasswordField(
                onSaved: (value) {
                  password = value!;
                },
              ),
              const SizedBox(
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
              TextButton(
                onPressed: () async {
                  formKey.currentState?.save();

                  if (email.isEmpty || password.isEmpty) {
                    buildErrorBar(context,
                        'الرجاء إدخال البريد الإلكتروني وكلمة المرور أولاً');
                    return;
                  }

                  try {
                    final userCredential = await FirebaseAuth.instance
                        .signInWithEmailAndPassword(
                            email: email, password: password);

                    final user = userCredential.user;
                    await user?.reload();
                    final refreshedUser = FirebaseAuth.instance.currentUser;

                    if (refreshedUser != null) {
                      if (refreshedUser.emailVerified) {
                        buildErrorBar(
                            context, 'تم التحقق من البريد الإلكتروني مسبقًا');
                      } else {
                        await refreshedUser.sendEmailVerification();
                        buildErrorBar(context,
                            'تم إرسال رابط تحقق جديد إلى بريدك الإلكتروني');
                      }
                    } else {
                      buildErrorBar(context, 'حدث خطأ أثناء جلب المستخدم');
                    }
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'user-not-found' ||
                        e.code == 'wrong-password') {
                      buildErrorBar(context,
                          'البريد الإلكتروني أو كلمة المرور غير صحيحة');
                    } else {
                      buildErrorBar(context, 'حدث خطأ: ${e.message}');
                    }
                  } catch (e) {
                    buildErrorBar(
                        context, 'حدث خطأ غير متوقع: ${e.toString()}');
                  }
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.lightBlue.withOpacity(0.2),
                  foregroundColor: Colors.lightBlue,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'التحقق من البريد الإلكتروني',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(
                height: 33,
              ),
              CustomButton(
                onPressed: () async {
                  if (!formKey.currentState!.validate()) {
                    autovalidateMode = AutovalidateMode.always;
                    setState(() {});
                    return;
                  }

                  formKey.currentState!.save();

                  if (email.isEmpty || password.isEmpty) {
                    buildErrorBar(context, 'الرجاء تعبئة جميع الحقول');
                    return;
                  }

                  try {
                    final userCredential = await FirebaseAuth.instance
                        .signInWithEmailAndPassword(
                            email: email, password: password);

                    // 🔄 Refresh the user's verification status
                    await FirebaseAuth.instance.currentUser?.reload();
                    final verified =
                        FirebaseAuth.instance.currentUser?.emailVerified ??
                            false;

                    if (verified) {
                      // Proceed with sign-in if the email is verified
                      context.read<SigninCubit>().signinUser(email, password);
                    } else {
                      // Prevent login if the email is not verified
                      buildErrorBar(
                          context, 'الرجاء التحقق من البريد الإلكتروني أولاً');
                      await FirebaseAuth.instance
                          .signOut(); // Sign out immediately after failed verification
                    }
                  } on FirebaseAuthException catch (e) {
                    buildErrorBar(context, 'خطأ: ${e.message}');
                  }
                },
                text: 'تسجيل دخول',
              ),
              const SizedBox(
                height: 33,
              ),
              const DontHaveAccountWidget(),
              const SizedBox(
                height: 33,
              ),
              const OrDevider(),
              const SizedBox(
                height: 16,
              ),
              Platform.isAndroid //>>>to hide google button <<<<
                  ? Column(
                      children: [
                        SocialLoginButton(
                          onPressed: () {
                            context.read<SigninCubit>().signinWithGoogle();
                          },
                          image: Assets.assetsImagesGoogle,
                          title: ' تسجيل بواسطة جوجل',
                        ),
                      ],
                    )
                  : Container(),
              const SizedBox(
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
                        const SizedBox(
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
