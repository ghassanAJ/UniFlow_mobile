// import "dart:developer";
// import "dart:convert";
// import "package:flutter_secure_storage/flutter_secure_storage.dart";
// import "package:e_learning/core/constant/cache_keys.dart";
// import "package:e_learning/core/model/response_model/auth_response_model.dart";
// import "package:e_learning/core/services/storage/secure_storage/secure_storage_service.dart";
// import "package:uniflow/core/model/response_model/auth_response_model.dart";
// import "package:uniflow/core/services/storage/secure_storage/secure_storage_service.dart";

// class SecureStorageServiceImpl implements SecureStorageService {
//   final FlutterSecureStorage storage;

//   SecureStorageServiceImpl({required this.storage});

//   //? -------------------------------------------------------------------

//   //?---- Token ----------------

//   //* save Token In Cach
//   @override
//   Future<void> saveTokenInCach(String token) async {
//     try {
//       await storage.delete(key: CacheKeys.tokenKey);
//       await storage.write(key: CacheKeys.tokenKey, value: token);
//     } catch (e) {
//       log('Error saving token: $e');
//     }
//   }

//   //* get Token InCach
//   @override
//   Future<String?> getTokenInCach() async {
//     try {
//       return await storage.read(key: CacheKeys.tokenKey);
//     } catch (e) {
//       log('Error getting token: $e');
//       return null;
//     }
//   }

//   //* delete Token InCach
//   @override
//   Future<void> deleteTokenInCach() async {
//     try {
//       await storage.delete(key: CacheKeys.tokenKey);
//     } catch (e) {
//       log('Error deleting token: $e');
//     }
//   }

//   //?---- Refresh Token ----------------
//   //* saveRefreshTokenInCach
//   @override
//   Future<void> saveRefreshTokenInCach(String refreshToken) async {
//     try {
//       await storage.delete(key: CacheKeys.refreshTokenKey);
//       await storage.write(key: CacheKeys.refreshTokenKey, value: refreshToken);
//     } catch (e) {
//       log('Error saving refresh token: $e');
//     }
//   }

//   //* getRefreshTokenInCach
//   @override
//   Future<String?> getRefreshTokenInCach() async {
//     try {
//       return await storage.read(key: CacheKeys.refreshTokenKey);
//     } catch (e) {
//       log('Error getting refresh token: $e');
//       return null;
//     }
//   }

//   //?---- Token Expiry ----------------

//   //* saveTokenExpiryInCach
//   @override
//   Future<void> saveTokenExpiryInCach(DateTime expiry) async {
//     try {
//       await storage.delete(key: CacheKeys.tokenExpiryKey);
//       await storage.write(
//         key: CacheKeys.tokenExpiryKey,
//         value: expiry.millisecondsSinceEpoch.toString(),
//       );
//     } catch (e) {
//       log('Error saving token expiry: $e');
//     }
//   }

//   //* getTokenExpiryInCach
//   @override
//   Future<DateTime?> getTokenExpiryInCach() async {
//     try {
//       final expiryString = await storage.read(key: CacheKeys.tokenExpiryKey);
//       if (expiryString != null) {
//         return DateTime.fromMillisecondsSinceEpoch(int.parse(expiryString));
//       }
//       return null;
//     } catch (e) {
//       log('Error getting token expiry: $e');
//       return null;
//     }
//   }

//   //?---- Remove All ----------------

//   //* removeAllInCach
//   @override
//   Future<void> removeAllInCach() async {
//     try {
//       await storage.deleteAll();
//     } catch (e) {
//       log("Error clearing all storage: $e");
//     }
//   }

//   //?---- User Data ----------------
  
//   //* saveUserInCach
//   @override
//   Future<void> saveUserInCach(AuthResponseModel user) async {
//     try {
//       final userJson = jsonEncode({
//         "access": user.access,
//         "refresh": user.refresh,
//         "role": user.role,
//       });
//       await storage.write(key: CacheKeys.userKey, value: userJson);
//     } catch (e) {
//       log("Error saving user data: $e");
//     }
//   }
  
//   //* getUserInCach
//   @override
//   Future<AuthResponseModel?> getUserInCach() async {
//     try {
//       final userJson = await storage.read(key: CacheKeys.userKey);
//       if (userJson != null) {
//         final userData = jsonDecode(userJson) as Map<String, dynamic>;
//         return AuthResponseModel(
//           access: userData["access"] as String,
//           refresh: userData["refresh"] as String,
//           role: userData["role"] as String,
//         );
//       }
//       return null;
//     } catch (e) {
//       log("Error getting user data: $e");
//       return null;
//     }
//   }

//   //? -------------------------------------------------------------------
// }
