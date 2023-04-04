import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:odac_flutter_app/presentation/components/appbar/model/AppBarIcon.dart';
import 'package:odac_flutter_app/presentation/ui/colors.dart';
import 'package:odac_flutter_app/presentation/ui/typography.dart';
import 'package:odac_flutter_app/presentation/utils/Common.dart';

class IconTitleTextAppBar extends StatelessWidget with PreferredSizeWidget {
  final AppBarIcon? leadingIcon;
  final String title;
  final bool isCenterTitle;
  final String actionText;
  final Function? actionTextCallback;

  const IconTitleTextAppBar({
    super.key,
    this.leadingIcon = null,
    this.title = "",
    this.isCenterTitle = true,
    this.actionText = "",
    this.actionTextCallback = null,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: getColorScheme(context).colorUI01,
      bottomOpacity: 0.0,
      elevation: 0.0,
      leadingWidth: 56,
      automaticallyImplyLeading: false,
      leading: leadingIcon != null
          ? InkWell(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SvgPicture.asset(
                  leadingIcon!.path,
                  width: 56,
                  height: 56,
                  colorFilter: ColorFilter.mode(
                    leadingIcon!.tint != null
                        ? leadingIcon!.tint!
                        : getColorScheme(context).colorUI01,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            )
          : SizedBox(),
      title: Text(
        title,
        style: getTextTheme(context).l1.copyWith(
              color: getColorScheme(context).neutral10,
            ),
      ),
      centerTitle: isCenterTitle,
      actions: [
        Align(
          alignment: Alignment.center,
          child: InkWell(
            onTap: () => actionTextCallback?.call(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 18),
              child: Text(
                actionText,
                style: getTextTheme(context).l3.copyWith(
                      color: getColorScheme(context).neutral60,
                    ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size(double.infinity, 56);
}
