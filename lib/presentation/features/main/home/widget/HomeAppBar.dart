import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:odac_flutter_app/presentation/ui/colors.dart';
import 'package:odac_flutter_app/presentation/ui/typography.dart';
import 'package:odac_flutter_app/presentation/utils/Common.dart';

class HomeAppBar extends StatelessWidget with PreferredSizeWidget {
  const HomeAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => Size(double.infinity, 56);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leadingWidth: 150,
      toolbarHeight: 56,
      bottomOpacity: 0.0,
      elevation: 0.0,
      automaticallyImplyLeading: false,
      systemOverlayStyle: SystemUiOverlayStyle.light,
      backgroundColor: getColorScheme(context).primary100,
      leading: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          child: Row(
            children: [
              SizedBox(width: 20),
              Text(
                "4월",
                style: getTextTheme(context).t1b.copyWith(
                      color: getColorScheme(context).neutral100,
                    ),
              ),
              SizedBox(width: 8),
              Text(
                "2023년",
                style: getTextTheme(context).t3sb.copyWith(
                      color: getColorScheme(context).neutral100,
                    ),
              ),
              SvgPicture.asset(
                'assets/imgs/icon_down.svg',
                colorFilter: ColorFilter.mode(
                  getColorScheme(context).neutral100,
                  BlendMode.srcIn,
                ),
              )
            ],
          ),
        ),
      ),
      actions: [
        InkWell(
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SvgPicture.asset(
              "assets/imgs/icon_alrmoff.svg",
              colorFilter: ColorFilter.mode(
                getColorScheme(context).colorUI01,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
