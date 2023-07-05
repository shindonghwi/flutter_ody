import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_it/get_it.dart';
import 'package:ody_flutter_app/data/models/me/RequestMeMedicineModel.dart';
import 'package:ody_flutter_app/data/models/me/ResponseMeMedicineModel.dart';
import 'package:ody_flutter_app/domain/models/me/YoilType.dart';
import 'package:ody_flutter_app/domain/usecases/remote/me/PostMeMedicineUseCase.dart';
import 'package:ody_flutter_app/presentation/models/UiState.dart';
import 'package:ody_flutter_app/presentation/utils/CollectionUtil.dart';
import 'package:ody_flutter_app/presentation/utils/Common.dart';
import 'package:ody_flutter_app/presentation/utils/date/DateTransfer.dart';
import 'package:ody_flutter_app/presentation/utils/notifications/NotificationsUtil.dart';
import 'package:riverpod/riverpod.dart';

final registerMedicineProvider = StateNotifierProvider<RegisterMedicineNotifier, UIState<String>>(
  (_) => RegisterMedicineNotifier(),
);

class RegisterMedicineNotifier extends StateNotifier<UIState<String>> {
  RegisterMedicineNotifier() : super(Idle()) {
    _dataClear();
  }

  AppLocalization get _getAppLocalization => GetIt.instance<AppLocalization>();

  void register() async {
    state = Loading();
    final res = await GetIt.instance.get<PostMeMedicineUseCase>().call(data: data);
    if (res.status == 200) {
      if (res.data != null) {
        responseData = res.data!;
      }
      registerMedicineNotification();
      state = Success("");
    } else {
      state = Failure(res.message);
    }
  }

  late ResponseMeMedicineModel responseData;
  late RequestMeMedicineModel data;

  void updateMedicineName(String name) {
    data = RequestMeMedicineModel(
      name: name,
      days: data.days,
      time: data.time,
      enabled: data.enabled,
    );
  }

  void updateMedicineYoil(List<YoilType> items) {
    data = RequestMeMedicineModel(
      name: data.name,
      days: items,
      time: data.time,
      enabled: data.enabled,
    );
  }

  void updateMedicineTime(String time) {
    data = RequestMeMedicineModel(
      name: data.name,
      days: data.days,
      time: time,
      enabled: data.enabled,
    );
  }

  /// 약 알림 등록
  void registerMedicineNotification(){
    List<Day> days = [];

    for (var element in data.days) {
      final day = DateTransfer.convertShortYoilTypeToDayType(element);
      if (day != null){
        days.add(day);
      }
    }

    if (!CollectionUtil.isNullorEmpty(days)){
      NotificationsUtil.registerNotification(
        type: NotificationType.ALARM,
        notificationId: responseData.medicineSeq!,
        hour: int.parse(data.time.split(":").first),
        minutes: int.parse(data.time.split(":").last),
        message: _getAppLocalization.get().notification_message_alarm(data.name),
        scheduledDays: days,
      );
    }
  }

  void init() {
    _dataClear();
    state = Idle();
  }

  void _dataClear() {
    data = RequestMeMedicineModel(
      name: "",
      time: "",
      days: [],
      enabled: true,
    );
  }
}
