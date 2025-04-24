import 'package:flutter/material.dart';

import 'package:fruits_app/core/utils/app_text_styles.dart';
import 'package:fruits_app/widgets/noftication_widgets.dart';

AppBar customAppBar(context, {required String title}) {
  return AppBar(
      backgroundColor: Colors.white,
      actions: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: NotificationWedget(),
        )
      ],
      leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios_new,
          )),
      centerTitle: true,
      title: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyles.bold19,
      ));
}
