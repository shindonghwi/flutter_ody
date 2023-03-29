import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:odac_flutter_app/presentation/components/appbar/IconTitleIconAppBar.dart';
import 'package:odac_flutter_app/presentation/components/appbar/IconTitleTextAppBar.dart';
import 'package:odac_flutter_app/presentation/components/appbar/model/AppBarIcon.dart';
import 'package:odac_flutter_app/presentation/ui/colors.dart';
import 'package:odac_flutter_app/presentation/utils/Common.dart';
import 'package:odac_flutter_app/presentation/utils/dto/Pair.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getColorScheme(context).colorBackground,
      appBar: IconTitleTextAppBar(
        actionText: "건너뛰기",
      ),
      body: Center(
        child: PageViewWithIndicator(),
      ),
    );
  }
}

final pageViewControllerProvider = Provider<PageController>((ref) => PageController());

final currentPageIndexProvider = StateProvider<int>((ref) => 0);

class PageViewWithIndicator extends HookConsumerWidget {
  final List<String> titles = ['Page 1', 'Page 2', 'Page 3'];
  final List<Widget> pages = [
    Container(color: Colors.blue),
    Container(color: Colors.green),
    Container(color: Colors.orange),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageController = ref.watch(pageViewControllerProvider);
    final currentPageIndex = ref.watch(currentPageIndexProvider);

    useEffect(() {
      pageController.addListener(() {
        ref.read(currentPageIndexProvider.notifier).state = pageController.page!.round();
      });
      return () => pageController.dispose();
    }, [pageController]);

    return Column(
      children: [
        Expanded(
          child: PageView(
            controller: pageController,
            children: pages,
          ),
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            titles.length,
            (index) => IndicatorDot(
              isSelected: index == currentPageIndex,
            ),
          ),
        ),
        SizedBox(height: 20),
        Text(titles[currentPageIndex], style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
      ],
    );
  }
}

class IndicatorDot extends HookWidget {
  final bool isSelected;

  IndicatorDot({this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    final dotSize = isSelected ? 15.0 : 7.0;
    final dotColor = isSelected ? Colors.blue : Colors.grey;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        width: dotSize,
        height: 7.0,
        decoration: BoxDecoration(
          color: dotColor,
          borderRadius: BorderRadius.circular(100.0),
        ),
      ),
    );
  }
}
