import 'package:get_it/get_it.dart';
import 'package:ody_flutter_app/domain/usecases/remote/me/PatchMeConfigNotificationUseCase.dart';
import 'package:ody_flutter_app/presentation/models/UiState.dart';
import 'package:ody_flutter_app/presentation/utils/Common.dart';
import 'package:riverpod/riverpod.dart';

final alarmListProvider = StateNotifierProvider<AlarmListNotifier, List<bool>>(
  (_) => AlarmListNotifier(),
);

class AlarmListNotifier extends StateNotifier<List<bool>> {
  AlarmListNotifier() : super([false, false, false, false, false, false]);

  final _patchMeConfigNotificationUseCase = GetIt.instance.get<PatchMeConfigNotificationUseCase>();

  void updateList(List<bool> items){
    state = [...items];
  }

  void changeAll() async {
    state = [...List.generate(state.length, (index) => !state[0])];
    _requestNotificationInfo();
  }

  void changeIndex(int alarmIndex) async {
    state = [
      ...List.generate(state.length, (index) {
        if (index == alarmIndex) {
          return !state[index];
        } else {
          return state[index];
        }
      })
    ];
    _requestNotificationInfo();
  }

  void _requestNotificationInfo() async {
    final res = await _patchMeConfigNotificationUseCase.call(
      all: state[0],
      medicine: state[1],
      step: state[2],
      bloodPressure: state[3],
      glucose: state[4],
      report: state[5],
    );
  }
}
