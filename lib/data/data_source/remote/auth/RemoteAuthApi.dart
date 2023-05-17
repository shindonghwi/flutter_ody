import 'package:google_sign_in/google_sign_in.dart';
import 'package:odac_flutter_app/data/models/ApiResponse.dart';
import 'package:odac_flutter_app/domain/models/auth/LoginPlatform.dart';
import 'package:odac_flutter_app/domain/models/auth/SocialLoginModel.dart';

class RemoteAuthApi {
  RemoteAuthApi();

  Future<ApiResponse<SocialLoginModel>> doGoogleLogin() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser == null) {
      return ApiResponse<SocialLoginModel>(
        status: 400,
        message: "fail",
        data: null,
      );
    } else {
      return await googleUser.authentication.then((value) {
        return ApiResponse<SocialLoginModel>(
          status: 200,
          message: "success",
          data: SocialLoginModel(
            LoginPlatform.Google,
            value.accessToken,
          ),
        );
      });
    }
  }
}
