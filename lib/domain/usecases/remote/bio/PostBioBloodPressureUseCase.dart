import 'package:get_it/get_it.dart';
import 'package:odac_flutter_app/data/models/ApiResponse.dart';
import 'package:odac_flutter_app/data/models/auth/ResponseSocialLoginModel.dart';
import 'package:odac_flutter_app/data/models/bio/RequestBioBloodPressureModel.dart';
import 'package:odac_flutter_app/domain/repositories/remote/bio/RemoteBioRepository.dart';

class PostBioBloodPressureUseCase {
  PostBioBloodPressureUseCase();

  final RemoteBioRepository _remoteBioRepository = GetIt.instance<RemoteBioRepository>();

  Future<ApiResponse<void>> call({
    required String time,
    required int systolicBloodPressure,
    required int diastolicBloodPressure,
    required int heartRate,
  }) async {
    final res = await _remoteBioRepository.postBloodPressure(
      RequestBioBloodPressureModel(
        time: time,
        systolicBloodPressure: systolicBloodPressure,
        diastolicBloodPressure: diastolicBloodPressure,
        heartRate: heartRate,
      ),
    );
    return res;
  }
}
