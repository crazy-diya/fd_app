import 'package:fd_app/counter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late Counter counter;

  setUp(
    () {
      counter = Counter();
    },
  );
  setUpAll(() {});

  group(
    'Counter Class Testing - ',
    () {
      test(
        "Test 1 - given counter class when initiate it need to counter value is 0",
        () {
          expect(counter.count, 0);
        },
      );

      test(
        "Test 2 - given counter class when increment value by 1 answer is need to be 1",
        () {
          counter.incrementCount();
          expect(counter.count, 1);
        },
      );

      test(
        "Test 3 - given counter class when decrement value by 1 answer is need to be 0",
        () {
          counter.decrementCount();
          expect(counter.count, -1);
        },
      );

      test("Test 4 - given counter class when reset answer is need to be 0", () {
        counter.reset();
        expect(counter.count, 0);
      },);
    },
  );

  tearDown(() {});
  tearDownAll(() {});
}
