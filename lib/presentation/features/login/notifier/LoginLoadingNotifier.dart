import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginLoadingNotifier extends StateNotifier<bool> {
  LoginLoadingNotifier() : super(false);

  void change(bool index) => state = index;
}
