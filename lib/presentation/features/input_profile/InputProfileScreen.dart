import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:odac_flutter_app/presentation/components/appbar/IconTitleIconAppBar.dart';
import 'package:odac_flutter_app/presentation/components/appbar/model/AppBarIcon.dart';
import 'package:odac_flutter_app/presentation/ui/colors.dart';
import 'package:odac_flutter_app/presentation/utils/Common.dart';

class InputProfileScreen extends HookWidget {
  const InputProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getColorScheme(context).colorUI01,
      appBar: IconTitleIconAppBar(
        leadingIcon: AppBarIcon(
          path: "assets/imgs/icon_back.svg",
          onPressed: () {},
          tint: getColorScheme(context).colorText,
        ),
      ),
      body: Column(
        children: [
          Container(
            width: 10,
            color: Colors.red,
            height: 5,
          ),
          PageView(
            children: [
              Expanded(
                child: Container(
                  color: Colors.blue,
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.yellow,
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.green,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
