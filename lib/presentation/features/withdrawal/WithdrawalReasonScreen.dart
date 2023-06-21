import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ody_flutter_app/presentation/components/appbar/IconTitleIconAppBar.dart';
import 'package:ody_flutter_app/presentation/components/appbar/model/AppBarIcon.dart';
import 'package:ody_flutter_app/presentation/components/button/fill/FillButton.dart';
import 'package:ody_flutter_app/presentation/components/button/model/ButtonNotifier.dart';
import 'package:ody_flutter_app/presentation/components/button/model/ButtonSizeType.dart';
import 'package:ody_flutter_app/presentation/components/button/model/ButtonState.dart';
import 'package:ody_flutter_app/presentation/navigation/Route.dart';
import 'package:ody_flutter_app/presentation/ui/colors.dart';
import 'package:ody_flutter_app/presentation/ui/typography.dart';
import 'package:ody_flutter_app/presentation/utils/Common.dart';
import 'package:ody_flutter_app/presentation/utils/dto/Pair.dart';

class WithdrawalReasonScreen extends HookWidget {
  const WithdrawalReasonScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Pair<ValueNotifier<bool>, String>> reasonItems = [
      Pair(useState(false), getAppLocalizations(context).withdrawal_reason_1),
      Pair(useState(false), getAppLocalizations(context).withdrawal_reason_2),
      Pair(useState(false), getAppLocalizations(context).withdrawal_reason_3),
      Pair(useState(false), getAppLocalizations(context).withdrawal_reason_4),
      Pair(useState(false), getAppLocalizations(context).withdrawal_reason_5),
    ];

    bool isAnyReasonChecked() {
      return reasonItems.any((item) => item.first.value == true);
    }

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
        margin: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _description(context),
            const SizedBox(height: 8),
            _subDescription(context),
            const SizedBox(height: 32),
            _reaseons(context, reasonItems),
            const Expanded(child: SizedBox()),
            _withdrawalButton(context, isAnyReasonChecked)
          ],
        ),
      ),
    );
  }

  Text _description(BuildContext context) {
    return Text(
      getAppLocalizations(context).withdrawal_reason_description,
      style: getTextTheme(context).b2b.copyWith(
            color: getColorScheme(context).colorText,
            height: 1.2,
          ),
    );
  }

  Text _subDescription(BuildContext context) {
    return Text(
      getAppLocalizations(context).withdrawal_reason_sub_description,
      style: getTextTheme(context).c2r.copyWith(
            color: getColorScheme(context).neutral70,
          ),
    );
  }

  Container _reaseons(BuildContext context, List<Pair<ValueNotifier<bool>, String>> reasonItems) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      decoration: BoxDecoration(
        color: getColorScheme(context).colorUI03,
        borderRadius: BorderRadius.circular(5),
      ),
      child: ListView.separated(
        shrinkWrap: true,
        padding: const EdgeInsets.all(0),
        itemBuilder: (BuildContext context, int index) {
          final item = reasonItems[index];
          return Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => item.first.value = !item.first.value,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      "assets/imgs/icon_check.svg",
                      width: 24,
                      height: 24,
                      colorFilter: item.first.value
                          ? ColorFilter.mode(
                              getColorScheme(context).colorPrimaryFocus,
                              BlendMode.srcIn,
                            )
                          : ColorFilter.mode(
                              getColorScheme(context).neutral50,
                              BlendMode.srcIn,
                            ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      item.second,
                      style: getTextTheme(context).c1r.copyWith(
                            color: getColorScheme(context).colorText,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(height: 4);
        },
        itemCount: reasonItems.length,
      ),
    );
  }

  Align _withdrawalButton(BuildContext context, bool Function() isAnyReasonChecked) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: const EdgeInsets.only(bottom: 24),
        width: double.infinity,
        child: FillButton(
          text: getAppLocalizations(context).common_next,
          type: ButtonSizeType.Small,
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              RoutingScreen.Main.route,
              (route) => false,
            );
          },
          buttonProvider: StateNotifierProvider<ButtonNotifier, ButtonState>(
            (_) => ButtonNotifier(
              state: isAnyReasonChecked() ? ButtonState.Activated : ButtonState.Disabled,
            ),
          ),
        ),
      ),
    );
  }
}
