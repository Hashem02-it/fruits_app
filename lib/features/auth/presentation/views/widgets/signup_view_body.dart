import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits_app/constants.dart';
import 'package:fruits_app/core/helper_functions/errorsnackbar.dart';
import 'package:fruits_app/features/auth/presentation/views/cubits/signup_cubit/signup_cubit.dart';
import 'package:fruits_app/widgets/custom_button.dart';
import 'package:fruits_app/widgets/custom_textfield.dart';
import 'package:fruits_app/widgets/havean_account.dart';
import 'package:fruits_app/widgets/password_field.dart';
import 'package:fruits_app/widgets/terms_and_contitions.dart';

class SignupViewBody extends StatefulWidget {
  const SignupViewBody({super.key});

  @override
  State<SignupViewBody> createState() => _SignupViewBodyState();
}

class _SignupViewBodyState extends State<SignupViewBody> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  late String email, password, name;
  late bool isTermsAccepted = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kHorizantalPadding),
        child: Form(
          key: formKey,
          autovalidateMode: autovalidateMode,
          child: Column(
            children: [
              const SizedBox(
                height: 24,
              ),
              CustomTextFormField(
                onSaved: (value) {
                  name = value!;
                },
                keyboardType: TextInputType.text,
                hintText: 'الاسم كامل',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'الرجاء إدخال الاسم الكامل';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 16,
              ),
              CustomTextFormField(
                onSaved: (value) {
                  email = value!;
                },
                keyboardType: TextInputType.emailAddress,
                hintText: 'البريد الإلكتروني',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'الرجاء إدخال البريد الإلكتروني';
                  }

                  // تحقق أن البريد ينتهي بـ @just.edu.jo
                  final regex = RegExp(r'^[\w\.-]+@[\w-]+\.(just\.edu\.jo)$');

                  // RegExp(r'.*');

                  if (!regex.hasMatch(value)) {
                    return 'البريد الإلكتروني يجب أن ينتهي بـ YourCollege.just.edu.jo@';
                  }

                  return null;
                },
              ),
              const SizedBox(
                height: 16,
              ),
              PasswordField(
                onSaved: (value) {
                  password = value!;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'الرجاء إدخال كلمة المرور';
                  } else if (value.length < 6) {
                    return 'كلمة المرور يجب أن تكون 6 أحرف على الأقل';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 16,
              ),
              TermsAndContitions(
                onchanged: (value) {
                  isTermsAccepted = value;
                  setState(() {});
                },
              ),
              const SizedBox(
                height: 16,
              ),
              const SizedBox(height: 16),
              CustomButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                      if (isTermsAccepted) {
                        context
                            .read<SignupCubit>()
                            .createUserWithEmailAndPassword(
                                email, password, name);
                        buildErrorBar(context, 'تم انشاء الحساب بنجاح');
                      } else {
                        buildErrorBar(context, 'الرجاء قبول الشروط والإحكام');
                      }
                    } else {
                      setState(() {
                        autovalidateMode = AutovalidateMode.always;
                      });
                    }
                  },
                  text: 'إنشاء حساب جديد'),
              const SizedBox(
                height: 26,
              ),
              const HaveAccountWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
