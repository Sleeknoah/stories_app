import 'package:dio/dio.dart';

class DioClient {
  final BaseOptions option;

  DioClient({required this.option});

  Dio client() {
    return Dio(option);
  }
}
