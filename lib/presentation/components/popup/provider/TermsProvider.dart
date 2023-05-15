import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:odac_flutter_app/presentation/components/popup/notifier/TermsNotifier.dart';

final termsAppPolicyProvider = StateNotifierProvider<TermsNotifier, List<bool>>(
  (_) => TermsNotifier(),
);
