import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ody_flutter_app/presentation/components/appbar/model/AppBarIcon.dart';
import 'package:ody_flutter_app/presentation/ui/colors.dart';
import 'package:ody_flutter_app/presentation/ui/typography.dart';
import 'package:ody_flutter_app/presentation/utils/Common.dart';

class IconTitleTextAppBar extends StatelessWidget implements PreferredSizeWidget {
  final AppBarIcon? leadingIcon;
  final String title;
  final bool isCenterTitle;
  final String actionText;
  final bool actionIconEnable;
  final Color? actionTextColor;
  final Function? actionTextCallback;

  const IconTitleTextAppBar({
    super.key,
    this.leadingIcon,
    this.title = "",
    this.isCenterTitle = true,
    this.actionText = "",
    this.actionIconEnable = true,
    this.actionTextColor,
    this.actionTextCallback,
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
        onTap: () => leadingIcon?.onPressed.call(),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SvgPicture.asset(
            leadingIcon!.path,
            width: 56,
            height: 56,
            colorFilter: ColorFilter.mode(
              leadingIcon!.tint != null
                  ? leadingIcon!.tint!
                  : getColorScheme(context).neutral100,
              BlendMode.srcIn,
            ),
          ),
        ),
      )
          : const SizedBox(),
      title: Text(
        title,
        style: getTextTheme(context).l1m.copyWith(
          color: getColorScheme(context).colorText,
        ),
      ),
      centerTitle: isCenterTitle,
      actions: [
        SizedBox(
          height: double.infinity,
          child: InkWell(
            enableFeedback: actionIconEnable,
            onTap: () {
              if (actionIconEnable == true){
                actionTextCallback?.call();
              }
            },
            child: Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
                child: Text(
                  actionText,
                  style: getTextTheme(context).t4m.copyWith(
                    color: actionTextColor ?? getColorScheme(context).neutral70,
                  ),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, 56);
}
