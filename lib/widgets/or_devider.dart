import 'package:flutter/material.dart';
import 'package:fruits_app/core/utils/app_text_styles.dart';

class OrDevider extends StatelessWidget {
  const OrDevider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            color: Color(0xFFDCDEDE),
          ),
        ),
        SizedBox(
          width: 18,
        ),
        Text(
          'أو',
          textAlign: TextAlign.center,
          style: TextStyles.semiBold16,
        ),
        SizedBox(
          width: 18,
        ),
        Expanded(
          child: Divider(
            color: Color(0xFFDCDEDE),
          ),
        ),
      ],
    );
  }
}
