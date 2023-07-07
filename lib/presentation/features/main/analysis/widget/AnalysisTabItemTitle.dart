import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ody_flutter_app/presentation/ui/colors.dart';
import 'package:ody_flutter_app/presentation/ui/typography.dart';
import 'package:ody_flutter_app/presentation/utils/Common.dart';

class AnalysisTabItemTitle extends StatelessWidget {
  final String title;
  final Function? movePage;

  const AnalysisTabItemTitle({
    super.key,
    required this.title,
    this.movePage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(4),
            onTap: () => movePage?.call(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: getTextTheme(context).b2sb.copyWith(
                          color: getColorScheme(context).neutral70,
                        ),
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  SvgPicture.asset(
                    "assets/imgs/icon_next_1_small.svg",
                    width: 24,
                    height: 24,
                    colorFilter: ColorFilter.mode(
                      getColorScheme(context).neutral70,
                      BlendMode.srcIn,
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
