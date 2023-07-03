import 'package:get_it/get_it.dart';
import 'package:ody_flutter_app/data/models/bio/ResponseBioReportListModel.dart';
import 'package:ody_flutter_app/domain/usecases/remote/bio/GetBioReportMontlyUseCase.dart';
import 'package:ody_flutter_app/presentation/models/UiState.dart';
import 'package:riverpod/riverpod.dart';

final reportMonthlyProvider =
    StateNotifierProvider<ReportMonthlyNotifier, UIState<List<ResponseBioReportListModel>?>>(
  (_) => ReportMonthlyNotifier(),
);

class ReportMonthlyNotifier extends StateNotifier<UIState<List<ResponseBioReportListModel>?>> {
  ReportMonthlyNotifier() : super(Idle());

  void requestMonyhlyInfo() async {
    state = Loading();
    final res = await GetIt.instance.get<GetBioReportMonthlyUseCase>().call();
    if (res.status == 200) {
      state = Success(res.list);
    } else {
      state = Failure(res.message);
    }
  }

  void init() {
    state = Idle();
  }
}
