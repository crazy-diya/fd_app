import 'dart:convert';

import 'package:fd_app/core/network/api_helper.dart';
import 'package:fd_app/features/data/model/market_news_response_model.dart';

abstract class RemoteDatasource {
  Future<List<MarketNewsResponseModel>> dashboardRequest(Map<String, dynamic> data);
}

class RemoteDatasourceImpl extends RemoteDatasource {
  final APIHelper apiHelper;

  RemoteDatasourceImpl({required this.apiHelper});

  @override
  Future<List<MarketNewsResponseModel>> dashboardRequest(Map<String, dynamic> data) async {
    try {
      var response = await apiHelper.get(data);
      return marketNewsResponseModelFromJson(
        jsonEncode(response.data),
      );
    } on Exception {
      rethrow;
    }
  }
}
