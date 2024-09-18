import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fruits_app/core/utils/app_colors.dart';
import 'package:fruits_app/core/utils/app_text_styles.dart';
import 'package:fruits_app/features/auth/signin_view.dart';
import 'package:fruits_app/features/auth/presentation/views/signup_view.dart';

class HaveAccountWidget extends StatelessWidget {
  const HaveAccountWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: 'تمتلك حساب بالفعل؟',
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
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.pop(context);
              },
            text: 'تسجيل دخول',
            style:
                TextStyles.semiBold16.copyWith(color: AppColors.primaryColor),
          ),
        ],
      ),
    );
  }
}
