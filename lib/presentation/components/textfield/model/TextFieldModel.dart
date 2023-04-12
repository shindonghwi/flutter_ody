import 'package:odac_flutter_app/presentation/components/textfield/model/TextFieldState.dart';

class TextFieldModel {
  final TextFieldState fieldState;
  final String? helpMessage;

  TextFieldModel(
    this.fieldState,
    this.helpMessage,
  );
}
