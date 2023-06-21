import 'package:ody_flutter_app/data/models/me/ResponseMeInfoModel.dart';

final userCache = UserCache();

class UserCache {
  ResponseMeInfoModel? userInfo;

  setUserInfo(ResponseMeInfoModel? user) => userInfo = user;

  UserCache();
}
