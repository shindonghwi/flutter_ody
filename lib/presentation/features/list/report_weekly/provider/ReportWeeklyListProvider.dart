import 'package:get_it/get_it.dart';
import 'package:ody_flutter_app/data/models/bio/ResponseBioReportListModel.dart';
import 'package:ody_flutter_app/domain/usecases/remote/bio/GetBioReportWeeklyUseCase.dart';
import 'package:ody_flutter_app/presentation/models/UiState.dart';
import 'package:riverpod/riverpod.dart';

final reportWeeklyListProvider =
    StateNotifierProvider<ReportWeeklyListNotifier, UIState<List<ResponseBioReportListModel>?>>(
  (_) => ReportWeeklyListNotifier(),
);

class ReportWeeklyListNotifier extends StateNotifier<UIState<List<ResponseBioReportListModel>?>> {
  ReportWeeklyListNotifier() : super(Idle());

  void requestWeeklyList() async {
    state = Loading();
    final res = await GetIt.instance.get<GetBioReportWeeklyUseCase>().call();
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
