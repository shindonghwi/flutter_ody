import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:odac_flutter_app/presentation/components/textarea/model/TextAreaModel.dart';
import 'package:odac_flutter_app/presentation/components/textfield/model/TextFieldState.dart';

final recordGlucoseMemoTextFieldProvider =
StateNotifierProvider<RecordGlucoseMemoTextFieldNotifier, TextAreaModel>(
      (_) => RecordGlucoseMemoTextFieldNotifier(),
);


class RecordGlucoseMemoTextFieldNotifier extends StateNotifier<TextAreaModel> {
  RecordGlucoseMemoTextFieldNotifier() : super(TextAreaModel(TextFieldState.Default));

  String content = "";

  void change({
    TextFieldState? fieldState,
  }) {
    state = TextAreaModel(fieldState ?? state.fieldState,);
  }

}
