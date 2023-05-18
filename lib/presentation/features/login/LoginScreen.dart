import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:odac_flutter_app/data/data_source/remote/Service.dart';
import 'package:odac_flutter_app/presentation/components/loading/CircleLoading.dart';
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

    movePage(RoutingScreen screen) async {
      Navigator.pushReplacement(
        context,
        nextFadeInOutScreen(screen.route),
      );
    }

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        state.when(
          success: (event) async {
            final String timeZone = await FlutterNativeTimezone.getLocalTimezone();
            final languageCode = WidgetsBinding.instance.window.locale.languageCode;
            final countryCode =
                WidgetsBinding.instance.window.locale.countryCode.toString();

            Service.setHeader(
              languageCode: languageCode,
              countryCode: countryCode,
              timeZone: timeZone,
              token: event.value ?? "",
            );
            movePage(RoutingScreen.Main);
          },
          failure: (event) => SnackBarUtil.show(context, event.errorMessage),
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
