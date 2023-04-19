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
    AppBarIcon? this.leadingIcon = null,
    String this.title = "",
    bool this.isCenterTitle = true,
    String this.actionText = "",
    Function? this.actionTextCallback = null,
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
          : SizedBox(),
      title: Text(
        title,
        style: getTextTheme(context).l1m.copyWith(
              color: getColorScheme(context).colorText,
            ),
      ),
      centerTitle: isCenterTitle,
      actions: [
        Container(
          height: double.infinity,
          child: InkWell(
            onTap: () => actionTextCallback?.call(),
            child: Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
                child: Text(
                  actionText,
                  style: getTextTheme(context).t4m.copyWith(
                        color: getColorScheme(context).neutral70,
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
  Size get preferredSize => Size(double.infinity, 56);
}
