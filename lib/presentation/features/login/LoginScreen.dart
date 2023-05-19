import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:odac_flutter_app/presentation/components/loading/CircleLoading.dart';
import 'package:odac_flutter_app/presentation/features/constant/constants.dart';
import 'package:odac_flutter_app/presentation/features/login/notifier/LoginUiStateNotifier.dart';
import 'package:odac_flutter_app/presentation/features/login/widget/LoginContent.dart';
import 'package:odac_flutter_app/presentation/models/UiState.dart';
import 'package:odac_flutter_app/presentation/navigation/PageMoveUtil.dart';
import 'package:odac_flutter_app/presentation/navigation/Route.dart';
import 'package:odac_flutter_app/presentation/ui/colors.dart';
import 'package:odac_flutter_app/presentation/utils/Common.dart';
import 'package:odac_flutter_app/presentation/utils/snackbar/SnackBarUtil.dart';

/// @feature:  로그인 화면
/// @author: 2023/03/29 6:59 PM donghwishin
class LoginScreen extends HookConsumerWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch<UIState<String?>>(loginUiStateProvider);
    final loginProvider = ref.read(loginUiStateProvider.notifier);

    movePage(RoutingScreen screen, {int initPageNumber = 0}) async {
      Navigator.pushReplacement(
        context,
        nextFadeInOutScreen(screen.route),
      );
    }

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        state.when(
          success: (event) async {
            if (loginProvider.currentProceedPage == SIGN_UP_PROCEED_COMPLETE) {
              movePage(RoutingScreen.Main);
            } else {
              movePage(RoutingScreen.InputProfile,
                  initPageNumber: loginProvider.currentProceedPage);
            }
          },
          failure: (event) {
            SnackBarUtil.show(context, event.errorMessage);
          },
        );
      });
    }, [state]);

    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            backgroundColor: getColorScheme(context).colorUIBackground,
            elevation: 0,
          ),
          backgroundColor: getColorScheme(context).colorUIBackground,
          body: const SafeArea(
            child: LoginContent(),
          ),
        ),
        if (state is Loading) const CircleLoading(),
      ],
    );
  }
}
