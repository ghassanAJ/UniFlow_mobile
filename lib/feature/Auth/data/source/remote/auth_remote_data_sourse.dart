import 'package:dartz/dartz.dart';
import 'package:uniflow/core/error/failure.dart';
// import 'package:uniflow/core/model/response_model/auth_response_model.dart';
import 'package:uniflow/core/network/api_general.dart';
import 'package:uniflow/core/network/api_request.dart';
import 'package:uniflow/core/network/api_response.dart';
import 'package:uniflow/core/network/base_url.dart';
import 'package:uniflow/feature/Auth/data/source/remote/auth_remote_data_source_impl.dart';

import '../../model/auth_response_model.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final API api;

  AuthRemoteDataSourceImpl({required this.api});

  Future<Either<Failure, ApiResponse>> login() async {
    try {
      var response = await api.post(
        ApiRequest(
          url: BaseUrl.login,
          body: {"university_id": "2022105", "password": "@ghassan123"},
        ),
      );
      if (response.statusCode == 200 && response.body != null) {
        var dataUser = AuthResponseModel.fromJson(response.body);
        print(dataUser.toString());
        return right(ApiResponse(statusCode: 200, body: dataUser));
      } else {
        print('Failed to loginFailed to login');
        return left(Failure(message: "Failed to login"));
      }
    } catch (e) {
      print(e.toString());
      return Left(Failure.handleError(e));
    }
  }
}
