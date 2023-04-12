import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:odac_flutter_app/presentation/features/input_profile/provider/InputProfilePageIndexProvider.dart';
import 'package:odac_flutter_app/presentation/features/input_profile/provider/InputProfilePageViewController.dart';
import 'package:odac_flutter_app/presentation/features/input_profile/widget/birthday/InputProfileBirthday.dart';
import 'package:odac_flutter_app/presentation/features/input_profile/widget/disease/InputProfileDisease.dart';
import 'package:odac_flutter_app/presentation/features/input_profile/widget/gender/InputProfileGender.dart';
import 'package:odac_flutter_app/presentation/features/input_profile/widget/height/InputProfileHeight.dart';
import 'package:odac_flutter_app/presentation/features/input_profile/widget/weight/InputProfileWeight.dart';
import 'package:odac_flutter_app/presentation/ui/colors.dart';
import 'package:odac_flutter_app/presentation/utils/Common.dart';

class SurveyPageView extends HookConsumerWidget {
  final int totalPageCount;
  final Function onBackPressed;

  SurveyPageView({
    Key? key,
    required this.totalPageCount,
    required this.onBackPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var currentPageIndex = ref.watch(inputProfileCurrentPageIndexProvider);
    final pageController = ref.read(inputProfilePageViewControllerProvider);

    final textEditingControllerList = [
      useTextEditingController(),
      useTextEditingController(),
      useTextEditingController(),
    ];

    useEffect(() {
      setPageControllerAddListener(pageController, ref);
      return () => disposePageController(pageController);
    }, [pageController]);

    return WillPopScope(
      onWillPop: () async => onBackPressed.call(),
      child: Column(
        children: [
          TweenAnimationBuilder<double>(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
            tween: Tween<double>(
              begin: 0,
              end: (currentPageIndex + 1) / totalPageCount,
            ),
            builder: (context, value, _) => Container(
              height: 6,
              child: LinearProgressIndicator(
                value: value,
                color: getColorScheme(context).primary100,
                backgroundColor: getColorScheme(context).neutral20,
              ),
            ),
          ),
          Expanded(
            child: PageView(
              controller: pageController,
              physics: NeverScrollableScrollPhysics(),
              children: [
                InputProfileGender(),
                InputProfileBirthday(controller: textEditingControllerList[0]),
                InputProfileHeight(controller: textEditingControllerList[1]),
                InputProfileWeight(controller: textEditingControllerList[2]),
                InputProfileDisease(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /** 페이지 컨트롤러 리스너 셋팅 */
  void setPageControllerAddListener(PageController pageController, WidgetRef ref) {
    pageController.addListener(() {
      ref.read(inputProfileCurrentPageIndexProvider.notifier).state = pageController.page!.round();
    });
  }

  /** 페이지 컨트롤러 해제 */
  void disposePageController(PageController pageController) {
    pageController.dispose();
  }
}
