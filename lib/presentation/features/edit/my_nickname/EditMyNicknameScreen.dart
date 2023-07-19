import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ody_flutter_app/presentation/components/appbar/IconTitleTextAppBar.dart';
import 'package:ody_flutter_app/presentation/components/appbar/model/AppBarIcon.dart';
import 'package:ody_flutter_app/presentation/components/loading/CircleLoading.dart';
import 'package:ody_flutter_app/presentation/components/textfield/InputTextField.dart';
import 'package:ody_flutter_app/presentation/components/textfield/model/TextFieldState.dart';
import 'package:ody_flutter_app/presentation/components/toast/Toast.dart';
import 'package:ody_flutter_app/presentation/features/edit/provider/PatchMeInfoUiStateNotifier.dart';
import 'package:ody_flutter_app/presentation/features/main/my/provider/meInfoProvider.dart';
import 'package:ody_flutter_app/presentation/models/UiState.dart';
import 'package:ody_flutter_app/presentation/navigation/PageMoveUtil.dart';
import 'package:ody_flutter_app/presentation/navigation/Route.dart';
import 'package:ody_flutter_app/presentation/ui/colors.dart';
import 'package:ody_flutter_app/presentation/ui/typography.dart';
import 'package:ody_flutter_app/presentation/utils/Common.dart';

class EditMyNicknameScreen extends HookConsumerWidget {
  final String nick;

  const EditMyNicknameScreen({
    Key? key,
    this.nick = "",
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(patchMeInfoUiStateProvider);
    final stateRead = ref.read(patchMeInfoUiStateProvider.notifier);
    final nickData = useState(nick.toString());
    final nickRegExp = RegExp(r'^[a-zA-Z0-9가-힣_]+$');
    final iconEnable = nickData.value.isNotEmpty && nickRegExp.hasMatch(nickData.value);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        state.when(
          success: (event) async {
            Navigator.of(context).pop(nickData.value);
            stateRead.init();
          },
          failure: (event) {
            ToastUtil.errorToast(event.errorMessage);
            stateRead.init();
          },
        );
      });
      return null;
    }, [state]);

    return Scaffold(
      backgroundColor: getColorScheme(context).colorUI01,
      appBar: IconTitleTextAppBar(
        leadingIcon: AppBarIcon(
          path: 'assets/imgs/icon_back.svg',
          onPressed: () => Navigator.of(context).pop(),
        ),
        actionTextColor: !iconEnable ? getColorScheme(context).neutral50 : getColorScheme(context).neutral100,
        actionIconEnable: iconEnable,
        actionText: getAppLocalizations(context).common_complete,
        actionTextCallback: () => stateRead.patchNickname(nickData.value),
        title: getAppLocalizations(context).edit_my_nickname_title,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Stack(
          children: [
            _NickContent(
              callback: (String value) => nickData.value = value,
              initNick: nickData.value,
            ),
            if (state is Loading) const CircleLoading(),
          ],
        ),
      ),
    );
  }
}

class _NickContent extends HookConsumerWidget {
  final String initNick;
  final Function(String value) callback;

  const _NickContent({
    Key? key,
    required this.callback,
    required this.initNick,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final meInfo = ref.watch(meInfoProvider);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        if (meInfo == null) {
          Navigator.pushReplacement(
            context,
            nextSlideScreen(RoutingScreen.Login.route),
          );
        } else {
          callback.call(meInfo.nick.toString());
        }
      });
      return null;
    }, []);

    return Container(
      margin: const EdgeInsets.only(top: 32, left: 24, right: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            getAppLocalizations(context).edit_my_info_title_nickname,
            style: getTextTheme(context).c2r.copyWith(
                  color: getColorScheme(context).colorText,
                ),
          ),
          const SizedBox(height: 16),
          InputTextField(
            initText: initNick,
            autoFocus: true,
            textInputAction: TextInputAction.done,
            textInputType: TextInputType.text,
            limit: 15,
            onChanged: (String value) => callback.call(value),
            regList: [RegExp(r'^[a-zA-Z0-9가-힣_]+$')],
            inputFormatters: [],
            onDoneAction: (_) => FocusManager.instance.primaryFocus?.unfocus(),
          )
        ],
      ),
    );
  }
}
