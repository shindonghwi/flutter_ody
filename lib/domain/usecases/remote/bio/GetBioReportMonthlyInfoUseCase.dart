import 'package:get_it/get_it.dart';
import 'package:ody_flutter_app/data/models/ApiResponse.dart';
import 'package:ody_flutter_app/data/models/bio/ResponseBioReportInfoModel.dart';
import 'package:ody_flutter_app/domain/repositories/remote/bio/RemoteBioRepository.dart';

class GetBioReportMonthlyInfoUseCase {
  GetBioReportMonthlyInfoUseCase();

  final RemoteBioRepository _remoteBioRepository = GetIt.instance<RemoteBioRepository>();

  Future<ApiResponse<ResponseBioReportInfoModel>> call(int reportSeq) async {
    return await _remoteBioRepository.getBioReportMonthlyInfo(reportSeq);
  }
}
