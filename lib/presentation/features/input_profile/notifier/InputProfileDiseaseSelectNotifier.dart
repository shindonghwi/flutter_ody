import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ody_flutter_app/domain/models/me/DiseaseType.dart';

final diseaseListStateProvider =
    StateNotifierProvider<DiseaseSelectNotifier, List<DiseaseType>>(
  (_) => DiseaseSelectNotifier(),
);

class DiseaseSelectNotifier extends StateNotifier<List<DiseaseType>> {
  DiseaseSelectNotifier() : super([DiseaseType.HealthCare]);

  void click(DiseaseType type) {
    if (state.contains(type)) {
      state.remove(type);
      state = [...state];
    } else {
      state.add(type);
      state = [...state];
    }
  }
}
