import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ody_flutter_app/domain/usecases/local/app/GetAppPolicyUpdateUseCase.dart';
import 'package:ody_flutter_app/presentation/components/button/fill/FillButton.dart';
import 'package:ody_flutter_app/presentation/components/button/model/ButtonNotifier.dart';
import 'package:ody_flutter_app/presentation/components/button/model/ButtonSizeType.dart';
import 'package:ody_flutter_app/presentation/components/button/model/ButtonState.dart';
import 'package:ody_flutter_app/presentation/components/checkbox/checkbox/BasicBorderCheckBox.dart';
import 'package:ody_flutter_app/presentation/components/checkbox/model/CheckBoxSize.dart';
import 'package:ody_flutter_app/presentation/components/checkbox/model/CheckBoxType.dart';
import 'package:ody_flutter_app/presentation/components/popup/PopupUtil.dart';
import 'package:ody_flutter_app/presentation/components/popup/provider/TermsProvider.dart';
import 'package:ody_flutter_app/presentation/ui/colors.dart';
import 'package:ody_flutter_app/presentation/ui/typography.dart';
import 'package:ody_flutter_app/presentation/utils/Common.dart';
import 'package:ody_flutter_app/presentation/utils/dto/Triple.dart';
import 'package:url_launcher/url_launcher.dart';

class PopUpAppPolicy extends HookWidget {
  const PopUpAppPolicy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime? lastPressedAt;
    return WillPopScope(
      onWillPop: () async {
        final now = DateTime.now();
        if (lastPressedAt == null || now.difference(lastPressedAt!) > const Duration(seconds: 2)) {
          lastPressedAt = now;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('한번 더 누르면 종료됩니다'),
              duration: Duration(seconds: 2),
            ),
          );
          return false;
        }
        SystemNavigator.pop();
        return true;
      },
      child: Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _appTitle(context),
            const SizedBox(height: 23),
            const _PolicyAllCheck(),
            _divider(context),
            const SizedBox(height: 16),
            const _PolicyItems(),
            const SizedBox(height: 24),
            ContinueButton()
          ],
        ),
      ),
    );
  }

  Widget _appTitle(BuildContext context) {
    return Text(
      getAppLocalizations(context).popup_app_policy_title,
      style: getTextTheme(context).t1b.copyWith(
            color: getColorScheme(context).colorText,
          ),
    );
  }

  Widget _divider(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      width: double.infinity,
      height: 1,
      color: getColorScheme(context).neutral40,
    );
  }
}

class _PolicyAllCheck extends HookConsumerWidget {
  const _PolicyAllCheck({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final policyItemsState = ref.watch<List<bool>>(termsAppPolicyProvider);
    final policyItemsRead = ref.read(termsAppPolicyProvider.notifier);
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => policyItemsRead.allChange(),
        borderRadius: BorderRadius.circular(4),
        child: Row(
          children: [
            SizedBox(
              width: 18,
              height: 18,
              child: BasicBorderCheckBox(
                isChecked: policyItemsRead.isAllAccepted(),
                size: CheckBoxSize.Normal,
                type: CheckBoxType.Rectangle,
                onChange: (bool value) => policyItemsRead.allChange(),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              getAppLocalizations(context).popup_app_policy_all_grant,
              style: getTextTheme(context).b2b.copyWith(
                    color: getColorScheme(context).colorText,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PolicyItems extends HookConsumerWidget {
  const _PolicyItems({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final policyItems = [
      // 약관이름, 필수여부, 링크
      Triple(
        getAppLocalizations(context).popup_app_policy_age_14,
        true,
        "https://www.ody.life/youth-policy/index.html",
      ),
      Triple(
        getAppLocalizations(context).popup_app_policy_service,
        true,
        "https://www.ody.life/service/index.html",
      ),
      Triple(
        getAppLocalizations(context).popup_app_policy_individual,
        true,
        "https://www.ody.life/personal/index.html",
      ),
    ];
    final policyItemsState = ref.watch<List<bool>>(termsAppPolicyProvider);
    final policyItemsRead = ref.read(termsAppPolicyProvider.notifier);

    return Column(
        children: policyItems.asMap().entries.map((entry) {
      final index = entry.key;
      final item = entry.value;
      return Row(
        children: [
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => policyItemsRead.change(index),
              borderRadius: BorderRadius.circular(4),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 16,
                      height: 16,
                      child: BasicBorderCheckBox(
                        isChecked: policyItemsState[index],
                        size: CheckBoxSize.Small,
                        type: CheckBoxType.Rectangle,
                        onChange: (bool value) => policyItemsRead.change(index),
                      ),
                    ),
                    const SizedBox(
                      width: 14,
                    ),
                    Text(
                      item.first,
                      style: getTextTheme(context).b3r.copyWith(
                            color: getColorScheme(context).colorText,
                            height: 1,
                          ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      "[${item.second ? getAppLocalizations(context).common_required : getAppLocalizations(context).common_select}]",
                      style: getTextTheme(context).b3r.copyWith(
                            color: getColorScheme(context).primary100,
                            height: 1,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => launchUrl(Uri.parse(item.third)),
              child: Padding(
                padding: const EdgeInsets.only(top: 2, bottom: 2, right: 8),
                child: SvgPicture.asset(
                  "assets/imgs/icon_next_1_small.svg",
                  colorFilter: ColorFilter.mode(
                    getColorScheme(context).colorText,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    }).toList());
  }
}

class ContinueButton extends HookConsumerWidget {
  ContinueButton({Key? key}) : super(key: key);
  final GetAppPolicyUpdateUseCase _getAppPolicyUpdateUseCase = GetIt.instance<GetAppPolicyUpdateUseCase>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final policyItemsState = ref.watch<List<bool>>(termsAppPolicyProvider);
    final policyItemsRead = ref.read(termsAppPolicyProvider.notifier);

    return FillButton(
      text: getAppLocalizations(context).common_continue,
      type: ButtonSizeType.Small,
      onPressed: () {
        _getAppPolicyUpdateUseCase.change(true);
        PopupUtil.close();
      },
      buttonProvider: StateNotifierProvider<ButtonNotifier, ButtonState>(
        (_) => ButtonNotifier(
          state: policyItemsRead.isAllAccepted() ? ButtonState.Activated : ButtonState.Disabled,
        ),
      ),
    );
  }
}
