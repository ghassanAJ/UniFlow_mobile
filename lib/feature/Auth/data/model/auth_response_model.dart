import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uniflow/feature/Auth/data/model/user_model.dart';

part 'auth_response_model.freezed.dart';
part 'auth_response_model.g.dart';

@freezed
abstract class AuthResponseModel with _$AuthResponseModel {
  const factory AuthResponseModel({
    required String token,
    @JsonKey(name: 'token_type') required String tokenType,
    required UserDataModel user,
  }) = _AuthResponseModel;

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseModelFromJson(json);

  // factory AuthResponseModel.toJson(AuthResponseModel model)=>_$AuthResponseModelToJson(model);
}
