import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:odac_flutter_app/presentation/features/onboarding/provider/OnBoardingPageIndexProvider.dart';
import 'package:odac_flutter_app/presentation/features/onboarding/provider/OnBoardingPageViewController.dart';
import 'package:odac_flutter_app/presentation/features/onboarding/widget/IndicatorDot.dart';
import 'package:odac_flutter_app/presentation/features/onboarding/widget/OnBoardingPageItem.dart';
import 'package:odac_flutter_app/presentation/utils/Common.dart';

/**
 * @feature: PageView + Indicator 를 함께 사용하는 위젯
 * @author: 2023/03/29 4:44 PM donghwishin
 */
class PageViewWithIndicator extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var pageController = ref.watch(pageViewControllerProvider);
    var currentPageIndex = ref.watch(currentPageIndexProvider);
    final List<Widget> pages = setPages();

    useEffect(() {
      setPageControllerAddListener(pageController, ref);
      return () => disposePageController(pageController);
    }, [pageController]);

    return Container(
      margin: EdgeInsets.only(top: 43, bottom: 70),
      child: Column(
        children: [
          _Indicator(pages, currentPageIndex),
          _PageItems(pageController, pages),
        ],
      ),
    );
  }

  /** 페이지 컨트롤러 아이템 셋팅 */
  List<OnBoardingPageItem> setPages() {
    return [
      OnBoardingPageItem(
        imagePath: "assets/imgs/onboarding_1.png",
        title: getAppLocalizations(useContext()).onboarding_page1_title,
        subTitle: getAppLocalizations(useContext()).onboarding_page1_subtitle,
      ),
      OnBoardingPageItem(
        imagePath: "assets/imgs/onboarding_1.png",
        title: getAppLocalizations(useContext()).onboarding_page2_title,
        subTitle: getAppLocalizations(useContext()).onboarding_page2_subtitle,
      ),
      OnBoardingPageItem(
        imagePath: "assets/imgs/onboarding_1.png",
        title: getAppLocalizations(useContext()).onboarding_page3_title,
        subTitle: getAppLocalizations(useContext()).onboarding_page3_subtitle,
      ),
    ];
  }

  /** 페이지 컨트롤러 리스너 셋팅 */
  void setPageControllerAddListener(PageController pageController, WidgetRef ref) {
    pageController.addListener(
      () => ref.read(currentPageIndexProvider.notifier).state = pageController.page!.round(),
    );
  }

  /** 페이지 컨트롤러 해제 */
  void disposePageController(PageController pageController) {
    pageController.dispose();
  }

  /** 위젯: 페이지 뷰 아이템 */
  Expanded _PageItems(PageController pageController, List<Widget> pages) {
    return Expanded(
      child: PageView(
        physics: BouncingScrollPhysics(),
        controller: pageController,
        children: pages,
      ),
    );
  }

  /** 위젯: 페이지 인디케이터 */
  Row _Indicator(List<Widget> pages, int currentPageIndex) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        pages.length,
        (index) => IndicatorDot(
          isSelected: index == currentPageIndex,
        ),
      ),
    );
  }
}
