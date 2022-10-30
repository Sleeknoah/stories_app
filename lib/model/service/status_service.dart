import 'package:dio/dio.dart';
import 'package:stories_app/model/dio_client.dart';

import '../api_constants.dart';

class StatusService {
  var options = BaseOptions(
    baseUrl: ApiConstants.baseUrl,
    receiveDataWhenStatusError: true,
    headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    },
  );

  Future<dynamic> retrieveStatus() async {
    var dio = DioClient(option: options).client();
    try {
      Response response = await dio.get(
        ApiConstants.statusUrl,
      );
      print(response.data);
      return response;
    } on DioError catch (e) {
      throw 'error';
    }
  }
}
