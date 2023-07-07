import 'package:ody_flutter_app/domain/models/bio/GlucoseMesaureType.dart';

class GlucoseRecorderModel {
  final DateTime time;
  final GlucoseMeasureType measureType;
  final int glucose;
  final String? memo;
  final int? remindTime;

  GlucoseRecorderModel({
    required this.time,
    required this.measureType,
    required this.glucose,
    this.memo,
    this.remindTime,
  });
}
