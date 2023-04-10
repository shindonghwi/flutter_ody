import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:odac_flutter_app/presentation/components/bottom_sheet/CommonBottomSheet.dart';
import 'package:odac_flutter_app/presentation/components/button/FillButton.dart';
import 'package:odac_flutter_app/presentation/components/button/model/ButtonNotifier.dart';
import 'package:odac_flutter_app/presentation/components/button/model/ButtonSizeType.dart';
import 'package:odac_flutter_app/presentation/components/button/model/ButtonState.dart';
import 'package:odac_flutter_app/presentation/features/login/provider/AgreementProvider.dart';
import 'package:odac_flutter_app/presentation/features/login/provider/LoginLoadingProvider.dart';
import 'package:odac_flutter_app/presentation/utils/Common.dart';

class AllConfirmButton extends HookConsumerWidget {
  const AllConfirmButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final policyItemsState = ref.watch(agreementPolicyItemProvider);
    final policyItemsRead = ref.read(agreementPolicyItemProvider.notifier);
    final isLoadingRead = ref.read(loginLoadingProvider.notifier);

    final isButtonActivated =
        policyItemsRead.isAllRequiredAccepted() ? ButtonState.Activated : ButtonState.Disabled;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 21),
      child: FillButton(
        text: getAppLocalizations(context).common_confirm,
        type: ButtonSizeType.Normal,
        borderRadius: 100,
        onPressed: () {
          CommonBottomSheet.close(context, closeAction: policyItemsRead.init);

          // TODO: 로그인 화면: 로그인 API 호출로 변경해야함.
          isLoadingRead.state = true;
          Future.delayed(Duration(seconds: 2), () {
            isLoadingRead.state = false;
          });
        },
        buttonProvider: StateNotifierProvider<ButtonNotifier, ButtonState>(
          (_) => ButtonNotifier(
            state: isButtonActivated,
          ),
        ),
      ),
    );
  }
}
