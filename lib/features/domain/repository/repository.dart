import 'package:dartz/dartz.dart';

import '../../../error/failures.dart';
import '../../data/model/market_news_response_model.dart';

abstract class Repository{
  Future<Either<Failure,List<MarketNewsResponseModel>>> dashboard(Map<String, dynamic> data);
}