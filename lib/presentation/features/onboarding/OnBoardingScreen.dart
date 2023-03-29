import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:odac_flutter_app/presentation/components/appbar/IconTitleTextAppBar.dart';
import 'package:odac_flutter_app/presentation/features/onboarding/provider/OnBoardingPageIndexProvider.dart';
import 'package:odac_flutter_app/presentation/features/onboarding/provider/OnBoardingPageViewController.dart';
import 'package:odac_flutter_app/presentation/features/onboarding/widget/PageViewWithIndicator.dart';
import 'package:odac_flutter_app/presentation/ui/colors.dart';
import 'package:odac_flutter_app/presentation/utils/Common.dart';

class OnBoardingScreen extends HookConsumerWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var pageController = ref.watch(pageViewControllerProvider);
    var currentPageIndex = ref.watch(currentPageIndexProvider);

    void moveNextPage() {
      pageController.animateToPage(
        currentPageIndex + 1,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }

    return Scaffold(
      backgroundColor: getColorScheme(context).colorBackground,
      appBar: IconTitleTextAppBar(
        actionText: "건너뛰기",
        actionTextCallback: () => moveNextPage(),
      ),
      body: PageViewWithIndicator(),
    );
  }
}
