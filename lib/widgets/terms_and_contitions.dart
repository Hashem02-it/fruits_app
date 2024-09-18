import 'package:flutter/material.dart';
import 'package:fruits_app/constants.dart';
import 'package:fruits_app/core/utils/app_colors.dart';
import 'package:fruits_app/core/utils/app_text_styles.dart';
import 'package:fruits_app/widgets/custom_checkbox.dart';

class TermsAndContitions extends StatefulWidget {
  const TermsAndContitions({super.key, required this.onchanged});
  final ValueChanged<bool> onchanged;
  @override
  State<TermsAndContitions> createState() => _TermsAndContitionsState();
}

class _TermsAndContitionsState extends State<TermsAndContitions> {
  bool isTermsAccepted = false;
  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(0, 0),
      child: Row(
        children: [
          CustomCheckbox(
            onChanged: (value) {
              isTermsAccepted = value;
              widget.onchanged(value);
              setState(() {});
            },
            isChecked: isTermsAccepted,
          ),
          SizedBox(
            width: 16,
          ),
          Expanded(
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'من خلال إنشاء حساب ، فإنك توافق على',
                    style: TextStyles.semiBold13.copyWith(
                      color: Color(0xFF949D9E),
                    ),
                  ),
                  TextSpan(
                    text: ' الشروط والأحكام الخاصة بنا',
                    style: TextStyles.semiBold13.copyWith(
                      color: AppColors.lightprimaryColor,
                    ),
                  ),
                  TextSpan(
                    text: ' ',
                    style: TextStyles.semiBold13.copyWith(),
                  ),
                  TextSpan(
                    text: 'الخاصة',
                    style: TextStyles.semiBold13.copyWith(
                      color: AppColors.lightprimaryColor,
                    ),
                  ),
                  TextSpan(
                    text: ' بنا',
                    style: TextStyles.semiBold13.copyWith(
                      color: AppColors.lightprimaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
