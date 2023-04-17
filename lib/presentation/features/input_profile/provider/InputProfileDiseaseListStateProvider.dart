import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:odac_flutter_app/presentation/features/input_profile/notifier/InputProfileDiseaseSelectNotifier.dart';

final diseaseListStateProvider = StateNotifierProvider<DiseaseSelectNotifier, List<bool>>(
  (_) => DiseaseSelectNotifier(),
);
