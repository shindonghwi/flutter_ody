import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:odac_flutter_app/presentation/features/record/model/RecordRangeStatus.dart';
import 'package:odac_flutter_app/presentation/utils/dto/Triple.dart';

// 사용자가 입력한 수축기, 이완기 혈압, 맥박
final bloodPressureRecorderProvider =
    StateNotifierProvider<BloodPressureRecorderNotifier, Triple<int, int, int>>(
  (_) => BloodPressureRecorderNotifier(),
);

class BloodPressureRecorderNotifier extends StateNotifier<Triple<int, int, int>> {
  BloodPressureRecorderNotifier() : super(Triple(0, 0, 0));

  void updateSystolicBloodPressure(int systolicBloodPressure) {
    state = Triple(systolicBloodPressure, state.second, state.third);
  }

  void updateDiastolicBloodPressure(int diastolicBloodPressure) {
    state = Triple(state.first, diastolicBloodPressure, state.third);
  }

  void updateHeartRate(int heartRate) {
    state = Triple(state.first, state.second, heartRate);
  }


  int checkBpLevel(){

    final int systolic = state.first;
    final int diastolic = state.second;

    if (systolic == 0 || diastolic == 0){
      return 0;
    }

    if (systolic <= 90 || diastolic <= 60){
      return 1;
    }else if(systolic <= 120 || diastolic <= 80) {
      return 2;
    }else if(systolic <= 140 || diastolic <= 90) {
      return 3;
    }else if(systolic <= 160 || diastolic <= 100) {
      return 4;
    }else{
      return 5;
    }
  }

  RecordRangeStatus checkBpStatus(){

    final int systolic = state.first;
    final int diastolic = state.second;

    if (systolic == 0 || diastolic == 0){
      return RecordRangeStatus.None;
    }

    if (systolic <= 90 || diastolic <= 60){
      return RecordRangeStatus.LowBp;
    }else if(systolic <= 120 || diastolic <= 80) {
      return RecordRangeStatus.Normal;
    }else if(systolic <= 140 || diastolic <= 90) {
      return RecordRangeStatus.HighBp;
    }else if(systolic <= 160 || diastolic <= 100) {
      return RecordRangeStatus.HighBp;
    }else{
      return RecordRangeStatus.HighBp;
    }
  }

}
