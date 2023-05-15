import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:odac_flutter_app/presentation/components/popup/PopupUtil.dart';
import 'package:odac_flutter_app/presentation/features/onboarding/widget/PageViewWithIndicator.dart';
import 'package:odac_flutter_app/presentation/ui/colors.dart';
import 'package:odac_flutter_app/presentation/utils/Common.dart';

class OnBoardingScreen extends HookWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      PopupUtil.showAppPolicy(backgroundTouchCloseFlag: false);
      return null;
    }, []);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: getColorScheme(context).colorUI01,
        elevation: 0,
      ),
      backgroundColor: getColorScheme(context).colorUI01,
      body: SafeArea(
        child: Stack(
          children: const [
            PageViewWithIndicator(),
          ],
        ),
      ),
    );
  }
}
