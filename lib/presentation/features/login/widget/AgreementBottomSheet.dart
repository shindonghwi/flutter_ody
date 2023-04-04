import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:odac_flutter_app/presentation/components/button/OutlinedButton.dart';
import 'package:odac_flutter_app/presentation/features/login/provider/AgreementProvider.dart';
import 'package:odac_flutter_app/presentation/features/login/widget/AgreementItem.dart';
import 'package:odac_flutter_app/presentation/ui/colors.dart';
import 'package:odac_flutter_app/presentation/utils/Common.dart';
import 'package:odac_flutter_app/presentation/utils/dto/Pair.dart';

class AgreementBottomSheet extends HookConsumerWidget {
  const AgreementBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final policyItemsState = ref.watch<List<bool>>(agreementPolicyItemProvider);
    final policyItemsRead = ref.read(agreementPolicyItemProvider.notifier);

    List<Pair> policyList = [
      Pair(true, getAppLocalizations(context).login_policy_age),
      Pair(true, getAppLocalizations(context).login_policy_service),
      Pair(true, getAppLocalizations(context).login_policy_individual),
      Pair(false, getAppLocalizations(context).login_policy_marketing),
    ];

    return Container(
      margin: const EdgeInsets.fromLTRB(45, 11, 45, 40),
      child: Column(
        children: [
          // 구분선
          _Divider(context),

          // 약관 전체 동의 버튼
          _AllAgreementButton(),

          Container(
            margin: const EdgeInsets.only(top: 30),
            child: Column(
              children: policyList.asMap().entries.map((entry) {
                int index = entry.key;
                var e = entry.value;
                return AgreementItem(
                  index: index,
                  isRequired: e.first,
                  text: e.second,
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  /** 약관 전체 동의 버튼 */
  Container _AllAgreementButton() {
    return Container(
      margin: const EdgeInsets.only(top: 31),
      child: OutlineButton(
        text: "오디 약관 전체 동의하기",
        onPressed: () {},
        outlineButtonProvider: agreementButtonProvider,
      ),
    );
  }

  /** 바텀시트 상단 구분선 */
  Align _Divider(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        width: 50,
        height: 5,
        decoration: BoxDecoration(
          color: getColorScheme(context).neutral30,
          borderRadius: BorderRadius.circular(100),
        ),
      ),
    );
  }
}
