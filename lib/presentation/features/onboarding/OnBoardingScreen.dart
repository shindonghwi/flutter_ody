import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:odac_flutter_app/domain/usecases/app/GetAppPolicyUpdateUseCase.dart';
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
    },[]);

    return Scaffold(
      backgroundColor: getColorScheme(context).colorUI01,
      body: SafeArea(
        child: Stack(
          children: [
            PageViewWithIndicator(),
          ],
        ),
      ),
    );
  }
}
