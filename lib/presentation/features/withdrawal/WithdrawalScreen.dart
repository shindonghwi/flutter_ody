import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:odac_flutter_app/presentation/components/appbar/IconTitleIconAppBar.dart';
import 'package:odac_flutter_app/presentation/components/appbar/model/AppBarIcon.dart';
import 'package:odac_flutter_app/presentation/components/button/fill/FillButton.dart';
import 'package:odac_flutter_app/presentation/components/button/model/ButtonNotifier.dart';
import 'package:odac_flutter_app/presentation/components/button/model/ButtonSizeType.dart';
import 'package:odac_flutter_app/presentation/components/button/model/ButtonState.dart';
import 'package:odac_flutter_app/presentation/components/checkbox/checkbox/BasicBorderCheckBox.dart';
import 'package:odac_flutter_app/presentation/components/checkbox/model/CheckBoxSize.dart';
import 'package:odac_flutter_app/presentation/components/checkbox/model/CheckBoxType.dart';
import 'package:odac_flutter_app/presentation/navigation/PageMoveUtil.dart';
import 'package:odac_flutter_app/presentation/navigation/Route.dart';
import 'package:odac_flutter_app/presentation/ui/colors.dart';
import 'package:odac_flutter_app/presentation/ui/typography.dart';
import 'package:odac_flutter_app/presentation/utils/Common.dart';
import 'package:odac_flutter_app/presentation/utils/dto/Triple.dart';

class WithdrawalScreen extends HookWidget {
  const WithdrawalScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final policyItems = [
      Triple(
        getAppLocalizations(context).withdrawal_policy_1_start,
        getAppLocalizations(context).withdrawal_policy_1_medium,
        getAppLocalizations(context).withdrawal_policy_1_end,
      ),
      Triple(
        getAppLocalizations(context).withdrawal_policy_2_start,
        "",
        getAppLocalizations(context).withdrawal_policy_2_end,
      ),
      Triple(
        getAppLocalizations(context).withdrawal_policy_3_start,
        getAppLocalizations(context).withdrawal_policy_3_medium,
        getAppLocalizations(context).withdrawal_policy_3_end,
      ),
    ];

    final isChecked = useState(false);
    final buttonState = useState(ButtonState.Disabled);

    return Scaffold(
      backgroundColor: getColorScheme(context).colorUI01,
      appBar: IconTitleIconAppBar(
        leadingIcon: AppBarIcon(
          path: 'assets/imgs/icon_back.svg',
          onPressed: () => Navigator.of(context).pop(),
          tint: getColorScheme(context).black,
        ),
        title: getAppLocalizations(context).withdrawal_title,
      ),
      body: Container(
        margin: const EdgeInsets.fromLTRB(16, 32, 24, 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _title(context),
            _policy(context, policyItems),
            _agreeCheckBox(isChecked, context, (isChecked) {
              buttonState.value = isChecked ? ButtonState.Activated : ButtonState.Disabled;
              debugPrint(buttonState.value.toString());
            }),
            const Expanded(child: SizedBox()),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: const EdgeInsets.only(bottom: 24),
                width: double.infinity,
                child: FillButton(
                  text: getAppLocalizations(context).common_next,
                  type: ButtonSizeType.Small,
                  onPressed: () {
                    Navigator.push(
                      context,
                      nextSlideScreen(RoutingScreen.WithdrawalReason.route),
                    );
                  },
                  buttonProvider: StateNotifierProvider<ButtonNotifier, ButtonState>(
                    (_) => ButtonNotifier(
                      state: buttonState.value == ButtonState.Activated
                          ? ButtonState.Activated
                          : ButtonState.Disabled,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _title(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Text(
        getAppLocalizations(context).withdrawal_confirm_title,
        style: getTextTheme(context).h3b.copyWith(
              color: getColorScheme(context).colorText,
            ),
      ),
    );
  }

  Container _policy(BuildContext context, List<Triple> policyItems) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: getColorScheme(context).colorUI03,
        borderRadius: BorderRadius.circular(5),
      ),
      margin: const EdgeInsets.only(top: 30, left: 8),
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: policyItems.map((e) {
          return Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 4.0),
                    child: Text(
                      "•",
                      style: getTextTheme(context).b3r.copyWith(
                            color: getColorScheme(context).neutral70,
                          ),
                    ),
                  ),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: e.first,
                            style: getTextTheme(context).b3r.copyWith(
                                  color: getColorScheme(context).neutral70,
                                ),
                          ),
                          TextSpan(
                            text: e.second,
                            style: getTextTheme(context).c1b.copyWith(
                                  color: getColorScheme(context).neutral80,
                                ),
                          ),
                          TextSpan(
                            text: e.third,
                            style: getTextTheme(context).b3r.copyWith(
                                  color: getColorScheme(context).neutral70,
                                ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
            ],
          );
        }).toList(),
      ),
    );
  }

  Container _agreeCheckBox(
    ValueNotifier<bool> _isChecked,
    BuildContext context,
    Function(bool) callback,
  ) {
    return Container(
      padding: const EdgeInsets.only(top: 8),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            _isChecked.value = !_isChecked.value;
            callback.call(_isChecked.value);
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 32,
                height: 32,
                child: BasicBorderCheckBox(
                  isChecked: _isChecked.value,
                  size: CheckBoxSize.Normal,
                  type: CheckBoxType.Circle,
                  onChange: (flag) {
                    _isChecked.value = !_isChecked.value;
                    callback.call(_isChecked.value);
                  },
                ),
              ),
              Text(
                getAppLocalizations(context).withdrawal_policy_agree,
                style: getTextTheme(context).b3r.copyWith(
                      color: getColorScheme(context).neutral70,
                    ),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}
