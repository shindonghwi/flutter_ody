import 'package:flutter/material.dart';
import 'package:odac_flutter_app/app/feature/welcome/model/PageAction.dart';
import 'package:odac_flutter_app/app/feature/welcome/widget/WelcomeAge.dart';
import 'package:odac_flutter_app/app/feature/welcome/widget/WelcomeHeightWeight.dart';
import 'package:odac_flutter_app/app/feature/welcome/widget/WelcomeIntroduce.dart';

/**
 * @feature: 최초로 사용하는 사용자에게 보여지는 화면이다.
 *
 * @author: 2023/02/14 1:40 PM donghwishin
 *
 * @description{
 *   PageView로 구성되어 있으며,
 *   각 페이지는
 *    1. 만성질환 관리 소개
 *    2. 나이 입력
 *    3. 키, 몸무게 입력
 * }
 */
class WelcomeScreen extends StatelessWidget {
  PageController _controller = PageController(
    initialPage: 0,
    keepPage: false,
  );

  WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        physics: NeverScrollableScrollPhysics(),
        children: [
          WelcomeIntroduce(changePage: changePage),
          WelcomeAge(changePage: changePage),
          WelcomeHeightWeight(changePage: changePage),
        ],
      ),
    );
  }

  Future<void> changePage(BuildContext context, PageAction action) async {
    debugPrint("$action || currentPage: ${_controller.page}");

    int currentPage = _controller.page!.toInt();

    if (action == PageAction.NEXT) {
      _controller.nextPage(duration: kTabScrollDuration, curve: Curves.ease);
      debugPrint("next");
    } else if (action == PageAction.PREVIOUS) {

      if(currentPage == 0){
        Navigator.pop(context);
        return;
      }

      _controller.previousPage(
          duration: kTabScrollDuration, curve: Curves.ease);
      debugPrint("previous");
    }
  }
}
