import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:odac_flutter_app/presentation/components/textfield/model/TextFieldModel.dart';
import 'package:odac_flutter_app/presentation/features/input_profile/notifier/InputProfileWeightTextFieldNotifier.dart';

final InputProfileWeightTextFieldProvider =
    StateNotifierProvider<InputProfileWeightTextFieldNotifier, TextFieldModel>(
  (_) => InputProfileWeightTextFieldNotifier(),
);
