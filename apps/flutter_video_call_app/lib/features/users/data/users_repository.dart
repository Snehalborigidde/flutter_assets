// //
// // import '../../../core/db/db_helper.dart';
// // import '../../../core/network/dio_client.dart';
// //
// // class UsersRepository {
// //   final ApiClient apiClient = ApiClient();
// //
// // Future<List<Map<String, dynamic>>> fetchUsers() async {
// //   try {
// //     final response = await apiClient.dio.get("/users?page=1");
// //     final users = List<Map<String, dynamic>>.from(response.data['data']);
// //     final db = await DatabaseHelper.database;
// //     for (var u in users) {
// //       await db.insert("users", u,); }
// //     return users; }
// //   catch (_) {
// //     final db = await DBHelper.database;
// //     return await db.query("users"); } } }
//
// import 'package:sqflite/sqflite.dart';
// import '../../../core/db/db_helper.dart';
//
//
// class UserRepository {
//   final DatabaseHelper _dbHelper = DatabaseHelper();
//
//   Future<int> insertUser(Map<String, dynamic> user) async {
//     final db = await _dbHelper.database;
//     return await db.insert('users', user);
//   }
//
//   Future<List<Map<String, dynamic>>> getAllUsers() async {
//     final db = await _dbHelper.database;
//     return await db.query('users');
//   }
//
//   Future<Map<String, dynamic>?> getUserById(int id) async {
//     final db = await _dbHelper.database;
//     final result = await db.query(
//       'users',
//       where: 'id = ?',
//       whereArgs: [id],
//     );
//     return result.isNotEmpty ? result.first : null;
//   }
//
//   Future<int> updateUser(int id, Map<String, dynamic> user) async {
//     final db = await _dbHelper.database;
//     return await db.update(
//       'users',
//       user,
//       where: 'id = ?',
//       whereArgs: [id],
//     );
//   }
//
//   Future<int> deleteUser(int id) async {
//     final db = await _dbHelper.database;
//     return await db.delete(
//       'users',
//       where: 'id = ?',
//       whereArgs: [id],
//     );
//   }
//
//   Future<void> deleteAllUsers() async {
//     final db = await _dbHelper.database;
//     await db.delete('users');
//   }
// }


import 'package:dio/dio.dart';
import '../../../core/db/db_helper.dart';

class UserRepository {
  final Dio _dio = Dio();
  final dbHelper = DatabaseHelper();

  Future<List<Map<String, dynamic>>> fetchUsers() async {
    try {
      final response = await _dio.get('https://reqres.in/api/users?page=1');

      if (response.statusCode == 200) {
        final List users = response.data['data'];

        final db = await dbHelper.database;

        // Clear old data and insert new
        await db.delete('users');
        for (var user in users) {
          await db.insert('users', {
            'id': user['id'],
            'email': user['email'],
            'first_name': user['first_name'],
            'last_name': user['last_name'],
            'avatar': user['avatar'],
          });
        }

        return users.cast<Map<String, dynamic>>();
      } else {
        throw Exception('Failed to load users from API');
      }
    } catch (e) {
      // Offline fallback
      final db = await dbHelper.database;
      final cachedUsers = await db.query('users');
      return cachedUsers;
    }
  }
}
