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
        padding: EdgeInsets.symmetric(horizontal: kHorizantalPadding),
        child: Form(
          key: formKey,
          autovalidateMode: autovalidateMode,
          child: Column(
            children: [
              SizedBox(
                height: 24,
              ),
              CustomTextFormField(
                onSaved: (value) {
                  name = value!;
                },
                keyboardType: TextInputType.visiblePassword,
                hintText: 'الاسم كامل',
              ),
              SizedBox(
                height: 16,
              ),
              CustomTextFormField(
                onSaved: (value) {
                  email = value!;
                },
                keyboardType: TextInputType.visiblePassword,
                hintText: 'البريد الإلكتروني',
              ),
              SizedBox(
                height: 16,
              ),
              PasswordField(
                onSaved: (value) {
                  password = value!;
                },
              ),
              SizedBox(
                height: 16,
              ),
              TermsAndContitions(
                onchanged: (value) {
                  isTermsAccepted = value;
                  setState(() {});
                },
              ),
              SizedBox(
                height: 16,
              ),
              CustomButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                      if (isTermsAccepted) {
                        context
                            .read<SignupCubit>()
                            .createUserWithEmailAndPassword(
                                email, password, name);
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
              SizedBox(
                height: 26,
              ),
              HaveAccountWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
