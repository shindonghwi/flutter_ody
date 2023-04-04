import 'package:hooks_riverpod/hooks_riverpod.dart';

class AgreementNotifier extends StateNotifier<List<bool>> {
  AgreementNotifier() : super([false, false, false, false]);

  void change(int index) {
    state[index] = !state[index];
    state = [...state];
  }

  void allAccept() {
    bool currentAgreement = state[0];
    state = state.map((e) => !currentAgreement).toList();
  }

  bool isAllRequiredAccepted() => state.sublist(0, state.length - 1).every((element) => element);

  bool isAllAccepted() => state.every((element) => element);
}
