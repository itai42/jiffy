import 'package:jiffy/jiffy.dart';
import 'package:test/test.dart';

void main() {
  group('Test Jiffy get datetime methods', () {
    test(
        'test Jiffy().day get method with parsing date time should return correct date time day in French locale time',
        () async {
      await Jiffy.locale('fr');
      expect(Jiffy.parseDateTime([2019, 11, 24]).dayOfWeek, 7);
    });
    test(
        'test Jiffy().day get method with parsing date time should return correct date time day in English locale time',
        () async {
      await Jiffy.locale('en');
      expect(Jiffy.parseDateTime([2019, 11, 24]).dayOfWeek, 1);
    });
    test(
        'test Jiffy().daysInMonth get method with parsing date time should return correct date time day of month',
        () {
      expect(Jiffy.parseDateTime([2016, 1]).daysInMonth, 31);
      expect(Jiffy.parseDateTime([2016, 2]).daysInMonth, 29);
      expect(Jiffy.parseDateTime([2017, 2]).daysInMonth, 28);
    });
    test(
        'test Jiffy().dayOfYear get method with parsing date time should return correct date time day of year',
        () {
      expect(
          Jiffy.parseDateTime('2019, 10, 16', 'yyyy, MM, dd').dayOfYear, 289);
    });
    test(
        'test Jiffy().week get method with parsing date time should return correct date time week',
        () {
      expect(Jiffy.parseDateTime('2019, 10, 16', 'yyyy, MM, dd').week, 42);
    });
    test(
        'test Jiffy().quarter get method with parsing date time should return correct date time quarter',
        () {
      expect(Jiffy.parseDateTime('2019, 10, 16', 'yyyy, MM, dd').quarter, 4);
    });
    test(
        'test Jiffy().month get method with parsing date time should return correct date time month',
        () {
      expect(Jiffy.parseDateTime().month, DateTime.now().month);
    });
    test(
        'test Jiffy().year get method with parsing date time should return correct date time year',
        () {
      expect(Jiffy.parseDateTime().year, DateTime.now().year);
    });
  });
}
