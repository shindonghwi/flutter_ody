import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ody_flutter_app/presentation/components/appbar/model/AppBarIcon.dart';
import 'package:ody_flutter_app/presentation/ui/colors.dart';
import 'package:ody_flutter_app/presentation/ui/typography.dart';
import 'package:ody_flutter_app/presentation/utils/Common.dart';

class IconTitleIconAppBar extends StatelessWidget implements PreferredSizeWidget {
  final AppBarIcon? leadingIcon;
  final String title;
  final bool isCenterTitle;
  final AppBarIcon? actionIcon;

  const IconTitleIconAppBar({
    super.key,
    this.leadingIcon,
    this.title = "",
    this.isCenterTitle = true,
    this.actionIcon,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: getColorScheme(context).colorUI01,
      bottomOpacity: 0.0,
      elevation: 0.0,
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
                        : getColorScheme(context).colorUI01,
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
        Align(
          alignment: Alignment.center,
          child: actionIcon != null
              ? InkWell(
                  onTap: () => actionIcon?.onPressed.call(),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SvgPicture.asset(
                      actionIcon!.path,
                      width: 24,
                      height: 24,
                      colorFilter: ColorFilter.mode(
                        actionIcon!.tint != null
                            ? actionIcon!.tint!
                            : getColorScheme(context).colorUI01,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                )
              : const SizedBox(),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, 56);
}
