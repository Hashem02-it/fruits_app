import 'package:flutter/material.dart';
import 'package:fruits_app/constants.dart';
import 'package:fruits_app/core/utils/app_colors.dart';
import 'package:fruits_app/core/utils/app_images.dart';
import 'package:fruits_app/core/utils/app_text_styles.dart';
import 'package:fruits_app/widgets/custom_button.dart';
import 'package:fruits_app/widgets/custom_textfield.dart';
import 'package:fruits_app/widgets/donthave_account.dart';
import 'package:fruits_app/widgets/or_devider.dart';
import 'package:fruits_app/widgets/social_login_button.dart';

class SigninViewBody extends StatelessWidget {
  const SigninViewBody({super.key});
  static const String routeName = 'LoginViewBody';
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
            DontHaveAccountWidget(),
            SizedBox(
              height: 33,
            ),
            OrDevider(),
            SizedBox(
              height: 16,
            ),
            SocialLoginButton(
              onPressed: () {},
              image: Assets.assetsImagesGoogle,
              title: ' تسجيل بواسطة جوجل',
            ),
            SizedBox(
              height: 16,
            ),
            SocialLoginButton(
              onPressed: () {},
              image: Assets.assetsImagesApple,
              title: 'تسجيل بواسطة أبل',
            ),
            SizedBox(
              height: 16,
            ),
            SocialLoginButton(
              onPressed: () {},
              image: Assets.assetsImagesFacebook,
              title: 'تسجيل بواسطة فيسبوك',
            ),
          ],
        ),
      ),
    );
  }
}
