import 'package:uniflow/feature/Auth/data/model/user_model.dart';

abstract class AuthLocalDataSource {
  Future<void> cacheDataUser(String token);
  Future<String?> getDataUser();
  Future<void> saveUserInCach(UserDataModel user);
  Future<UserDataModel?> getUserInCach();
}
