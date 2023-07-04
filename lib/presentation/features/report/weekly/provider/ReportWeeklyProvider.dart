import 'package:get_it/get_it.dart';
import 'package:ody_flutter_app/data/models/bio/ResponseBioReportListModel.dart';
import 'package:ody_flutter_app/data/models/bio/ResponseBioReportWeeklyInfoModel.dart';
import 'package:ody_flutter_app/domain/usecases/remote/bio/GetBioReportMontlyUseCase.dart';
import 'package:ody_flutter_app/domain/usecases/remote/bio/GetBioReportWeeklyInfoUseCase.dart';
import 'package:ody_flutter_app/presentation/models/UiState.dart';
import 'package:riverpod/riverpod.dart';

final reportWeeklyProvider =
    StateNotifierProvider<ReportWeeklyNotifier, UIState<ResponseBioReportWeeklyInfoModel?>>(
  (_) => ReportWeeklyNotifier(),
);

class ReportWeeklyNotifier extends StateNotifier<UIState<ResponseBioReportWeeklyInfoModel?>> {
  ReportWeeklyNotifier() : super(Idle());

  void requestWeeklyInfo(int? reportSeq) async {
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
