import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:odac_flutter_app/presentation/components/appbar/IconTitleTextAppBar.dart';
import 'package:odac_flutter_app/presentation/features/onboarding/widget/PageViewWithIndicator.dart';
import 'package:odac_flutter_app/presentation/navigation/PageMoveUtil.dart';
import 'package:odac_flutter_app/presentation/navigation/Route.dart';
import 'package:odac_flutter_app/presentation/ui/colors.dart';
import 'package:odac_flutter_app/presentation/utils/Common.dart';

class OnBoardingScreen extends HookConsumerWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  moveLoginPage(BuildContext context) {
    Navigator.push(
      context,
      nextSlideScreen(RoutingScreen.Login.route),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: getColorScheme(context).colorUI01,
      appBar: IconTitleTextAppBar(
        actionText: getAppLocalizations(context).common_skip,
        actionTextCallback: () => moveLoginPage(context),
      ),
      body: PageViewWithIndicator(),
    );
  }
}
