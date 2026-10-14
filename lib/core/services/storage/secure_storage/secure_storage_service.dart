import "package:e_learning/core/model/response_model/auth_response_model.dart";

abstract class SecureStorageService {
  //? ----------------------- Token -----------------------------------------

  //* saveTokenInCach
  Future<void> saveTokenInCach(String token);

  //* getTokenInCach
  Future<String?> getTokenInCach();

  //* deleteTokenInCach
  Future<void> deleteTokenInCach();

  //? ------------------- Refresh Token -------------------------------------

  //* saveRefreshTokenInCach
  Future<void> saveRefreshTokenInCach(String refreshToken);

  //* getRefreshTokenInCach
  Future<String?> getRefreshTokenInCach();

  //? ------------------- Token Expiry --------------------------------------

  //* saveTokenExpiryInCach
  Future<void> saveTokenExpiryInCach(DateTime expiry);

  //* getTokenExpiryInCach
  Future<DateTime?> getTokenExpiryInCach();

  //? ------------------- User Data -----------------------------------------
  
  //* saveUserInCach
  Future<void> saveUserInCach(AuthResponseModel user);
  
  //* getUserInCach
  Future<AuthResponseModel?> getUserInCach();
  
  //? ------------------- Remove All ----------------------------------------

  //* removeAllInCach
  Future<void> removeAllInCach();
  //?---------------------------------
}
