import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:fruits_app/constants.dart';
import 'package:fruits_app/core/services/shared_prefences_singleton.dart';
import 'package:fruits_app/core/utils/app_colors.dart';
import 'package:fruits_app/features/auth/signin_view.dart';
import 'package:fruits_app/features/splash/presentation/views/widgets/onboarding_pageview.dart';
import 'package:fruits_app/widgets/custom_button.dart';

class OnBoardingViewBody extends StatefulWidget {
  const OnBoardingViewBody({super.key});

  @override
  State<OnBoardingViewBody> createState() => _OnBoardingViewBodyState();
}

class _OnBoardingViewBodyState extends State<OnBoardingViewBody> {
  late PageController pageController;
  var currentPage = 0;
  @override
  void initState() {
    pageController = PageController();
    pageController.addListener(() {
      currentPage = pageController.page!.round();
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: OnboardingPageview(
          pageController: pageController,
        )),
        DotsIndicator(
          dotsCount: 2,
          decorator: DotsDecorator(
            activeColor: AppColors.primaryColor,
            color: currentPage == 1
                ? AppColors.primaryColor
                : AppColors.primaryColor.withOpacity(.5),
          ),
        ),
        SizedBox(
          height: 29,
        ),
        Visibility(
          maintainSize: true,
          maintainAnimation: true,
          maintainState: true,
          visible: currentPage == 1 ? true : false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kHorizantalPadding),
            child: CustomButton(
                onPressed: () {
                  Prefs.setBool(kIsOnBoardingViewSeen, true);
                  Navigator.pushReplacementNamed(context, SigninView.routeName);
                },
                text: 'ابدأ الان'),
          ),
        ),
        SizedBox(
          height: 43,
        ),
      ],
    );
  }
}
