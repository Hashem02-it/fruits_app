import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fruits_app/core/utils/app_images.dart';

class NotificationWedget extends StatelessWidget {
  const NotificationWedget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: const ShapeDecoration(
          shape: OvalBorder(),
          color: Color.fromRGBO(31, 61, 120, 0.2) // 50% transparent
          ),
      child: SvgPicture.asset(Assets.assetsImagesNotifiacationIcon),
    );
  }
}
