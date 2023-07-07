import 'package:riverpod/riverpod.dart';

final medicineScreenModeProvider = StateNotifierProvider<MedicineScreenModeNotifier, bool>(
  (_) => MedicineScreenModeNotifier(),
);

class MedicineScreenModeNotifier extends StateNotifier<bool> {
  MedicineScreenModeNotifier() : super(false);

  void changeMode(bool flag) async {
    state = flag;
  }
}
