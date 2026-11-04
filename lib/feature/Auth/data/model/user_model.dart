import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
abstract class UserDataModel with _$UserDataModel {
  const factory UserDataModel({
    required int id,
    required String name,
    @JsonKey(name: 'university_id') required String universityId,
    required String email,
    required String role,
  }) = _UserDataModel;

  factory UserDataModel.fromJson(Map<String, dynamic> json) =>
      _$UserDataModelFromJson(json);
}
