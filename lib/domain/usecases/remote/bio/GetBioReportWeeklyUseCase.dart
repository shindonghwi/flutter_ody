import 'package:get_it/get_it.dart';
import 'package:ody_flutter_app/data/models/ApiListResponse.dart';
import 'package:ody_flutter_app/data/models/bio/ResponseBioReportListModel.dart';
import 'package:ody_flutter_app/domain/repositories/remote/bio/RemoteBioRepository.dart';

class GetBioReportWeeklyUseCase {
  GetBioReportWeeklyUseCase();

  final RemoteBioRepository _remoteBioRepository = GetIt.instance<RemoteBioRepository>();

  Future<ApiListResponse<List<ResponseBioReportListModel>>> call() async {
    return await _remoteBioRepository.getBioReportWeekly();
  }
}
