import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:odac_flutter_app/presentation/features/main/home/notifier/DimNotifier.dart';

// 홈 화면 Dim 노출 처리
final DimProvider = StateNotifierProvider<DimNotifier, bool>(
  (_) => DimNotifier(),
);
