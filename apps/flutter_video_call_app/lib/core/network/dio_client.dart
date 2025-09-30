// import 'package:dio/dio.dart';
//
// class DioClient {
//   final Dio dio;
//   DioClient(this.dio) {
//     dio.options
//       ..baseUrl = "https://reqres.in/api"
//       ..connectTimeout = const Duration(seconds: 10)
//       ..receiveTimeout = const Duration(seconds: 10);
//   }
// }

import 'package:dio/dio.dart';

class ApiClient {
  final Dio dio = Dio(BaseOptions(baseUrl: "https://reqres.in/api"));
}
