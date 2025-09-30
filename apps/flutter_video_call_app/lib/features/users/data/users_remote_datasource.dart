import 'package:dio/dio.dart';
import '../models/user_model.dart';

class UsersRemoteDataSource {
  final Dio dio;
  UsersRemoteDataSource(this.dio);

  Future<List<UserModel>> fetchUsers() async {
    final resp = await dio.get('/users?page=1');
    final list = resp.data['data'] as List;
    return list.map((e) => UserModel.fromJson(e)).toList();
  }
}
