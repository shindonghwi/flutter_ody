import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:odac_flutter_app/presentation/components/button/model/ButtonState.dart';
import 'package:odac_flutter_app/presentation/components/button/notifier/OutlineButtonNotifier.dart';

final StateNotifierProvider policyAgreementProvider = StateNotifierProvider<OutlineButtonNotifier, ButtonState>(
  (_) => OutlineButtonNotifier(state: ButtonState.Default),
);
