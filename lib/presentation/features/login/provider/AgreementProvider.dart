import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:odac_flutter_app/presentation/components/button/model/ButtonState.dart';
import 'package:odac_flutter_app/presentation/components/button/notifier/OutlineButtonNotifier.dart';
import 'package:odac_flutter_app/presentation/features/login/notifier/AgreementNotifier.dart';

// 약관 동의 버튼
final agreementButtonProvider =
    StateNotifierProvider<OutlineButtonNotifier, ButtonState>(
  (_) => OutlineButtonNotifier(state: ButtonState.Default),
);

// 약관 아이템
final agreementPolicyItemProvider =
    StateNotifierProvider<AgreementNotifier, List<bool>>(
  (_) => AgreementNotifier(),
);
