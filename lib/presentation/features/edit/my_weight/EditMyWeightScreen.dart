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
import 'package:ody_flutter_app/presentation/utils/regex/FixedInputFormatter.dart';

class EditMyWeightScreen extends HookConsumerWidget {
  final int weight;

  const EditMyWeightScreen({
    Key? key,
    this.weight = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(patchMeInfoUiStateProvider);
    final stateRead = ref.read(patchMeInfoUiStateProvider.notifier);
    final weightData = useState(weight.toString());
    final weightRegExp = RegExp(r'^(3[0-6]|[3-9]\d|1\d\d|200)$');
    final iconEnable = weightData.value.isNotEmpty && weightRegExp.hasMatch(weightData.value);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        state.when(
          success: (event) async {
            Navigator.of(context).pop(weightData.value);
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
        actionTextCallback: () => stateRead.patchWeight(int.parse(weightData.value)),
        title: getAppLocalizations(context).edit_my_weight_title,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Stack(
          children: [
            _WeightContent(
              callback: (String value) => weightData.value = value,
              initWeight: weightData.value,
            ),
            if (state is Loading) const CircleLoading(),
          ],
        ),
      ),
    );
  }
}

class _WeightContent extends HookConsumerWidget {
  final String initWeight;
  final Function(String value) callback;

  const _WeightContent({
    Key? key,
    required this.callback,
    required this.initWeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final meInfo = ref.watch(meInfoProvider);
    final pattern = RegExp(r'^(3[0-6]|[3-9]\d|1\d\d|200)$'); // 30 <= x <= 200
    const fixedContent = "kg";

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        if (meInfo == null) {
          Navigator.pushReplacement(
            context,
            nextSlideScreen(RoutingScreen.Login.route),
          );
        } else {
          callback.call(meInfo.profile!.weight.toString());
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
            getAppLocalizations(context).edit_my_info_title_weight,
            style: getTextTheme(context).c2r.copyWith(
                  color: getColorScheme(context).colorText,
                ),
          ),
          const SizedBox(height: 16),
          InputTextField(
            autoFocus: true,
            initText: initWeight,
            hint: getAppLocalizations(context).input_profile_weight_hint,
            textInputAction: TextInputAction.next,
            textInputType: TextInputType.number,
            limit: 3 + fixedContent.length,
            onChanged: (String value) => callback.call(value),
            onDoneAction: (_) => FocusManager.instance.primaryFocus?.unfocus(),
            successMessage: getAppLocalizations(context).input_profile_message_success,
            errorMessage: getAppLocalizations(context).input_profile_message_error,
            fixedContent: fixedContent,
            showCounter: true,
            regList: [pattern],
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              FixedInputFormatter(suffix: fixedContent),
            ],
          ),
        ],
      ),
    );
  }
}
