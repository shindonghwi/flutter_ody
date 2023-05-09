import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:odac_flutter_app/presentation/features/main/home/HomeScreen.dart';
import 'package:odac_flutter_app/presentation/features/main/my/MyScreen.dart';
import 'package:odac_flutter_app/presentation/ui/colors.dart';
import 'package:odac_flutter_app/presentation/ui/typography.dart';
import 'package:odac_flutter_app/presentation/utils/Common.dart';
import 'package:odac_flutter_app/presentation/utils/dto/Pair.dart';

class MainScreen extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final _currentIndex = useState(0); // Current index of the active tab

    List<Pair> _iconList = [
      Pair('assets/imgs/icon_record.svg', getAppLocalizations(context).main_tab_home),
      Pair('assets/imgs/icon_information.svg', getAppLocalizations(context).main_tab_news),
      Pair('assets/imgs/icon_mypage.svg', getAppLocalizations(context).main_tab_my),
    ];

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex.value,
        children: const [
          HomeScreen(),
          Center(child: Text("news"),),
          MyScreen(),
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
          )
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: getColorScheme(context).colorPrimaryFocus,
          unselectedItemColor: getColorScheme(context).neutral50,
          currentIndex: _currentIndex.value,
          onTap: (index) {
            _currentIndex.value = index; // Update the current index when a tab is tapped
          },
          items: _iconList.map((data) {
            return BottomNavigationBarItem(
              icon: SvgPicture.asset(
                data.first,
                width: 24,
                height: 24,
                colorFilter: ColorFilter.mode(
                  getColorScheme(context).neutral50,
                  BlendMode.srcIn,
                ),
              ),
              activeIcon: SvgPicture.asset(
                data.first,
                width: 24,
                height: 24,
                colorFilter: ColorFilter.mode(
                  getColorScheme(context).colorPrimaryFocus,
                  BlendMode.srcIn,
                ),
              ),
              label: data.second,
            );
          }).toList(),
          selectedLabelStyle: getTextTheme(context).c3r,
        ),
      ),
    );
  }
}
