import 'package:get_it/get_it.dart';
import 'package:ody_flutter_app/data/models/ApiResponse.dart';
import 'package:ody_flutter_app/domain/repositories/remote/me/RemoteMeRepository.dart';

class PatchMeConfigNotificationUseCase {
  PatchMeConfigNotificationUseCase();

  final RemoteMeRepository _remoteMeRepository = GetIt.instance<RemoteMeRepository>();

  Future<ApiResponse<void>> call({
    required bool all,
    required bool medicine,
    required bool step,
    required bool bloodPressure,
    required bool glucose,
    required bool report,
  }) async {
    return await _remoteMeRepository.patchConfigNotification(all, medicine, step, bloodPressure, glucose, report);
  }
}
