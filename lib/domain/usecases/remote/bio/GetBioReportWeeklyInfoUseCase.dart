import 'package:get_it/get_it.dart';
import 'package:ody_flutter_app/data/models/ApiListResponse.dart';
import 'package:ody_flutter_app/data/models/ApiResponse.dart';
import 'package:ody_flutter_app/data/models/bio/ResponseBioReportListModel.dart';
import 'package:ody_flutter_app/data/models/bio/ResponseBioReportWeeklyInfoModel.dart';
import 'package:ody_flutter_app/domain/repositories/remote/bio/RemoteBioRepository.dart';

class GetBioReportWeeklyInfoUseCase {
  GetBioReportWeeklyInfoUseCase();

  final RemoteBioRepository _remoteBioRepository = GetIt.instance<RemoteBioRepository>();

  Future<ApiResponse<ResponseBioReportWeeklyInfoModel>> call(int reportSeq) async {
    return await _remoteBioRepository.getBioReportWeeklyInfo(reportSeq);
  }
}
