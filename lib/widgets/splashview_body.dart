import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fruits_app/core/utils/app_images.dart';
import 'package:fruits_app/features/splash/presentation/views/on_boarding/presentation/views/on_boarding.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody> {
  @override
  void initState() {
    excuteNavigation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SvgPicture.asset(Assets.assetsImagesPlant),
          ],
        ),
        SvgPicture.asset(Assets.assetsImagesLogo),
        SvgPicture.asset(
          Assets.assetsImagesSplashBottom,
          fit: BoxFit.fill,
        )
      ],
    );
  }

  void excuteNavigation() {
    Future.delayed(
      Duration(seconds: 3),
      () {
        Navigator.pushReplacementNamed(context, OnBoardingView.routeName);
      },
    );
  }
}
