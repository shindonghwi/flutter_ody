import 'package:hooks_riverpod/hooks_riverpod.dart';

class DiseaseSelectNotifier extends StateNotifier<List<bool>> {
  DiseaseSelectNotifier() : super([true, false, false]);

  void change(int index) {
    state[index] = !state[index];
    state = [...state];
  }

  clear() => Future<void>.delayed(
        Duration.zero,
        () => state = [true, false, false],
      );

  bool hasTrue() => state.any((element) => element);
}
