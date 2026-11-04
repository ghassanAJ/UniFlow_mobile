import 'package:dartz/dartz.dart';
import 'package:uniflow/core/error/failure.dart';
import 'package:uniflow/core/network/api_response.dart';

abstract class AuthRemoteDataSource {
  Future<Either<Failure, ApiResponse>> login();
}
