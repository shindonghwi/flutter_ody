import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:odac_flutter_app/presentation/features/login/provider/LoginLoadingProvider.dart';
import 'package:odac_flutter_app/presentation/features/login/widget/AgreementItem.dart';
import 'package:odac_flutter_app/presentation/features/login/widget/AllAgreementButton.dart';
import 'package:odac_flutter_app/presentation/features/login/widget/AllConfirmButton.dart';
import 'package:odac_flutter_app/presentation/ui/colors.dart';
import 'package:odac_flutter_app/presentation/utils/Common.dart';
import 'package:odac_flutter_app/presentation/utils/dto/Pair.dart';

class AgreementBottomSheet extends HookConsumerWidget {
  const AgreementBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch<bool>(loginLoadingProvider);

    List<Pair> policyList = [
      Pair(true, getAppLocalizations(context).login_policy_age),
      Pair(true, getAppLocalizations(context).login_policy_service),
      Pair(true, getAppLocalizations(context).login_policy_individual),
      Pair(false, getAppLocalizations(context).login_policy_marketing),
    ];

    return SafeArea(
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(45, 7, 45, 40),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // 구분선
                _Divider(context),

                // 약관 전체 동의 버튼
                AllAgreementButton(),

                // 약관 아이템
                _PolicyItems(policyList),

                // 확인버튼
                AllConfirmButton(),
              ],
            ),
          ),
          if (isLoading) _LoadingProgressBar(),
        ],
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

  /** 약관 목록 */
  Container _PolicyItems(List<Pair> policyList) {
    return Container(
      margin: const EdgeInsets.only(top: 27),
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
    );
  }

  /** 로딩 프로그레스 바 */
  Positioned _LoadingProgressBar() {
    return Positioned(
      left: 0,
      top: 0,
      right: 0,
      bottom: 0,
      child: Container(
        child: Align(
          alignment: Alignment.center,
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
