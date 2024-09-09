import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fruits_app/constants.dart';
import 'package:fruits_app/core/services/shared_prefences_singleton.dart';
import 'package:fruits_app/core/utils/app_text_styles.dart';
import 'package:fruits_app/features/auth/login_view.dart';

class PageitemView extends StatelessWidget {
  const PageitemView({
    super.key,
    required this.image,
    required this.backgroungImage,
    required this.subTitle,
    required this.title,
    required this.isVisible,
  });

  final String image, backgroungImage;
  final String subTitle;
  final Widget title;
  final bool isVisible;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.5,
          child: Stack(
            children: [
              Positioned.fill(
                child: SvgPicture.asset(
                  backgroungImage,
                  fit: BoxFit.fill,
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: SvgPicture.asset(
                  image,
                ),
              ),
              Visibility(
                visible: isVisible,
                child: GestureDetector(
                  onTap: () {
                    Prefs.setBool(kIsOnBoardingViewSeen, true);
                    Navigator.pushReplacementNamed(
                        context, LoginView.routeName);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'تخط',
                      style: TextStyles.regular13
                          .copyWith(color: Color(0xFF949D9E)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 64,
        ),
        title,
        SizedBox(
          height: 24,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 37.0),
          child: Text(
            subTitle,
            textAlign: TextAlign.center,
            style: TextStyles.semiBold13.copyWith(color: Color(0xFF4E5456)),
          ),
        ),
      ],
    );
  }
}
