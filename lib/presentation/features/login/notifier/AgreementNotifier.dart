import 'package:hooks_riverpod/hooks_riverpod.dart';

class AgreementNotifier extends StateNotifier<List<bool>> {
  AgreementNotifier() : super([false, false, false, false]);

  void change(int index) {
    state[index] = !state[index];
    state = [...state];
  }

  void allChange() {
    final newState = state.map((e) => !state[0]).toList();
    state = [...newState];
  }

  void init() {
    final newState = state.map((e) => false).toList();
    state = [...newState];
  }

  bool isAllRequiredAccepted() => state.sublist(0, state.length - 1).every((element) => element);

  bool isAllAccepted() => state.every((element) => element);
}
