import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:odac_flutter_app/presentation/components/common/KeepAlivePage.dart';
import 'package:odac_flutter_app/presentation/features/welcome/provider/PageViewNavigator.dart';
import 'package:odac_flutter_app/presentation/features/welcome/widget/WelcomeAge.dart';
import 'package:odac_flutter_app/presentation/features/welcome/widget/WelcomeBirthday.dart';
import 'package:odac_flutter_app/presentation/features/welcome/widget/WelcomeChronicDisease.dart';
import 'package:odac_flutter_app/presentation/features/welcome/widget/WelcomeEnd.dart';
import 'package:odac_flutter_app/presentation/features/welcome/widget/WelcomeGender.dart';
import 'package:odac_flutter_app/presentation/features/welcome/widget/WelcomeHeight.dart';
import 'package:odac_flutter_app/presentation/features/welcome/widget/WelcomeMentalDisease.dart';
import 'package:odac_flutter_app/presentation/features/welcome/widget/WelcomeNickname.dart';
import 'package:odac_flutter_app/presentation/features/welcome/widget/WelcomePreventionDisease.dart';
import 'package:odac_flutter_app/presentation/features/welcome/widget/WelcomeWeight.dart';
import 'package:provider/provider.dart';

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
class WelcomeScreen extends StatefulWidget {
  WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (BuildContext context) => PageViewNavigatorProvider())
      ],
      child: Scaffold(
        body: PageViewWidget(),
      ),
    );
  }
}

class PageViewWidget extends HookWidget {
  late PageViewNavigatorProvider _PageViewNavigatorProvider;

  PageViewWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _PageViewNavigatorProvider = Provider.of<PageViewNavigatorProvider>(context);
    return PageView(
      controller: _PageViewNavigatorProvider.pageController,
      physics: NeverScrollableScrollPhysics(),
      children: [
        KeepAlivePage(child: WelcomeNickname()),
        KeepAlivePage(child: WelcomeAge()),
        KeepAlivePage(child: WelcomeGender()),
        KeepAlivePage(child: WelcomeBirthday()),
        KeepAlivePage(child: WelcomeHeight()),
        KeepAlivePage(child: WelcomeWeight()),
        KeepAlivePage(child: WelcomeChronicDisease()),
        KeepAlivePage(child: WelcomeMentalDisease()),
        KeepAlivePage(child: WelcomePreventionDisease()),
        KeepAlivePage(child: WelcomeEnd()),
      ],
    );
  }
}
