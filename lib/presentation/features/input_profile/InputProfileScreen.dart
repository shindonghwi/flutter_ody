import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ody_flutter_app/presentation/components/appbar/IconTitleIconAppBar.dart';
import 'package:ody_flutter_app/presentation/components/appbar/model/AppBarIcon.dart';
import 'package:ody_flutter_app/presentation/features/input_profile/provider/InputProfilePageIndexProvider.dart';
import 'package:ody_flutter_app/presentation/features/input_profile/provider/InputProfilePageViewController.dart';
import 'package:ody_flutter_app/presentation/features/input_profile/widget/SurveyPageView.dart';
import 'package:ody_flutter_app/presentation/ui/colors.dart';
import 'package:ody_flutter_app/presentation/utils/Common.dart';

class InputProfileScreen extends HookConsumerWidget {
  final int initPageNumber;

  const InputProfileScreen({
    Key? key,
    this.initPageNumber = 0,
  }) : super(key: key);

  bool onBackPressed(BuildContext context, PageController pageController) {
    if (pageController.page!.round() == 0) {
      Navigator.of(context).pop();
      return true;
    } else {
      pageController.previousPage(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
      );
      return false;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<String> titleList = [
      getAppLocalizations(context).input_profile_gender,
      getAppLocalizations(context).input_profile_birthday,
      getAppLocalizations(context).input_profile_height,
      getAppLocalizations(context).input_profile_weight,
      getAppLocalizations(context).input_profile_disease,
    ];
    var currentPageIndex = ref.watch(inputProfileCurrentPageIndexProvider);
    final pageController = ref.read(inputProfilePageViewControllerProvider);
    final currentPageTitle = titleList[currentPageIndex];

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        pageController.jumpToPage(initPageNumber);
      });
    }, []);

    return Scaffold(
      backgroundColor: getColorScheme(context).colorUI01,
      appBar: IconTitleIconAppBar(
        leadingIcon: AppBarIcon(
          path: "assets/imgs/icon_back.svg",
          onPressed: () => onBackPressed(context, pageController),
          tint: getColorScheme(context).colorText,
        ),
        title: currentPageTitle,
      ),
      body: SafeArea(
        child: SurveyPageView(
          totalPageCount: titleList.length,
          onBackPressed: () => onBackPressed(context, pageController),
        ),
      ),
    );
  }
}
