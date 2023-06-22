import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ody_flutter_app/presentation/components/appbar/IconTitleTextAppBar.dart';
import 'package:ody_flutter_app/presentation/components/appbar/model/AppBarIcon.dart';
import 'package:ody_flutter_app/presentation/components/loading/CircleLoading.dart';
import 'package:ody_flutter_app/presentation/components/textfield/OutlineDefaultTextField.dart';
import 'package:ody_flutter_app/presentation/components/textfield/model/TextFieldState.dart';
import 'package:ody_flutter_app/presentation/features/edit/provider/PatchMeInfoUiStateNotifier.dart';
import 'package:ody_flutter_app/presentation/features/main/my/provider/meInfoProvider.dart';
import 'package:ody_flutter_app/presentation/models/UiState.dart';
import 'package:ody_flutter_app/presentation/navigation/PageMoveUtil.dart';
import 'package:ody_flutter_app/presentation/navigation/Route.dart';
import 'package:ody_flutter_app/presentation/ui/colors.dart';
import 'package:ody_flutter_app/presentation/ui/typography.dart';
import 'package:ody_flutter_app/presentation/utils/Common.dart';
import 'package:ody_flutter_app/presentation/utils/snackbar/SnackBarUtil.dart';

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

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        state.when(
          success: (event) async {
            Navigator.of(context).pop(heightData.value);
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
        actionText: getAppLocalizations(context).common_complete,
        actionTextColor: heightData.value.isEmpty
            ? getColorScheme(context).neutral50
            : getColorScheme(context).neutral100,
        actionIconEnable: heightData.value.isNotEmpty,
        actionTextCallback: () {
          stateRead.patchHeight(int.parse(heightData.value));
        },
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
          callback.call(meInfo.profile.height.toString());
        }
      });
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
          OutlineDefaultTextField(
            controller: useTextEditingController(text: initHeight),
            textInputType: TextInputType.datetime,
            textInputAction: TextInputAction.done,
            autoFocus: true,
            onChanged: (String value) => callback.call(value),
            limit: 3,
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
