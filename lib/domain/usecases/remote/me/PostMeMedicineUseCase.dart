import 'package:get_it/get_it.dart';
import 'package:odac_flutter_app/data/models/ApiResponse.dart';
import 'package:odac_flutter_app/data/models/me/RequestMeMedicineModel.dart';
import 'package:odac_flutter_app/domain/models/me/YoilType.dart';
import 'package:odac_flutter_app/domain/repositories/remote/me/RemoteMeRepository.dart';
import 'package:odac_flutter_app/presentation/utils/date/DateParser.dart';

class PostMeMedicineUseCase {
  PostMeMedicineUseCase();

  final RemoteMeRepository _remoteMeRepository = GetIt.instance<RemoteMeRepository>();

  Future<ApiResponse<void>> call({
    required String name,
    required List<YoilType> days,
    required DateTime time,
    required bool enabled,
  }) async {
    final res = await _remoteMeRepository.postMedicine(
      RequestMeMedicineModel(
        name: name,
        days: days,
        time: DateParser.getGlobalTimeDate(time),
        enabled: enabled,
      ),
    );
    return res;
  }
}
