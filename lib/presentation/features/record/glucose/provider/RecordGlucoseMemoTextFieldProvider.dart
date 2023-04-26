import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:odac_flutter_app/presentation/components/textarea/model/TextAreaModel.dart';
import 'package:odac_flutter_app/presentation/features/record/glucose/notifier/RecordGlucoseMemoTextFieldNotifier.dart';

final RecordGlucoseMemoTextFieldProvider =
    StateNotifierProvider<RecordGlucoseMemoTextFieldNotifier, TextAreaModel>(
  (_) => RecordGlucoseMemoTextFieldNotifier(),
);
