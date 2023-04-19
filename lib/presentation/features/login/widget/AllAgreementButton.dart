import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:odac_flutter_app/presentation/components/button/OutlineDefaultButton.dart';
import 'package:odac_flutter_app/presentation/components/button/model/ButtonNotifier.dart';
import 'package:odac_flutter_app/presentation/components/button/model/ButtonSizeType.dart';
import 'package:odac_flutter_app/presentation/components/button/model/ButtonState.dart';
import 'package:odac_flutter_app/presentation/features/login/provider/AgreementProvider.dart';
import 'package:odac_flutter_app/presentation/utils/Common.dart';

class AllAgreementButton extends HookConsumerWidget {
  const AllAgreementButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final policyItemsState = ref.watch(agreementPolicyItemProvider);
    final policyItemsRead = ref.read(agreementPolicyItemProvider.notifier);
    final isButtonActivated =
        policyItemsRead.isAllAccepted() ? ButtonState.Activated : ButtonState.Default;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 32),
      child: OutlineDefaultButton(
        text: getAppLocalizations(context).login_policy_all_agree,
        type: ButtonSizeType.Small,
        onPressed: () {
          policyItemsRead.allChange();
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
