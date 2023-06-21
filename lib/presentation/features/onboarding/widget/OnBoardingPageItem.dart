import 'package:flutter/material.dart';
import 'package:ody_flutter_app/presentation/ui/colors.dart';
import 'package:ody_flutter_app/presentation/ui/typography.dart';
import 'package:ody_flutter_app/presentation/utils/Common.dart';

class OnBoardingPageItem extends StatelessWidget {
  final String imagePath;
  final String title;

  const OnBoardingPageItem({
    super.key,
    required this.imagePath,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: getTextTheme(context).h4b.copyWith(
            color: getColorScheme(context).colorText,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 40),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.5,
          child: Image.asset(
            imagePath,
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }
}
