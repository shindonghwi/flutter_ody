import 'package:hooks_riverpod/hooks_riverpod.dart';

final termsAppPolicyProvider = StateNotifierProvider<TermsNotifier, List<bool>>(
  (_) => TermsNotifier(),
);

class TermsNotifier extends StateNotifier<List<bool>> {
  TermsNotifier() : super([false, false, false]);

  void change(int index) {
    state[index] = !state[index];
    state = [...state];
  }

  void allChange() {
    final newState = state.map((e) => !isAllAccepted()).toList();
    state = [...newState];
  }

  void init() {
    final newState = state.map((e) => false).toList();
    state = [...newState];
  }
  bool isAllAccepted() => state.every((element) => element);
}
