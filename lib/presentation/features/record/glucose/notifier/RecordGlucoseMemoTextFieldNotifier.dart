import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:odac_flutter_app/presentation/components/textarea/model/TextAreaModel.dart';
import 'package:odac_flutter_app/presentation/components/textfield/model/TextFieldState.dart';

class RecordGlucoseMemoTextFieldNotifier extends StateNotifier<TextAreaModel> {
  RecordGlucoseMemoTextFieldNotifier() : super(TextAreaModel(TextFieldState.Default));

  String content = "";

  void change({
    TextFieldState? fieldState = null,
  }) {
    state = TextAreaModel(
      fieldState == null ? state.fieldState : fieldState,
    );
  }

  clear() {
    content = "";
    Future<void>.delayed(
      Duration.zero,
      () => state = TextAreaModel(TextFieldState.Default),
    );
  }
}
