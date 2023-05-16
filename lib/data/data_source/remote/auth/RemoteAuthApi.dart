import 'package:google_sign_in/google_sign_in.dart';
import 'package:odac_flutter_app/data/models/ApiResponse.dart';

class RemoteAuthApi {
  RemoteAuthApi();

  Future<ApiResponse<bool>> doGoogleLogin() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    return ApiResponse(
      status: 200,
      message: "ㅁ",
      data: false,
    );
  }
}
