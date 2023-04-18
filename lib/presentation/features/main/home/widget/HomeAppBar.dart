import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:odac_flutter_app/presentation/ui/colors.dart';
import 'package:odac_flutter_app/presentation/utils/Common.dart';

class HomeAppBar extends StatelessWidget with PreferredSizeWidget {
  const HomeAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => Size(double.infinity, 56);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leadingWidth: 85,
      toolbarHeight: 56,
      bottomOpacity: 0.0,
      elevation: 0.0,
      automaticallyImplyLeading: false,
      systemOverlayStyle: SystemUiOverlayStyle.light,
      backgroundColor: getColorScheme(context).primary100,
      leading: Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: SvgPicture.asset(
          'assets/imgs/home_logo.svg',
          colorFilter: ColorFilter.mode(
            getColorScheme(context).white,
            BlendMode.srcIn,
          ),
        ),
      ),
      actions: [
        InkWell(
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal:16),
            child: SvgPicture.asset(
              "assets/imgs/icon_alram_off.svg",
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
