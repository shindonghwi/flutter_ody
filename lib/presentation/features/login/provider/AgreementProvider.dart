import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:odac_flutter_app/presentation/features/login/notifier/AgreementNotifier.dart';

// 약관 아이템
final agreementPolicyItemProvider = StateNotifierProvider<AgreementNotifier, List<bool>>(
  (_) => AgreementNotifier(),
);
