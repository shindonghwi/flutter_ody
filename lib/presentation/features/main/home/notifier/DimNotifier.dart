import 'package:hooks_riverpod/hooks_riverpod.dart';

class DimNotifier extends StateNotifier<bool> {
  DimNotifier() : super(false);

  void change(bool isDimOn) => state = isDimOn;
}
