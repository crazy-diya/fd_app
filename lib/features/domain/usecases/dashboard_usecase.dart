import 'package:dartz/dartz.dart';
import 'package:fd_app/error/failures.dart';
import 'package:fd_app/features/domain/repository/repository.dart';
import 'package:fd_app/features/domain/usecases/usecase.dart';

import '../../data/model/market_news_response_model.dart';

class Dashboard extends UseCase<List<MarketNewsResponseModel>, Map<String, dynamic>> {
  final Repository repository;

  Dashboard({required this.repository});

  @override
  Future<Either<Failure, List<MarketNewsResponseModel>>> call(Map<String, dynamic> params) async {
    return await repository.dashboard(params);
  }
}
