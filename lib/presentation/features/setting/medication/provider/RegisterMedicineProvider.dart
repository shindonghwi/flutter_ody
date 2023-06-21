import 'package:get_it/get_it.dart';
import 'package:odac_flutter_app/data/models/me/RequestMeMedicineModel.dart';
import 'package:odac_flutter_app/data/models/me/ResponseMeMedicineModel.dart';
import 'package:odac_flutter_app/domain/models/me/YoilType.dart';
import 'package:odac_flutter_app/domain/usecases/remote/me/PostMeMedicineUseCase.dart';
import 'package:odac_flutter_app/presentation/models/UiState.dart';
import 'package:riverpod/riverpod.dart';

final registerMedicineProvider = StateNotifierProvider<RegisterMedicineNotifier, UIState<String>>(
  (_) => RegisterMedicineNotifier(),
);

class RegisterMedicineNotifier extends StateNotifier<UIState<String>> {
  RegisterMedicineNotifier() : super(Idle()) {
    _dataClear();
  }

  void register() async {
    state = Loading();
    final res = await GetIt.instance.get<PostMeMedicineUseCase>().call(data: data);
    if (res.status == 200) {
      if (res.data != null){
        responseData = res.data!;
      }
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
