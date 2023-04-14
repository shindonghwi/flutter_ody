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
      child: Column(
        children: [
          Text(
            title,
            style: getTextTheme(context).h2.copyWith(
              color: getColorScheme(context).colorText,
            ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(top: 62),
              child: Column(
                children: [
                  Flexible(
                    flex: 78,
                    fit: FlexFit.tight,
                    child: Image.asset(
                      imagePath,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Flexible(
                    flex: 22,
                    fit: FlexFit.tight,
                    child: Container(
                      margin: EdgeInsets.only(top: 10),
                      child: Align(
                        alignment: Alignment.center,
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
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
