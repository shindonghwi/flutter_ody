import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_it/get_it.dart';
import 'package:ody_flutter_app/data/models/me/RequestMeMedicineModel.dart';
import 'package:ody_flutter_app/data/models/me/ResponseMeMedicineModel.dart';
import 'package:ody_flutter_app/domain/models/me/YoilType.dart';
import 'package:ody_flutter_app/domain/usecases/remote/me/PostMeLeaveUseCase.dart';
import 'package:ody_flutter_app/domain/usecases/remote/me/PostMeMedicineUseCase.dart';
import 'package:ody_flutter_app/presentation/models/UiState.dart';
import 'package:ody_flutter_app/presentation/utils/CollectionUtil.dart';
import 'package:ody_flutter_app/presentation/utils/Common.dart';
import 'package:ody_flutter_app/presentation/utils/date/DateTransfer.dart';
import 'package:ody_flutter_app/presentation/utils/notifications/NotificationsUtil.dart';
import 'package:riverpod/riverpod.dart';

final leaveProvider = StateNotifierProvider<LeaveNotifier, UIState<String>>(
      (_) => LeaveNotifier(),
);

class LeaveNotifier extends StateNotifier<UIState<String>> {
  LeaveNotifier() : super(Idle());

  void requestLeave(String reason) async {
    state = Loading();
    final res = await GetIt.instance.get<PostMeLeaveUseCase>().call(reason: reason);
    if (res.status == 200) {
      state = Success("");
    } else {
      state = Failure(res.message);
    }
  }

  void init() {
    state = Idle();
  }
}
