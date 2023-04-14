import 'package:flutter/material.dart';
import 'package:odac_flutter_app/presentation/ui/colors.dart';
import 'package:odac_flutter_app/presentation/ui/typography.dart';
import 'package:odac_flutter_app/presentation/utils/Common.dart';

class OnBoardingPageItem extends StatelessWidget {
  final String imagePath;
  final String title;
  final String subTitle;

  const OnBoardingPageItem({
    super.key,
    required this.imagePath,
    required this.title,
    required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Align(
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Text(
                title,
                style: getTextTheme(context).h2.copyWith(
                  color: getColorScheme(context).colorText,
                ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Flexible(
              flex: 10,
              fit: FlexFit.tight,
              child: Container(
                margin: EdgeInsets.only(top: 62),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Flexible(
              flex: 2,
              fit: FlexFit.tight,
              child: Container(
                margin: EdgeInsets.only(top: 46),
                child: Text(
                  subTitle,
                  style: getTextTheme(context).b2.copyWith(
                        color: getColorScheme(context).neutral50,
                      ),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
