import 'package:flutter/material.dart';
import 'package:fruits_app/features/splash/presentation/views/widgets/onboarding_pageview.dart';

class OnBoardingViewBody extends StatelessWidget {
  const OnBoardingViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: OnboardingPageview()),
      ],
    );
  }
}
