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

  /**
   *   정상혈압: 수축기 혈압 120mmHg 미만, 그리고 이완기 혈압 80mmHg 미만
      주의혈압: 수축기 혈압 120-129mmHg, 그리고 이완기 혈압 80mmHg 미만
      고혈압 전단계: 수축기 혈압 130-139mmHg, 또는 이완기 혈압 80-89mmHg
      고혈압 1기: 수축기 혈압 140-159mmHg, 또는 이완기 혈압 90-99mmHg
      고혈압 2기: 수축기 혈압 160mmHg 이상, 또는 이완기 혈압 100mmHg 이상
      수축기단독고혈압: 수축기 혈압 140mmHg 이상, 그리고 이완기 혈압 90mmHg 미만

      - 정상: 정상혈압
      - 위험: 주의혈압, 고혈압 전단계
      - 고위험: 고혈압 1기, 고혈압2기, 수축기단독고혈압
   * */

  int checkBpLevel() {
    final int systolic = state.systolic;
    final int diastolic = state.diastolic;
    final int hr = state.hr;

    if (systolic == 0 || diastolic == 0 || hr == 0) {
      return 0;
    }

    if (systolic < 120 && diastolic < 80) {
      return 1; // 정상
    } else if ((systolic >= 120 && systolic < 130) && diastolic < 80) {
      return 2; // 주의혈압
    } else if ((systolic >= 130 && systolic < 140) || (diastolic >= 80 && diastolic < 90)) {
      return 2; // 고혈압 전단계
    } else if ((systolic >= 140 && systolic < 160) || (diastolic >= 90 && diastolic < 100)) {
      return 3; // 고혈압 1기
    } else if (systolic >= 160 || diastolic >= 100) {
      return 3; // 고혈압 2기
    } else if (systolic >= 140 && diastolic < 90) {
      return 3; // 수축기 단독 고혈압
    }
    return 3;
  }

  RecordRangeStatus checkBpStatus() {
    final int systolic = state.systolic;
    final int diastolic = state.diastolic;
    final int hr = state.hr;
    if (systolic == 0 || diastolic == 0 || hr == 0) {
      bpStatus = RecordRangeStatus.None;
    }

    if (systolic < 120 && diastolic < 80) {
      bpStatus = RecordRangeStatus.Normal;
    } else if ((systolic >= 120 && systolic < 130) && diastolic < 80) {
      bpStatus = RecordRangeStatus.Danger;
    } else if ((systolic >= 130 && systolic < 140) || (diastolic >= 80 && diastolic < 90)) {
      bpStatus = RecordRangeStatus.Danger;
    } else if ((systolic >= 140 && systolic < 160) || (diastolic >= 90 && diastolic < 100)) {
      bpStatus = RecordRangeStatus.Risk;
    } else if (systolic >= 160 || diastolic >= 100) {
      bpStatus = RecordRangeStatus.Risk;
    } else if (systolic >= 140 && diastolic < 90) {
      bpStatus = RecordRangeStatus.Risk;
    }
    return bpStatus;
  }

  void init() {
    state = BpRecorderModel(time: DateTime.now(), systolic: 0, diastolic: 0, hr: 0);
  }
}
