import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PageitemView extends StatelessWidget {
  const PageitemView(
      {super.key,
      required this.image,
      required this.backgroungImage,
      required this.subTitle,
      required this.title});

  final String image, backgroungImage;
  final String subTitle;
  final Widget title;
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
            ],
          ),
        )
      ],
    );
  }
}
