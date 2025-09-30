//
// import '../../../core/network/dio_client.dart';
//
// class AuthRepository {
//   final ApiClient apiClient = ApiClient();
//
//   Future login(String email, String password) async {
//     try {
//       final response = await apiClient.dio.post(
//         "/login",
//         data: {"email": email, "password": password},
//       );
//       return response.statusCode == 200;
//     } catch (_) {
//       return false;
//     }
//   }
// }


class AuthRepository {
  // Hardcoded credentials
  final String _validEmail = 'snehal@example.com';
  final String _validPassword = 'flutter123';

  Future<bool> login(String email, String password) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    if (email == _validEmail && password == _validPassword) {
      return true;
    } else {
      throw Exception('Invalid email or password');
    }
  }
}
