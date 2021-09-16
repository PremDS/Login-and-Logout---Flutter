import 'package:http/http.dart' as http;
import 'package:login_system/model/login_model.dart';


class APIServices {
  static var client = http.Client();
  static String apiURL = 'http://localhost:8000/api';
  static Future<bool> loginCustomer(String username, String password) async {
    Map<String, String> requestHeaders = {
      'Content-Type':'application/x-www-form-urlencoded'
    };
    var response = await client.post(
        Uri.parse("$apiURL/login/"),
        headers: requestHeaders,
      body: {
          "username":username,
          "password":password
      }

    );
    if (response.statusCode == 200) {
      var jsonString = response.body;
      LoginResponseModel responseModel = loginResponseFromJson(jsonString);
      return responseModel.statusCode == 200 ? true:false;
    }
    return false;

  }
}