import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ody_flutter_app/presentation/components/appbar/IconTitleTextAppBar.dart';
import 'package:ody_flutter_app/presentation/components/appbar/model/AppBarIcon.dart';
import 'package:ody_flutter_app/presentation/components/loading/CircleLoading.dart';
import 'package:ody_flutter_app/presentation/components/textfield/InputTextField.dart';
import 'package:ody_flutter_app/presentation/components/toast/Toast.dart';
import 'package:ody_flutter_app/presentation/features/edit/provider/PatchMeInfoUiStateNotifier.dart';
import 'package:ody_flutter_app/presentation/features/main/my/provider/meInfoProvider.dart';
import 'package:ody_flutter_app/presentation/models/UiState.dart';
import 'package:ody_flutter_app/presentation/navigation/PageMoveUtil.dart';
import 'package:ody_flutter_app/presentation/navigation/Route.dart';
import 'package:ody_flutter_app/presentation/ui/colors.dart';
import 'package:ody_flutter_app/presentation/ui/typography.dart';
import 'package:ody_flutter_app/presentation/utils/Common.dart';

class EditMyHeightScreen extends HookConsumerWidget {
  final int height;

  const EditMyHeightScreen({
    Key? key,
    this.height = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(patchMeInfoUiStateProvider);
    final stateRead = ref.read(patchMeInfoUiStateProvider.notifier);
    final heightData = useState(height.toString());
    final heightRegExp = RegExp(r'^(12[0-9]|1[3-9][0-9]|2[0-2][0-9]|230|120)$');
    final iconEnable = heightData.value.isNotEmpty && heightRegExp.hasMatch(heightData.value);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        state.when(
          success: (event) async {
            Navigator.of(context).pop(heightData.value);
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

    debugPrint('EditMyHeightScreen build : ${heightData.value} ${heightRegExp.hasMatch("100")}');

    return Scaffold(
      backgroundColor: getColorScheme(context).colorUI01,
      appBar: IconTitleTextAppBar(
        leadingIcon: AppBarIcon(
          path: 'assets/imgs/icon_back.svg',
          onPressed: () => Navigator.of(context).pop(),
        ),
        actionText: getAppLocalizations(context).common_complete,
        actionTextColor: !iconEnable ? getColorScheme(context).neutral50 : getColorScheme(context).neutral100,
        actionIconEnable: iconEnable,
        actionTextCallback: () => stateRead.patchHeight(int.parse(heightData.value)),
        title: getAppLocalizations(context).edit_my_height_title,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Stack(
          children: [
            _HeightContent(
              callback: (String value) => heightData.value = value,
              initHeight: heightData.value,
            ),
            if (state is Loading) const CircleLoading(),
          ],
        ),
      ),
    );
  }
}

class _HeightContent extends HookConsumerWidget {
  final String initHeight;
  final Function(String value) callback;

  const _HeightContent({
    Key? key,
    required this.callback,
    required this.initHeight,
  }) : super(key: key);

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
          callback.call(meInfo.profile!.height.toString());
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
            getAppLocalizations(context).edit_my_info_title_height,
            style: getTextTheme(context).c2r.copyWith(
                  color: getColorScheme(context).colorText,
                ),
          ),
          const SizedBox(height: 16),
          InputTextField(
            initText: initHeight,
            autoFocus: true,
            hint: getAppLocalizations(context).input_profile_height_hint,
            textInputAction: TextInputAction.done,
            textInputType: TextInputType.number,
            limit: 3,
            onChanged: (String value) => callback.call(value),
            regList: [RegExp(r'^(12[0-9]|1[3-9][0-9]|2[0-2][0-9]|230)$')],
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            onDoneAction: (_) => FocusManager.instance.primaryFocus?.unfocus(),
          )
        ],
      ),
    );
  }
}
