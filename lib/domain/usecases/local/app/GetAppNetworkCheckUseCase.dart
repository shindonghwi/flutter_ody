import 'package:http/http.dart' as http;

class GetAppNetworkCheckUseCase {
  GetAppNetworkCheckUseCase();

  Future<bool> call(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}
