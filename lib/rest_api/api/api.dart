import 'dart:convert';

import 'package:dio/dio.dart';

import '../../model/user_submit_felling_response_model.dart';
import '../rest_api.dart';

class UserSubmitFellingApi {
  static Future<UserHistoryFellingResponseModel?> userSubmitFellingApi(String date) async {
    var dio = Dio();
    String token = 'f6d646a6c2f2df883ea0cccaa4097358ede98284';
    Map<String, dynamic> request = {
      "user_id": "3206161992",
      "feeling_date": date
    };

    final response = await dio.post(
        '${RestAPI.API_BASE_URL}${RestAPI.getListOfUserFellingAPI}',
        options: Options(headers: {
          'X-Api-Key': token,
        }),
        data: request);
    if (response.statusCode == 200) {
      print('response ${response.data}');
      var data =
          UserHistoryFellingResponseModel.fromJson(jsonDecode(response.data));
      print('inside the value :${data.data?.feelingPercentage?.calm}');
      return data;
    }
  }
}
