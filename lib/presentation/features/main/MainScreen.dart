import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ody_flutter_app/presentation/features/main/analysis/AnalysisScreen.dart';
import 'package:ody_flutter_app/presentation/features/main/home/HomeScreen.dart';
import 'package:ody_flutter_app/presentation/features/main/home/model/CalendarSize.dart';
import 'package:ody_flutter_app/presentation/features/main/home/notifier/CalendarFormatNotifier.dart';
import 'package:ody_flutter_app/presentation/features/main/home/notifier/CalendarHeightNotifier.dart';
import 'package:ody_flutter_app/presentation/features/main/home/notifier/DimNotifier.dart';
import 'package:ody_flutter_app/presentation/features/main/home/widget/HomeAppBar.dart';
import 'package:ody_flutter_app/presentation/features/main/home/widget/calendar/CalendarContainerView.dart';
import 'package:ody_flutter_app/presentation/features/main/home/widget/calendar/CalendarContentView.dart';
import 'package:ody_flutter_app/presentation/features/main/my/MyScreen.dart';
import 'package:ody_flutter_app/presentation/features/main/provider/MainTabIndexProvider.dart';
import 'package:ody_flutter_app/presentation/ui/colors.dart';
import 'package:ody_flutter_app/presentation/ui/typography.dart';
import 'package:ody_flutter_app/presentation/utils/Common.dart';
import 'package:ody_flutter_app/presentation/utils/dto/Pair.dart';
import 'package:table_calendar/table_calendar.dart';

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
      bottomNavigationBar: _BottomNavigationBar(currentIndex: _currentIndex, iconList: _iconList),
    );
  }
}

class _BottomNavigationBar extends HookConsumerWidget {
  const _BottomNavigationBar({
    super.key,
    required int currentIndex,
    required List<Pair> iconList,
  })  : _currentIndex = currentIndex,
        _iconList = iconList;

  final int _currentIndex;
  final List<Pair> _iconList;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const minAlpha = 0.0;
    const maxAlpha = 0.3;
    const duration = 200;

    final isDimOn = ref.watch<bool>(dimProvider);
    final isDimOnRead = ref.read(dimProvider.notifier);
    final calendarFormatRead = ref.read(calendarFormatProvider.notifier);
    final calendarHeightRead = ref.read(calendarHeightProvider.notifier);
    final mainTabIndexRead = ref.read(mainTabIndexProvider.notifier);

    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: duration),
      tween: Tween<double>(begin: 0.0, end: isDimOn ? maxAlpha : minAlpha),
      builder: (_, value, child) {
        return Stack(
          children: [
            Container(
              color: getColorScheme(context).white,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  topRight: Radius.circular(15.0),
                ),
                child: BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  backgroundColor: getColorScheme(context).white,
                  selectedItemColor: getColorScheme(context).colorPrimaryFocus,
                  unselectedItemColor: getColorScheme(context).neutral50,
                  currentIndex: _currentIndex,
                  onTap: (index) => mainTabIndexRead.state = index,
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
            ),
            if (isDimOn)
              GestureDetector(
                onTap: () {
                  calendarHeightRead.updateHeight(CalendarSize.minHeight(context));
                  calendarFormatRead.updateFormat(CalendarFormat.week);
                  isDimOnRead.change(false);
                },
                child: Container(
                  width: double.infinity,
                  height: 60,
                  color: getColorScheme(context).black.withOpacity(value),
                ),
              ),
          ],
        );
      },
    );
  }
}
