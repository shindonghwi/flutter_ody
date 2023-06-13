import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:odac_flutter_app/presentation/components/appbar/IconTitleTextAppBar.dart';
import 'package:odac_flutter_app/presentation/components/appbar/model/AppBarIcon.dart';
import 'package:odac_flutter_app/presentation/components/loading/CircleLoading.dart';
import 'package:odac_flutter_app/presentation/components/textfield/OutlineDefaultTextField.dart';
import 'package:odac_flutter_app/presentation/components/textfield/model/TextFieldState.dart';
import 'package:odac_flutter_app/presentation/features/edit/provider/PatchMeInfoUiStateNotifier.dart';
import 'package:odac_flutter_app/presentation/features/main/my/provider/meInfoProvider.dart';
import 'package:odac_flutter_app/presentation/models/UiState.dart';
import 'package:odac_flutter_app/presentation/navigation/PageMoveUtil.dart';
import 'package:odac_flutter_app/presentation/navigation/Route.dart';
import 'package:odac_flutter_app/presentation/ui/colors.dart';
import 'package:odac_flutter_app/presentation/ui/typography.dart';
import 'package:odac_flutter_app/presentation/utils/Common.dart';
import 'package:odac_flutter_app/presentation/utils/snackbar/SnackBarUtil.dart';

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

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        state.when(
          success: (event) async {
            Navigator.of(context).pop(weightData.value);
            stateRead.init();
          },
          failure: (event) {
            SnackBarUtil.show(context, event.errorMessage);
            stateRead.init();
          },
        );
      });
    }, [state]);

    return Scaffold(
      backgroundColor: getColorScheme(context).colorUI01,
      appBar: IconTitleTextAppBar(
        leadingIcon: AppBarIcon(
          path: 'assets/imgs/icon_back.svg',
          onPressed: () => Navigator.of(context).pop(),
        ),
        actionTextColor: weightData.value.isEmpty
            ? getColorScheme(context).neutral50
            : getColorScheme(context).neutral100,
        actionIconEnable: weightData.value.isNotEmpty,
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
    final helpText = useState('');
    final fieldState = useState(TextFieldState.Complete);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        if (meInfo == null) {
          Navigator.pushReplacement(
            context,
            nextSlideScreen(RoutingScreen.Login.route),
          );
        } else {
          callback.call(meInfo.profile.weight.toString());
        }
      });
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
          OutlineDefaultTextField(
            controller: useTextEditingController(text: initWeight),
            textInputType: TextInputType.datetime,
            textInputAction: TextInputAction.done,
            autoFocus: true,
            onChanged: (String value) => callback.call(value),
            limit: 10,
            maxLine: 1,
            helpText: helpText.value,
            fieldState: fieldState.value,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            onDoneAction: () => FocusManager.instance.primaryFocus?.unfocus(),
          )
        ],
      ),
    );
  }
}
