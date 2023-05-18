import 'package:hooks_riverpod/hooks_riverpod.dart';

// 홈 화면 Dim 노출 처리
final dimProvider = StateNotifierProvider<DimNotifier, bool>(
  (_) => DimNotifier(),
);

class DimNotifier extends StateNotifier<bool> {
  DimNotifier() : super(false);

  void change(bool isDimOn) => state = isDimOn;
}
