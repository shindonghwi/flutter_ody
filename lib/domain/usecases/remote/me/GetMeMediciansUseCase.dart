import 'package:get_it/get_it.dart';
import 'package:odac_flutter_app/data/models/ApiListResponse.dart';
import 'package:odac_flutter_app/data/models/me/ResponseMeMedicineModel.dart';
import 'package:odac_flutter_app/domain/repositories/remote/me/RemoteMeRepository.dart';

class GetMeMediciansUseCase {
  GetMeMediciansUseCase();

  final RemoteMeRepository _remoteMeRepository = GetIt.instance<RemoteMeRepository>();

  Future<ApiListResponse<ResponseMeMedicineModel>> call() async {
    return await _remoteMeRepository.getMedicines();
  }
}
