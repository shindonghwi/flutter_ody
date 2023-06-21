import 'package:get_it/get_it.dart';
import 'package:odac_flutter_app/data/models/ApiResponse.dart';
import 'package:odac_flutter_app/data/models/me/ResponseMeInfoModel.dart';
import 'package:odac_flutter_app/domain/repositories/remote/me/RemoteMeRepository.dart';
import 'package:odac_flutter_app/presentation/features/cache/UserCache.dart';

class DeleteMedicineUseCase {
  DeleteMedicineUseCase();

  final RemoteMeRepository _remoteMeRepository = GetIt.instance<RemoteMeRepository>();

  Future<ApiResponse<void>> call(int medicineSeq) async {
    return await _remoteMeRepository.deleteMedicine(medicineSeq);
  }
}
