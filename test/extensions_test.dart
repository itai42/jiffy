import 'package:jiffy/jiffy.dart';
import 'package:test/test.dart';

void main() {
  group('Test Date Extensions', () {
    test('Test months span', () {
      expect(
          (DateTime(2020, 3, 20)
                  .monthsUntil(Jiffy(DateTime(2020, 3, 20)).addMonths(20)))
              .toString(),
          '20');
      expect(
          (DateTime(2020, 3, 20).monthsUntil(DateTime(2020, 7, 20))).toString(),
          '4');
      expect(
          (DateTime(2023, 1, 29).monthsUntil(DateTime(2024, 2, 29))).toString(),
          '13');
    });
  });
}
