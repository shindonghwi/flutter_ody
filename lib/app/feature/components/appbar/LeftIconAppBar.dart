import 'package:flutter/material.dart';
import 'package:odac_flutter_app/app/utils/Common.dart';

/**
 * @feature: 왼쪽에 뒤로가기 버튼이 있는 앱바
 *
 * @author: 2023/02/20 3:08 PM donghwishin
 */
class LeftIconAppBar extends StatelessWidget with PreferredSizeWidget {
  final leftIcon;

  LeftIconAppBar({Key? key, this.leftIcon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: getColorScheme(context).background,
      elevation: 0,
      leading: this.leftIcon,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56);
}
