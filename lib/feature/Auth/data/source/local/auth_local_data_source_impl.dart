import 'dart:convert';
import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:uniflow/constant/cache_key.dart';
import 'package:uniflow/core/services/storage/secure_storage/secure_storage_service.dart';
import 'package:uniflow/core/services/token/token_service.dart';
import 'package:uniflow/feature/Auth/data/model/user_model.dart';
import 'package:uniflow/feature/Auth/data/source/local/auth_local_data_source.dart';

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final FlutterSecureStorage secureStorage;

  AuthLocalDataSourceImpl({required this.secureStorage});
  @override
  Future<void> cacheDataUser(String token) async {
    try {
      await secureStorage.delete(key: CacheKeys.tokenKey);
      await secureStorage.write(key: CacheKeys.tokenKey, value: token);
    } catch (e) {
      log('Error saving token: $e');
    }
  }

  @override
  Future<String?> getDataUser() async {
    try {
      var token = await secureStorage.read(key: CacheKeys.tokenKey);
      return token;
    } catch (e) {
      log('Error reading token: $e');
      return null;
    }
  }

    @override
  Future<void> saveUserInCach(UserDataModel user) async {
    try {
      final userJson = jsonEncode(user.toJson());

      //  jsonEncode({
      //   "access": user.access,
      //   "refresh": user.refresh,
      //   "role": user.role,
      // });
      await secureStorage.write(key: CacheKeys.userKey, value: userJson);
    } catch (e) {
      log("Error saving user data: $e");
    }
  }
  
  //* getUserInCach
  @override
  Future<UserDataModel?> getUserInCach() async {
    try {
      final userJson = await secureStorage.read(key: CacheKeys.userKey);
      if (userJson != null) {
        final userData = jsonDecode(userJson) as Map<String, dynamic>;
        return UserDataModel.fromJson(userData);
      }
      return null;
    } catch (e) {
      log("Error getting user data: $e");
      return null;
    }
  }
}
