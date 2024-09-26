import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../error/failures.dart';
import '../../data/model/market_news_response_model.dart';
import '../../domain/usecases/dashboard_usecase.dart';

part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  final Dashboard dashboard;

  DashboardCubit({required this.dashboard}) : super(DashboardInitial());

  Future<dynamic> getDashBoardData() async {
    emit(ApiLoadingState());

    final result = await dashboard({"category": "general"});

    emit(
      result.fold(
        (l) {
          if (l is DioExceptionFailure) {
            return DioExceptionFailureState();
          } else if (l is ServerFailure) {
            return ServerFailureState();
          } else if (l is ConnectionFailure) {
            return ConnectionFailureState();
          } else {
            return ApiFailureState();
          }
        },
        (r) {
          return DashboardSuccessState(marketNewsList: r);
        },
      ),
    );
  }
}
