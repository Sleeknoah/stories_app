import 'package:dio/dio.dart';
import 'package:stories_app/model/response/data.dart';
import 'package:stories_app/model/service/status_service.dart';

class StatusRepository {
  final StatusService statusService;
  StatusRepository({required this.statusService});

  Future<Data> getStatus() async {
    Response response = await statusService.retrieveStatus();
    print(response.data['profile']['friends'][3]);
    Data data = Data.fromJson(response.data);
    return data;
  }
}
