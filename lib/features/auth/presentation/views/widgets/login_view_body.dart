import 'package:flutter/material.dart';
import 'package:fruits_app/constants.dart';
import 'package:fruits_app/core/utils/app_colors.dart';
import 'package:fruits_app/core/utils/app_text_styles.dart';
import 'package:fruits_app/widgets/custom_button.dart';
import 'package:fruits_app/widgets/custom_textfield.dart';

class LoginViewBody extends StatelessWidget {
  const LoginViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kHorizantalPadding),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 24,
            ),
            CustomTextFormField(
              hintText: 'البريد الإلكتروني',
            ),
            SizedBox(
              height: 24,
            ),
            CustomTextFormField(
              keyboardType: TextInputType.visiblePassword,
              suffixIcon: Icon(
                Icons.visibility,
                color: Color(0xffC9CECF),
              ),
              hintText: 'كلمة المرور',
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
            CustomButton(onPressed: () {}, text: 'تسجيل دخول'),
            SizedBox(
              height: 33,
            ),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'لا تمتلك حساب؟',
                    style: TextStyles.semiBold16.copyWith(
                      color: Color(0xFF616A6B),
                    ),
                  ),
                  TextSpan(
                    text: ' ',
                    style: TextStyles.semiBold16.copyWith(
                      color: Color(0xFF616A6B),
                    ),
                  ),
                  TextSpan(
                    text: 'قم بانشاء حساب',
                    style: TextStyles.semiBold16
                        .copyWith(color: AppColors.primaryColor),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
