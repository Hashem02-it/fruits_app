import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fruits_app/core/utils/app_images.dart';
import 'package:fruits_app/core/utils/app_text_styles.dart';

class SocialLoginButton extends StatelessWidget {
  const SocialLoginButton(
      {super.key,
      required this.image,
      required this.title,
      required this.onPressed});
  final String image;
  final String title;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      width: double.infinity,
      child: TextButton(
        style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 1.0,
            color: Color(0xFFDCDEDE),
          ),
          borderRadius: BorderRadius.circular(16),
        )),
        onPressed: onPressed,
        child: ListTile(
          visualDensity: VisualDensity(vertical: VisualDensity.minimumDensity),
          leading: SvgPicture.asset(image),
          title: Text(
            title,
            style: TextStyles.semiBold16,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
