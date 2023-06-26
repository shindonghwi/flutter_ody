import 'package:get_it/get_it.dart';
import 'package:ody_flutter_app/data/models/bio/RequestBioGlucoseModel.dart';
import 'package:ody_flutter_app/data/models/bio/ResponseBioBloodPressureModel.dart';
import 'package:ody_flutter_app/data/models/bio/ResponseBioGlucoseModel.dart';
import 'package:ody_flutter_app/domain/usecases/remote/bio/GetBioHistoryForDaysUseCase.dart';
import 'package:ody_flutter_app/presentation/models/UiState.dart';
import 'package:ody_flutter_app/presentation/utils/CollectionUtil.dart';
import 'package:riverpod/riverpod.dart';

final recordListGlucoseProvider =
    StateNotifierProvider<RecordListGlucoseProviderNotifier, UIState<List<ResponseBioGlucoseModel>?>>(
  (_) => RecordListGlucoseProviderNotifier(),
);

class RecordListGlucoseProviderNotifier extends StateNotifier<UIState<List<ResponseBioGlucoseModel>?>> {
  RecordListGlucoseProviderNotifier() : super(Idle());

  void requestBioGlucoseList(int year, int month, int day) async {
    state = Loading();
    final res = await GetIt.instance.get<GetBioHistoryForDaysUseCase>().call(year: year, month: month, day: day);
    if (res.status == 200) {
      _updateBioGlucoseList(res.data?.glucoses.reversed.toList());
    } else {
      state = Failure(res.message);
    }
  }

  void _updateBioGlucoseList(List<ResponseBioGlucoseModel>? data) {
    if (!CollectionUtil.isNullorEmpty(data)) {
      state = Success(data);
    } else {
      state = Success(null);
    }
  }

  void addGlucose(ResponseBioGlucoseModel data) {
    if (state is Success) {
      final currentList = (state as Success<List<ResponseBioGlucoseModel>>).value;
      final updatedList =
      CollectionUtil.isNullorEmpty(currentList) ? [data] : [data, ...currentList];
      state = Success(updatedList);
    }
  }


  void init() {
    state = Idle();
  }
}
