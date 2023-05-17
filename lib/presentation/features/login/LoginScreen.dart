import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:odac_flutter_app/domain/models/auth/LoginPlatform.dart';
import 'package:odac_flutter_app/domain/usecases/remote/auth/PostSocialLoginUseCase.dart';
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
    final state = ref.watch<UIState>(loginUiStateProvider);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (state is Failure) {
          SnackBarUtil.show(context, state.errorMessage);
        }
        if (state is Success) {
          Navigator.pushReplacement(
            context,
            nextFadeInOutScreen(RoutingScreen.Main.route),
          );
        }
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
