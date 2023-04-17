import 'package:odac_flutter_app/presentation/features/input_profile/notifier/InputProfileTextFieldNotifier.dart';

class InputProfileBirthdayTextFieldNotifier extends InputProfileTextFieldNotifier {
  InputProfileBirthdayTextFieldNotifier() : super();

  @override
  RegExp get regex => RegExp(r"^\d{4}/\d{2}/\d{2}$");

  void updateBirthday(String newInput) => content = newInput;

  bool checkBirthday() => regex.hasMatch(content);
}
