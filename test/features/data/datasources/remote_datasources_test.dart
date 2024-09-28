import 'package:fd_app/core/services/dependency_injection.dart';
import 'package:fd_app/features/data/datasources/remote_datasource.dart';
import 'package:fd_app/features/data/model/market_news_response_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockRemoteDatasource extends Mock implements RemoteDatasource {}

void main() async {
  RemoteDatasource? remoteDatasource;
  late List<MarketNewsResponseModel> newsList;

  setUpAll(() async {
    await init();
    await dotenv.load(fileName: ".env");
    remoteDatasource = injection.call<RemoteDatasource>();
  });

  setUp(() async {
    newsList = await remoteDatasource!.dashboardRequest({"category": "general"});
  });

  group(
    "Test Dashboard request - ",
    () {
      test(
        "given class when dashboardRequest function called is called and status code is 200, then MarketNews Model should be return",
        () async {
          expect(newsList, isA<List<MarketNewsResponseModel>>());
        },
      );

      // test(
      //   "given class when dashboardRequest function is called and status code is not 200, then exception should be thrown",
      //   () {
      //     when(
      //       () async {},
      //     ).thenAnswer(
      //       (invocation) async {
      //         throw Exception("");
      //       },
      //     );
      //     expect(newsList, throwsException);
      //   },
      // );

      // test(
      //   "given class when dashboardRequest function is called and status code is not 200, then exception should be thrown",
      //   () {
      //     when(
      //       () async {
      //         return await remoteDatasource!.dashboardRequest({"category": "general"});
      //       },
      //     ).thenThrow(throwsException);
      //     // expect(newsList, throwsException);
      //   },
      // );
    },
  );
}
