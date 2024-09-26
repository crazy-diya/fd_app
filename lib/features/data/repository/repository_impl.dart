import 'package:dartz/dartz.dart';
import 'package:fd_app/core/network/network_info.dart';
import 'package:fd_app/error/failures.dart';
import 'package:fd_app/features/data/datasources/remote_datasource.dart';
import 'package:fd_app/features/domain/entities/error_response_entity.dart';
import 'package:fd_app/features/domain/repository/repository.dart';

import '../../../error/exception.dart';
import '../model/market_news_response_model.dart';

class RepositoryImpl extends Repository {
  final RemoteDatasource remoteDatasource;
  final NetworkInfo networkInfo;

  RepositoryImpl({required this.remoteDatasource, required this.networkInfo});

  @override
  Future<Either<Failure, List<MarketNewsResponseModel>>> dashboard(Map<String, dynamic> data) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDatasource.dashboardRequest(data);
        return Right(response);
      } on DioExceptionError catch (e) {
        return Left(DioExceptionFailure(e.errorResponse!));
      } on Exception catch (e) {
        return Left(
          ServerFailure(
            errorResponse: ErrorResponseEntity(
              responseCode: "",
              responseError: e.toString(),
            ),
          ),
        );
      }
    } else {
      return Left(ConnectionFailure());
    }
  }
}
