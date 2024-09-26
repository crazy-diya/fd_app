part of 'dashboard_cubit.dart';

@immutable
abstract class DashboardState {}

class DashboardInitial extends DashboardState {}

class ApiLoadingState extends DashboardState {}

class ApiFailureState extends DashboardState {}

class DioExceptionFailureState extends DashboardState {}

class ServerFailureState extends DashboardState {}

class ConnectionFailureState extends DashboardState {}

class DashboardSuccessState extends DashboardState {
  final List<MarketNewsResponseModel>? marketNewsList;

  DashboardSuccessState({required this.marketNewsList});
}
