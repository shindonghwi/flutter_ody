import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ody_flutter_app/presentation/components/button/fill/FillButton.dart';
import 'package:ody_flutter_app/presentation/components/button/model/ButtonNotifier.dart';
import 'package:ody_flutter_app/presentation/components/button/model/ButtonSizeType.dart';
import 'package:ody_flutter_app/presentation/components/button/model/ButtonState.dart';
import 'package:ody_flutter_app/presentation/features/onboarding/provider/OnBoardingPageIndexProvider.dart';
import 'package:ody_flutter_app/presentation/features/onboarding/provider/OnBoardingPageViewController.dart';
import 'package:ody_flutter_app/presentation/features/onboarding/widget/IndicatorDot.dart';
import 'package:ody_flutter_app/presentation/features/onboarding/widget/OnBoardingPageItem.dart';
import 'package:ody_flutter_app/presentation/navigation/PageMoveUtil.dart';
import 'package:ody_flutter_app/presentation/navigation/Route.dart';
import 'package:ody_flutter_app/presentation/utils/Common.dart';

/**
 * @feature: PageView + Indicator 를 함께 사용하는 위젯
 * @author: 2023/03/29 4:44 PM donghwishin
 */
class PageViewWithIndicator extends HookConsumerWidget {
  const PageViewWithIndicator({super.key});

  bool onBackPressed(PageController pageController) {
    if (pageController.page!.round() == 0) {
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
    var pageController = ref.watch(onBoardingPageViewControllerProvider);
    var currentPageIndex = ref.watch(onBoardingCurrentPageIndexProvider);
    final List<Widget> pages = setPages();

    useEffect(() {
      setPageControllerAddListener(pageController, ref);
      return () => disposePageController(pageController);
    }, [pageController]);

    return Container(
      margin: const EdgeInsets.only(top: 8, bottom: 24),
      child: Column(
        children: [
          _pageItems(context, pageController, pages),
          const SizedBox(height: 0),
          _indicator(pages, currentPageIndex),
          _nextButton(context, pageController, pages.length),
        ],
      ),
    );
  }

  /// 페이지 컨트롤러 아이템 셋팅
  List<OnBoardingPageItem> setPages() {
    return [
      OnBoardingPageItem(
        imagePath: "assets/imgs/image_onboarding_1.png",
        title: getAppLocalizations(useContext()).onboarding_page1_title,
      ),
      OnBoardingPageItem(
        imagePath: "assets/imgs/image_onboarding_2.png",
        title: getAppLocalizations(useContext()).onboarding_page2_title,
      ),
      OnBoardingPageItem(
        imagePath: "assets/imgs/image_onboarding_3.png",
        title: getAppLocalizations(useContext()).onboarding_page3_title,
      ),
    ];
  }

  /// 페이지 컨트롤러 리스너 셋팅
  void setPageControllerAddListener(PageController pageController, WidgetRef ref) {
    pageController.addListener(
      () => ref.read(onBoardingCurrentPageIndexProvider.notifier).state =
          pageController.page!.round(),
    );
  }

  /// 페이지 컨트롤러 해제
  void disposePageController(PageController pageController) => pageController.dispose();

  /// 위젯: 페이지 뷰 아이템
  Widget _pageItems(BuildContext context, PageController pageController, List<Widget> pages) {
    return SizedBox(
      width: getMediaQuery(context).size.width,
      height: getMediaQuery(context).size.height * 0.65,
      child: WillPopScope(
        onWillPop: () async => onBackPressed.call(pageController),
        child: PageView(
          physics: const BouncingScrollPhysics(),
          controller: pageController,
          children: pages,
        ),
      ),
    );
  }

  /// 위젯: 페이지 인디케이터
  Widget _indicator(List<Widget> pages, int currentPageIndex) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        pages.length,
        (index) => IndicatorDot(
          isSelected: index == currentPageIndex,
        ),
      ),
    );
  }

  /// 다음버튼
  Expanded _nextButton(BuildContext context, PageController pageController, int length) {
    return Expanded(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 45),
          child: FillButton(
            text: "${getAppLocalizations(context).common_signup} / ${getAppLocalizations(context).common_signin}",
            type: ButtonSizeType.Normal,
            onPressed: () {
              Navigator.pushReplacement(
                context,
                nextFadeInOutScreen(RoutingScreen.Login.route),
              );
            },
            buttonProvider: StateNotifierProvider<ButtonNotifier, ButtonState>(
              (_) => ButtonNotifier(
                state: ButtonState.Activated,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
