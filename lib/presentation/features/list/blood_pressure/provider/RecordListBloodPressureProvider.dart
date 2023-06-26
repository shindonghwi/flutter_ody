import 'package:get_it/get_it.dart';
import 'package:ody_flutter_app/data/models/bio/ResponseBioBloodPressureModel.dart';
import 'package:ody_flutter_app/domain/usecases/remote/bio/GetBioHistoryForDaysUseCase.dart';
import 'package:ody_flutter_app/presentation/models/UiState.dart';
import 'package:ody_flutter_app/presentation/utils/CollectionUtil.dart';
import 'package:riverpod/riverpod.dart';

final recordListBloodPressureProvider =
    StateNotifierProvider<RecordListBloodPressureNotifier, UIState<List<ResponseBioBloodPressureModel>?>>(
  (_) => RecordListBloodPressureNotifier(),
);

class RecordListBloodPressureNotifier extends StateNotifier<UIState<List<ResponseBioBloodPressureModel>?>> {
  RecordListBloodPressureNotifier() : super(Idle());

  void requestBioBloodPressureList(int year, int month, int day) async {
    state = Loading();
    final res = await GetIt.instance.get<GetBioHistoryForDaysUseCase>().call(year: year, month: month, day: day);
    if (res.status == 200) {
      _updateBioBloodPressureList(res.data?.bloodPressures.reversed.toList());
    } else {
      state = Failure(res.message);
    }
  }

  void _updateBioBloodPressureList(List<ResponseBioBloodPressureModel>? data) {
    if (!CollectionUtil.isNullorEmpty(data)) {
      state = Success(data);
    } else {
      state = Success(null);
    }
  }

  void addBloodPressure(ResponseBioBloodPressureModel data) {
    if (state is Success) {
      final currentList = (state as Success<List<ResponseBioBloodPressureModel>>).value;
      final updatedList =
      CollectionUtil.isNullorEmpty(currentList) ? [data] : [data, ...currentList];
      state = Success(updatedList);
    }
  }


  void init() {
    state = Idle();
  }
}
