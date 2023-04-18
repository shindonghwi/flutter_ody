import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:odac_flutter_app/presentation/features/main/home/HomeScreen.dart';
import 'package:odac_flutter_app/presentation/ui/colors.dart';
import 'package:odac_flutter_app/presentation/ui/typography.dart';
import 'package:odac_flutter_app/presentation/utils/Common.dart';
import 'package:odac_flutter_app/presentation/utils/dto/Pair.dart';

class MainScreen extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final _currentIndex = useState(0); // Current index of the active tab

    List<Pair> _iconList = [
      Pair('assets/imgs/icon_home.svg', "홈"),
      Pair('assets/imgs/icon_news.svg', "소식"),
      Pair('assets/imgs/icon_my.svg', "내정보"),
    ];

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex.value,
        children: [
          HomeScreen(),
          Center(child: Text("news"),),
          Center(child: Text("my"),)
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
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
        selectedLabelStyle: getTextTheme(context).c3,
      ),
    );
  }
}
