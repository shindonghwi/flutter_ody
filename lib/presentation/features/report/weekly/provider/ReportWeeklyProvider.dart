import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:ody_flutter_app/data/models/bio/ResponseBioReportInfoModel.dart';
import 'package:ody_flutter_app/domain/usecases/remote/bio/GetBioReportWeeklyInfoUseCase.dart';
import 'package:ody_flutter_app/presentation/models/UiState.dart';
import 'package:riverpod/riverpod.dart';

final reportWeeklyProvider = StateNotifierProvider<ReportWeeklyNotifier, UIState<ResponseBioReportInfoModel?>>(
  (_) => ReportWeeklyNotifier(),
);

class ReportWeeklyNotifier extends StateNotifier<UIState<ResponseBioReportInfoModel?>> {
  ReportWeeklyNotifier() : super(Idle());

  void requestWeeklyInfo(int? reportSeq) async {
    debugPrint("requestWeeklyInfo");
    state = Loading();
    final res = await GetIt.instance.get<GetBioReportWeeklyInfoUseCase>().call(reportSeq ?? -1);
    if (res.status == 200) {
      Future.delayed(const Duration(milliseconds: 300), () {
        state = Success(res.data);
      });
    } else {
      state = Failure(res.message);
    }
  }

  void init() {
    state = Idle();
  }
}
