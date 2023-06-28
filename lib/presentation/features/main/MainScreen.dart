import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ody_flutter_app/presentation/features/main/analysis/AnalysisScreen.dart';
import 'package:ody_flutter_app/presentation/features/main/home/HomeScreen.dart';
import 'package:ody_flutter_app/presentation/features/main/home/model/CalendarSize.dart';
import 'package:ody_flutter_app/presentation/features/main/home/widget/HomeAppBar.dart';
import 'package:ody_flutter_app/presentation/features/main/home/widget/calendar/CalendarContainerView.dart';
import 'package:ody_flutter_app/presentation/features/main/home/widget/calendar/CalendarContentView.dart';
import 'package:ody_flutter_app/presentation/features/main/my/MyScreen.dart';
import 'package:ody_flutter_app/presentation/features/main/provider/MainTabIndexProvider.dart';
import 'package:ody_flutter_app/presentation/ui/colors.dart';
import 'package:ody_flutter_app/presentation/ui/typography.dart';
import 'package:ody_flutter_app/presentation/utils/Common.dart';
import 'package:ody_flutter_app/presentation/utils/dto/Pair.dart';

class MainScreen extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _currentIndex = ref.watch(mainTabIndexProvider);

    List<Pair> _iconList = [
      Pair('assets/imgs/icon_record_1.svg', getAppLocalizations(context).main_tab_record),
      Pair('assets/imgs/icon_analyzing.svg', getAppLocalizations(context).main_tab_analysis),
      Pair('assets/imgs/icon_mypage.svg', getAppLocalizations(context).main_tab_my),
    ];

    return Scaffold(
      extendBody: true,
      appBar: _currentIndex < _iconList.length - 1 ? const HomeAppBar() : null,
      body: Stack(
        children: [
          IndexedStack(
            index: _currentIndex,
            children: const [
              HomeScreen(),
              AnalysisScreen(),
              MyScreen(),
            ],
          ),
          if (_currentIndex < _iconList.length - 1)
            CalendarContainerView(
              calendarMinHeight: CalendarSize.minHeight(context),
              calendarMaxHeight: CalendarSize.maxHeight(context),
              child: CalendarContentView(
                maxHeight: CalendarSize.maxHeight(context),
              ),
            ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              top: BorderSide(
                color: getColorScheme(context).neutral50,
                width: 1,
              ),
            )),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: getColorScheme(context).colorPrimaryFocus,
          unselectedItemColor: getColorScheme(context).neutral50,
          currentIndex: _currentIndex,
          onTap: (index) => ref.read(mainTabIndexProvider.notifier).state = index,
          items: _iconList.map((data) {
            return BottomNavigationBarItem(
              icon: Column(
                children: [
                  SvgPicture.asset(
                    data.first,
                    width: 24,
                    height: 24,
                    colorFilter: ColorFilter.mode(
                      getColorScheme(context).neutral50,
                      BlendMode.srcIn,
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  )
                ],
              ),
              activeIcon: Column(
                children: [
                  SvgPicture.asset(
                    data.first,
                    width: 24,
                    height: 24,
                    colorFilter: ColorFilter.mode(
                      getColorScheme(context).colorPrimaryFocus,
                      BlendMode.srcIn,
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  )
                ],
              ),
              label: data.second,
            );
          }).toList(),
          selectedLabelStyle: getTextTheme(context).c3b,
          unselectedLabelStyle: getTextTheme(context).c3b,
        ),
      ),
    );
  }
}
