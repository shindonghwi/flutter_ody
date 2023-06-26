import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ody_flutter_app/data/models/bio/ResponseBioBloodPressureModel.dart';
import 'package:ody_flutter_app/data/models/bio/ResponseBioStatusModel.dart';
import 'package:ody_flutter_app/presentation/features/record/blood_pressure/models/BpRecorderModel.dart';
import 'package:ody_flutter_app/presentation/features/record/model/RecordRangeStatus.dart';

// 사용자가 입력한 수축기, 이완기 혈압, 맥박
final bloodPressureRecorderProvider = StateNotifierProvider<BloodPressureRecorderNotifier, BpRecorderModel>(
  (_) => BloodPressureRecorderNotifier(),
);

class BloodPressureRecorderNotifier extends StateNotifier<BpRecorderModel> {
  final yearMonthDay = DateTime.now().toString().split(" ")[0].split("-");
  final hourMinuteSecond = DateTime.now().toString().split(" ")[1].split(":");
  var bpStatus = RecordRangeStatus.None;

  BloodPressureRecorderNotifier() : super(BpRecorderModel(time: DateTime.now(), systolic: 0, diastolic: 0, hr: 0));

  void updateTime(DateTime time) {
    state = BpRecorderModel(time: time, systolic: state.systolic, diastolic: state.diastolic, hr: state.hr);
  }

  void updateSystolicBloodPressure(int systolicBloodPressure) {
    state =
        BpRecorderModel(time: state.time, systolic: systolicBloodPressure, diastolic: state.diastolic, hr: state.hr);
  }

  void updateDiastolicBloodPressure(int diastolicBloodPressure) {
    state =
        BpRecorderModel(time: state.time, systolic: state.systolic, diastolic: diastolicBloodPressure, hr: state.hr);
  }

  void updateHeartRate(int heartRate) {
    state = BpRecorderModel(time: state.time, systolic: state.systolic, diastolic: state.diastolic, hr: heartRate);
  }

  ResponseBioBloodPressureModel getBioBpModel() {
    return ResponseBioBloodPressureModel(
      systolicBloodPressure: state.systolic,
      diastolicBloodPressure: state.diastolic,
      heartRate: state.hr,
      status: ResponseBioStatusModel(
        code: bpStatus.name.toString(),
        name: RecordRangeStatusHelper.fromString(bpStatus),
      ),
      createdAt: "${DateTime.now().hour}:${DateTime.now().minute}",
    );
  }

  int checkBpLevel() {
    final int systolic = state.systolic;
    final int diastolic = state.diastolic;
    final int hr = state.hr;

    if (systolic == 0 || diastolic == 0 || hr == 0) {
      return 0;
    }

    if (systolic <= 90 || diastolic <= 60) {
      return 1;
    } else if (systolic <= 120 || diastolic <= 80) {
      return 2;
    } else if (systolic <= 140 || diastolic <= 90) {
      return 3;
    } else if (systolic <= 160 || diastolic <= 100) {
      return 4;
    } else {
      return 5;
    }
  }

  RecordRangeStatus checkBpStatus() {
    final int systolic = state.systolic;
    final int diastolic = state.diastolic;
    final int hr = state.hr;
    if (systolic == 0 || diastolic == 0 || hr == 0) {
      bpStatus = RecordRangeStatus.None;
    }

    if (systolic <= 90 || diastolic <= 60) {
      bpStatus = RecordRangeStatus.LowBp;
    } else if (systolic <= 120 || diastolic <= 80) {
      bpStatus = RecordRangeStatus.Normal;
    } else if (systolic <= 140 || diastolic <= 90) {
      bpStatus = RecordRangeStatus.HighBp;
    } else if (systolic <= 160 || diastolic <= 100) {
      bpStatus = RecordRangeStatus.HighBp;
    } else {
      bpStatus = RecordRangeStatus.HighBp;
    }
    return bpStatus;
  }

  void init(){
    state = BpRecorderModel(time: DateTime.now(), systolic: 0, diastolic: 0, hr: 0);
  }

}
