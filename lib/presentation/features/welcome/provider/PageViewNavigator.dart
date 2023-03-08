import 'package:flutter/material.dart';
import 'package:odac_flutter_app/presentation/features/welcome/model/PageAction.dart';

class PageViewNavigatorProvider extends ChangeNotifier {
  final PageController _pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  int _currentPage = 0;

  PageController get pageController => _pageController;

  int get currentPage => _currentPage;

  Future<bool> changePage(BuildContext context, PageAction action) async {
    debugPrint("$action || currentPage: ${_pageController.page}");

    int currentPage = _pageController.page!.toInt();

    if (action == PageAction.NEXT) {
      _pageController.nextPage(
          duration: kTabScrollDuration, curve: Curves.ease);
      debugPrint("next");
    } else if (action == PageAction.PREVIOUS) {
      if (currentPage == 0) {
        Navigator.pop(context);
        return true;
      }

      _pageController.previousPage(
          duration: kTabScrollDuration, curve: Curves.ease);
      debugPrint("previous");
    }
    return true;
  }
}
