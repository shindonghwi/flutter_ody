import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:odac_flutter_app/presentation/ui/colors.dart';
import 'package:odac_flutter_app/presentation/ui/typography.dart';
import 'package:odac_flutter_app/presentation/utils/Common.dart';

class RecordDateSelector extends HookWidget {
  const RecordDateSelector({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: getColorScheme(context).white,
        borderRadius: BorderRadius.circular(5),
      ),
      margin: EdgeInsets.only(top: 10, left: 15, right: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/imgs/icon_calendar.svg',
                      colorFilter: ColorFilter.mode(
                        getColorScheme(context).neutral60,
                        BlendMode.srcIn,
                      ),
                    ),
                    SizedBox(width: 6),
                    Text(
                      '2021 / 04 / 18',
                      style: getTextTheme(context).l2m.copyWith(
                            color: getColorScheme(context).neutral80,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/imgs/icon_time.svg',
                      colorFilter: ColorFilter.mode(
                        getColorScheme(context).neutral60,
                        BlendMode.srcIn,
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      '오전 10 : 55',
                      style: getTextTheme(context).l2m.copyWith(
                            color: getColorScheme(context).neutral80,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
