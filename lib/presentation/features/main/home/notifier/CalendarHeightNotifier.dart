import 'package:riverpod/riverpod.dart';

class CalendarHeightNotifier extends StateNotifier<double> {
  final initHeight;

  CalendarHeightNotifier(this.initHeight) : super(initHeight);

  void updateHeight(double height) => state = height;

  double getHeight() => state;
}
