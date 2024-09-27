import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:fd_app/error/exception.dart';
import 'package:fd_app/features/domain/entities/error_response_entity.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'network_config.dart';

class APIHelper {
  late Dio dio;

  APIHelper({required this.dio}) {
    _initAPIClient();
  }

  void _initAPIClient() {
    final logInterceptor = LogInterceptor(
      requestBody: false,
      responseBody: false,
      error: false,
      requestHeader: false,
      responseHeader: false,
    );

    BaseOptions options = BaseOptions(
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
      baseUrl: NetworkConfig.getNetworkConfig(),
      contentType: 'application/json',
      headers: {"X-Finnhub-Token": dotenv.env['API_KEY']},
    );

    dio
      ..options = options
      ..interceptors.add(logInterceptor);

    dio.httpClientAdapter = IOHttpClientAdapter(
      createHttpClient: () {
        final HttpClient dioClient = HttpClient(
          context: SecurityContext(
            withTrustedRoots: false,
          ),
        );
        dioClient.badCertificateCallback = (cert, host, port) => true;
        return dioClient;
      },
      validateCertificate: (cert, host, port) {
        return true;
      },
    );
  }

  Future<dynamic> post(T) async {}

  Future<dynamic> get(Map<String, dynamic> param) async {
    try {
      final response = await dio.get(
        NetworkConfig.getNetworkConfig(),
        queryParameters: param,
      );
      if (response.statusCode == 200) {
        return response;
      } else if (response.statusCode == 400) {
        throw APIFailException(
          errorResponseModel: ErrorResponseEntity(
            responseCode: response.statusCode.toString(),
            responseError: response.statusMessage!,
          ),
        );
      } else if (response.statusCode == 500) {
        throw ServerException(
          errorResponse: ErrorResponseEntity(
            responseCode: response.statusCode.toString(),
            responseError: response.statusMessage!,
          ),
        );
      }
    } on DioException catch (error) {
      throw DioExceptionError(
        errorResponse: ErrorResponseEntity(
          responseCode: error.response!.statusCode.toString(),
          responseError: error.message!,
        ),
      );
    } on Exception {
      throw ServerException();
    }
  }
}
