import 'package:flutter/material.dart';
import 'package:fruits_app/core/utils/app_colors.dart';
import 'package:fruits_app/core/utils/app_images.dart';
import 'package:fruits_app/core/utils/app_text_styles.dart';
import 'package:fruits_app/features/splash/presentation/views/widgets/pageitem_view.dart';

class OnboardingPageview extends StatelessWidget {
  const OnboardingPageview({super.key, required this.pageController});

  final PageController pageController;
  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: pageController,
      children: [
        PageitemView(
          isVisible: true,
          image: Assets.assetsImagesItemViewpage1Image,
          backgroungImage: Assets.assetsImagesItemViewpage1BackgroundImage,
          subTitle:
              'اكتشف تجربة تسوق فريدة مع JUST MART. استكشف مجموعتنا الواسعة من المنتجات الممتازة واحصل على أفضل العروض والجودة العالية.',
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'مرحبًا بك في',
                style: TextStyles.bold23,
              ),
              Text(
                ' MART',
                style:
                    TextStyles.bold23.copyWith(color: AppColors.seconderyColor),
              ),
              Text(
                'JUST',
                style:
                    TextStyles.bold23.copyWith(color: AppColors.primaryColor),
              ),
            ],
          ),
        ),
        const PageitemView(
          isVisible: false,
          image: Assets.assetsImagesItemViewpage2Image,
          backgroungImage: Assets.assetsImagesItemViewpage2BackgroundImage,
          subTitle:
              'نقدم لك أفضل المنتجات المختارة بعناية. اطلع على التفاصيل والصور والتقييمات لتتأكد من اختيار المنتجات المثالية',
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'ابحث وتسوق',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Cairo'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
