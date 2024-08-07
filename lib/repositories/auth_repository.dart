import 'package:dio/dio.dart';
import 'package:solulab5/models/api_response.dart';
import 'package:solulab5/models/user.dart';

class AuthRepository {
  final Dio _dio = Dio();
  final String _baseUrl = 'https://api.storerestapi.com/auth';

  Future<ApiResponse> signIn(String email, String password) async {
    try {
      final response = await _dio.post(
        '$_baseUrl/login',
        data: {'email': email, 'password': password},
        options: Options(headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        }),
      );

      if (response.statusCode == 200) {
        return ApiResponse.fromJson(response.data);
      } else {
        throw Exception('Failed to sign in.');
      }
    } catch (e) {
      throw Exception('Failed to sign in: $e');
    }
  }

  Future<ApiResponse> signUp(User user) async {
    try {
      final response = await _dio.post(
        '$_baseUrl/register',
        data: user.toJson(),
        options: Options(headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        }),
      );

      if (response.statusCode == 201) {
        return ApiResponse.fromJson(response.data);
      } else {
        throw Exception('Failed to sign up.');
      }
    } catch (e) {
      throw Exception('Failed to sign up: $e');
    }
  }
}