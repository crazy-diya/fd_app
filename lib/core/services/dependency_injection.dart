import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:fd_app/core/services/secure_storage.dart';
import 'package:fd_app/features/presentation/bloc/dashboard_cubit.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:fd_app/core/network/api_helper.dart';
import 'package:fd_app/core/network/network_info.dart';
import 'package:fd_app/features/data/datasources/remote_datasource.dart';
import 'package:fd_app/features/data/repository/repository_impl.dart';
import 'package:fd_app/features/domain/repository/repository.dart';
import 'package:fd_app/features/domain/usecases/dashboard_usecase.dart';

final injection = GetIt.instance;

Future<dynamic> init() async {
  const flutterSecureStorage = FlutterSecureStorage();
  final secureStorage = SecureStorage(flutterSecureStorage);

  injection.registerSingleton(Dio());
  injection.registerLazySingleton<APIHelper>(() => APIHelper(dio: injection()));
  injection.registerLazySingleton(() => Connectivity());
  injection.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(connectivity: injection()));
  injection.registerLazySingleton(() => flutterSecureStorage);
  injection.registerLazySingleton(() => secureStorage);



  //RemoteDataSource
  injection.registerLazySingleton<RemoteDatasource>(() => RemoteDatasourceImpl(apiHelper: injection()));

  //Repository
  injection
      .registerLazySingleton<Repository>(() => RepositoryImpl(remoteDatasource: injection(), networkInfo: injection()));

  //UseCase
  injection.registerLazySingleton(() => Dashboard(repository: injection()));

  //Bloc
  injection.registerFactory(() => DashboardCubit(dashboard: injection()));
}
