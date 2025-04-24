import 'package:flutter/material.dart';
import 'package:fruits_app/core/utils/app_text_styles.dart';
import 'package:fruits_app/widgets/noftication_widgets.dart';

AppBar buildAppBar({required String title}) {
  return AppBar(
    actions: const [
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: NotificationWedget(),
      )
    ],
    backgroundColor: Colors.transparent,
    elevation: 0,
    title: const Text(
      ' الأكثر مبيعا',
      textAlign: TextAlign.center,
      style: TextStyles.bold19,
    ),
  );
}
