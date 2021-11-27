import 'package:jiffy/jiffy.dart';
import 'package:jiffy/src/enums/units.dart';
import 'package:test/test.dart';

void main() {
  group('Test Jiffy().add() method adding datetime', () {

    test(
        'test Jiffy().add() method with parsing date time should add and return correct date time in milliseconds',
        () {
      expect(
          (Jiffy.parseDateTime('2019-10-13 12:00:00', 'yyyy-MM-dd hh:mm:ss')
                ..jiffyAdd(duration: Duration(milliseconds: 1)))
              .toString(),
          '2019-10-13 00:00:00.001');
    });
    test(
        'test Jiffy().add() with leap-year boundary addition should add and return correct date time',
            () {
          expect(
              (Jiffy.parseDateTime('2020-1-28 12:00:00', 'yyyy-MM-dd hh:mm:ss')
                ..jiffyAdd(years: 4, months: 1, days: 1))
                  .toString(),
              '2024-02-29 00:00:00.000');
        });
    test(
        'test Jiffy().add() with leap-year boundary addition should add and return correct date time',
            () {
          expect(
              (Jiffy.parseDateTime('2021-1-28 12:00:00', 'yyyy-MM-dd hh:mm:ss')
                ..jiffyAdd(years: 3, months: 1, days: 2))
                  .toString(),
              '2024-03-01 00:00:00.000');
        });
    test(
        'test Jiffy().add() with leap-year boundary addition should add and return correct date time',
            () {
          expect(
              (Jiffy.parseDateTime('2024-02-01 12:00:00', 'yyyy-MM-dd hh:mm:ss')
                ..jiffyAdd(years: -4, months: 1, days: -1))
                  .toString(),
              '2020-02-29 00:00:00.000');
        });
    test(
        'test Jiffy().add() with leap-year boundary addition should add and return correct date time',
            () {
          expect(
              (Jiffy.parseDateTime('2023-1-28 12:00:00', 'yyyy-MM-dd hh:mm:ss')
                ..jiffyAdd(years: 1, months: 1, days: 1))
                  .toString(),
              '2024-02-29 00:00:00.000');
        });
    test(
        'test Jiffy().add() with leap-year boundry subtraction should subtract and return correct date time',
            () {
          expect(
              (Jiffy.parseDateTime('2025-3-1 12:00:00', 'yyyy-MM-dd hh:mm:ss')
                ..jiffyAdd(years: -1, months: 0, days: -1))
                  .toString(),
              '2024-02-29 00:00:00.000');
        });
    test(
        'test Jiffy().add() with leap-year boundary addition should add and return correct date time',
            () {
          expect(
              (Jiffy.parseDateTime('2024-2-29 12:00:00', 'yyyy-MM-dd hh:mm:ss')
                ..jiffyAdd(years: 1, months: 1, days: 1))
                  .toString(),
              '2025-03-30 00:00:00.000');
        });
    test(
        'test Jiffy().add() method with parsing date time should add and return correct date time in seconds',
        () {
      expect((Jiffy.parseDateTime()..jiffyAdd(duration: Duration(seconds: 1))).second,
          DateTime.now().add(Duration(seconds: 1)).second);
      expect(
          (Jiffy.parseDateTime('2019-10-13 12:00:00', 'yyyy-MM-dd hh:mm:ss')
                ..jiffyAdd(duration: Duration(seconds: 1)))
              .toString(),
          '2019-10-13 00:00:01.000');
    });
    test(
        'test Jiffy().add() method with parsing date time should add and return correct date time in minutes',
        () {
      expect((Jiffy.parseDateTime()..jiffyAdd(duration: Duration(minutes: 1))).minute,
          DateTime.now().add(Duration(minutes: 1)).minute);
      expect(
          (Jiffy.parseDateTime('2019-10-13 12:00:00', 'yyyy-MM-dd hh:mm:ss')
                ..jiffyAdd(duration: Duration(minutes: 1)))
              .toString(),
          '2019-10-13 00:01:00.000');
    });
    test(
        'test Jiffy().add() method with parsing date time should add and return correct date time in hours',
        () {
      expect((Jiffy.parseDateTime()..jiffyAdd(duration: Duration(hours: 1))).hour,
          DateTime.now().add(Duration(hours: 1)).hour);
      expect(
          (Jiffy.parseDateTime('2019-10-13 12:00:00', 'yyyy-MM-dd hh:mm:ss')
                ..jiffyAdd(duration: Duration(hours: 1)))
              .toString(),
          '2019-10-13 01:00:00.000');
    });
    test(
        'test Jiffy().add() method with parsing date time should add and return correct date time in days',
        () {
      expect((Jiffy.parseDateTime()..jiffyAdd(duration: Duration(days: 1))).day,
          DateTime.now().add(Duration(days: 1)).day);
      expect(
          (Jiffy.parseDateTime('2019-10-13 12:00:00', 'yyyy-MM-dd hh:mm:ss')
                ..jiffyAdd(duration: Duration(days: 1)))
              .toString(),
          '2019-10-14 00:00:00.000');
    });
    test(
        'test Jiffy().add() method with parsing date time should add and return correct date time in weeks',
        () {
      expect((Jiffy.parseDateTime()..jiffyAdd(weeks: 1)).day,
          DateTime.now().add(Duration(days: 1 * 7)).day);
      expect(
          (Jiffy.parseDateTime('2019-10-13 12:00:00', 'yyyy-MM-dd hh:mm:ss')..jiffyAdd(weeks: 1))
              .toString(),
          '2019-10-20 00:00:00.000');
    });
    test(
        'test Jiffy().add() method with parsing date time should add and return correct date time in months',
        () {
      expect(
          (Jiffy.parseDateTime('2019-10-13 12:00:00', 'yyyy-MM-dd hh:mm:ss')..jiffyAdd(months: 1))
              .toString(),
          '2019-11-13 00:00:00.000');
    });
    test(
        'test Jiffy().add() method with parsing date time should add and return correct date time in years',
        () {
      expect(
          (Jiffy.parseDateTime('2019-10-13 12:00:00', 'yyyy-MM-dd hh:mm:ss')..jiffyAdd(years: 1))
              .toString(),
          '2020-10-13 00:00:00.000');
    });
  });

  group('Test Jiffy subtracting datetime', () {
    test(
        'test Jiffy().subtract() method with parsing date time should subtract and return correct date time in milliseconds',
        () {
      expect(
          (Jiffy.parseDateTime('2019-10-13 23:00:00')
                ..jiffySubtract(duration: Duration(milliseconds: 1)))
              .toString(),
          '2019-10-13 22:59:59.999');
    });
    test(
        'test Jiffy().subtract() with leap-year boundary subtraction should subtract and return correct date time',
            () {
          expect(
              (Jiffy.parseDateTime('2025-3-30 12:00:00', 'yyyy-MM-dd hh:mm:ss')
                ..jiffySubtract(years: 1, months: 1, days: 1))
                  .toString(),
              '2024-02-29 00:00:00.000');
        });
    test(
        'test Jiffy().subtract() with leap-year starting year addition should add and return correct date time',
            () {
          expect(
              (Jiffy.parseDateTime('2020-1-29 12:00:00', 'yyyy-MM-dd hh:mm:ss')
                ..jiffySubtract(years: -4, months: -1, days: -1))
                  .toString(),
              '2024-03-01 00:00:00.000');
        });
    test(
        'test Jiffy().add() with leap-year boundary addition should add and return correct date time',
            () {
          expect(
              (Jiffy.parseDateTime('2023-1-28 12:00:00', 'yyyy-MM-dd hh:mm:ss')
                ..jiffySubtract(years: -1, months: -1, days: -1))
                  .toString(),
              '2024-02-29 00:00:00.000');
        });
    test(
        'test Jiffy().subtract() method with parsing date time should subtract and return correct date time in seconds',
        () {
      expect((Jiffy.parseDateTime()..jiffySubtract(duration: Duration(seconds: 1))).second,
          DateTime.now().subtract(Duration(seconds: 1)).second);
      expect(
          (Jiffy.parseDateTime('2019-10-13 12:00:01', 'yyyy-MM-dd hh:mm:ss')
                ..jiffySubtract(duration: Duration(seconds: 1)))
              .toString(),
          '2019-10-13 00:00:00.000');
    });
    test(
        'test Jiffy().subtract() method with parsing date time should subtract and return correct date time in minutes',
        () {
      expect((Jiffy.parseDateTime()..jiffySubtract(duration: Duration(minutes: 1))).minute,
          DateTime.now().subtract(Duration(minutes: 1)).minute);
      expect(
          (Jiffy.parseDateTime('2019-10-13 12:01:00', 'yyyy-MM-dd hh:mm:ss')
                ..jiffySubtract(duration: Duration(minutes: 1)))
              .toString(),
          '2019-10-13 00:00:00.000');
    });
    test(
        'test Jiffy().subtract() method with parsing date time should subtract and return correct date time in hours',
        () {
      expect((Jiffy.parseDateTime()..jiffySubtract(duration: Duration(hours: 1))).hour,
          DateTime.now().subtract(Duration(hours: 1)).hour);
      expect(
          (Jiffy.parseDateTime('2019-10-13 13:00:00', 'yyyy-MM-dd hh:mm:ss')
                ..jiffySubtract(duration: Duration(hours: 1)))
              .toString(),
          '2019-10-13 12:00:00.000');
    });
    test(
        'test Jiffy().subtract() method with parsing date time should subtract and return correct date time in day',
        () {
      expect((Jiffy.parseDateTime()..jiffySubtract(duration: Duration(days: 1))).day,
          DateTime.now().subtract(Duration(days: 1)).day);
      expect(
          (Jiffy.parseDateTime('2019-10-14 12:00:00', 'yyyy-MM-dd hh:mm:ss')
                ..jiffySubtract(duration: Duration(days: 1)))
              .toString(),
          '2019-10-13 00:00:00.000');
    });
    test(
        'test Jiffy().subtract() method with parsing date time should subtract and return correct date time in weeks',
        () {
      expect((Jiffy.parseDateTime()..jiffySubtract(weeks: 1)).day,
          DateTime.now().subtract(Duration(days: 1 * 7)).day);
      expect(
          (Jiffy.parseDateTime('2019-10-13 12:00:00', 'yyyy-MM-dd hh:mm:ss')
                ..jiffySubtract(weeks: 1))
              .toString(),
          '2019-10-06 00:00:00.000');
    });
    test(
        'test Jiffy().subtract() method with parsing date time should subtract and return correct date time in months',
        () {
      expect(
          (Jiffy.parseDateTime('2019-11-13 12:00:00', 'yyyy-MM-dd hh:mm:ss')
                ..jiffySubtract(months: 1))
              .toString(),
          '2019-10-13 00:00:00.000');
    });
    test(
        'test Jiffy().subtract() method with parsing date time should subtract and return correct date time in years',
        () {
      expect(
          (Jiffy.parseDateTime('2020-10-13 12:00:00', 'yyyy-MM-dd hh:mm:ss')
                ..jiffySubtract(years: 1))
              .toString(),
          '2019-10-13 00:00:00.000');
    });
  });

  group('Test Jiffy().startOf() datetime', () {
    test(
        'test Jiffy().startOf() method with parsing date time should add and return correct start of date time in seconds',
        () {
      expect(
          (Jiffy.parseDateTime('2019-10-13 13:12:12', 'yyyy-MM-dd hh:mm:ss')
                ..startOf(Units.SECOND))
              .toString(),
          '2019-10-13 13:12:12.000');
    });
    test(
        'test Jiffy().startOf() method with parsing date time should add and return correct start of date time in minutes',
        () {
      expect(
          (Jiffy.parseDateTime('2019-10-13 13:12:12', 'yyyy-MM-dd hh:mm:ss')
                ..startOf(Units.MINUTE))
              .toString(),
          '2019-10-13 13:12:00.000');
    });
    test(
        'test Jiffy().startOf() method with parsing date time should add and return correct start of date time in hours',
        () {
      expect(
          (Jiffy.parseDateTime('2019-10-13 13:12:12', 'yyyy-MM-dd hh:mm:ss')
                ..startOf(Units.HOUR))
              .toString(),
          '2019-10-13 13:00:00.000');
    });
    test(
        'test Jiffy().startOf() method with parsing date time should add and return correct start of date time in days',
        () {
      expect(
          (Jiffy.parseDateTime('2019-10-13 13:12:12', 'yyyy-MM-dd hh:mm:ss')
                ..startOf(Units.DAY))
              .toString(),
          '2019-10-13 00:00:00.000');
    });
    test(
        'test Jiffy().startOf() method with parsing date time should add and return correct start of date time in weeks',
        () {
      expect(
          (Jiffy.parseDateTime('2019-10-13 13:12:12', 'yyyy-MM-dd hh:mm:ss')
                ..startOf(Units.WEEK))
              .toString(),
          '2019-10-13 00:00:00.000');
      expect(
          (Jiffy.parseDateTime('2019-10-10 13:12:12', 'yyyy-MM-dd hh:mm:ss')
                ..startOf(Units.WEEK))
              .toString(),
          '2019-10-06 00:00:00.000');
    });
    test(
        'test Jiffy().startOf() method with parsing date time should add and return correct start of date time in months',
        () {
      expect(
          (Jiffy.parseDateTime('2019-10-13 13:12:12', 'yyyy-MM-dd hh:mm:ss')
                ..startOf(Units.MONTH))
              .toString(),
          '2019-10-01 00:00:00.000');
    });
    test(
        'test Jiffy().startOf() method with parsing date time should add and return correct start of date time in years',
        () {
      expect(
          (Jiffy.parseDateTime('2019-10-13 13:12:12', 'yyyy-MM-dd hh:mm:ss')
                ..startOf(Units.YEAR))
              .toString(),
          '2019-01-01 00:00:00.000');
    });

  });

  group('Test Jiffy().endOf() datetime', () {
    test(
        'test Jiffy().endOf() method with parsing date time should add and return correct end of date time in seconds',
        () {
      expect(
          (Jiffy.parseDateTime('2019-10-13 13:12:12', 'yyyy-MM-dd hh:mm:ss')
                ..endOf(Units.SECOND))
              .toString(),
          '2019-10-13 13:12:12.999');
    });
    test(
        'test Jiffy().endOf() method with parsing date time should add and return correct end of date time in mintes',
        () {
      expect(
          (Jiffy.parseDateTime('2019-10-13 13:12:12', 'yyyy-MM-dd hh:mm:ss')
                ..endOf(Units.MINUTE))
              .toString(),
          '2019-10-13 13:12:59.999');
    });
    test(
        'test Jiffy().endOf() method with parsing date time should add and return correct end of date time in hours',
        () {
      expect(
          (Jiffy.parseDateTime('2019-10-13 13:12:12', 'yyyy-MM-dd hh:mm:ss')
                ..endOf(Units.HOUR))
              .toString(),
          '2019-10-13 13:59:59.999');
    });
    test(
        'test Jiffy().endOf() method with parsing date time should add and return correct end of date time in days',
        () {
      expect(
          (Jiffy.parseDateTime('2019-10-13 13:12:12', 'yyyy-MM-dd hh:mm:ss')
                ..endOf(Units.DAY))
              .toString(),
          '2019-10-13 23:59:59.999');
    });
    test(
        'test Jiffy().endOf() method with parsing date time should add and return correct end of date time in weeks',
        () {
      expect(
          (Jiffy.parseDateTime('2019-10-13 13:12:12', 'yyyy-MM-dd hh:mm:ss')
                ..endOf(Units.WEEK))
              .toString(),
          '2019-10-19 23:59:59.999');
      expect(
          (Jiffy.parseDateTime('2019-10-10 13:12:12', 'yyyy-MM-dd hh:mm:ss')
                ..endOf(Units.WEEK))
              .toString(),
          '2019-10-12 23:59:59.999');
    });
    test(
        'test Jiffy().endOf() method with parsing date time should add and return correct end of date time in months',
        () {
      expect(
          (Jiffy.parseDateTime('2019-10-13 13:12:12', 'yyyy-MM-dd hh:mm:ss')
                ..endOf(Units.MONTH))
              .toString(),
          '2019-10-31 23:59:59.999');
      expect(
          (Jiffy.parseDateTime('2019-02-13 13:12:12', 'yyyy-MM-dd hh:mm:ss')
                ..endOf(Units.MONTH))
              .toString(),
          '2019-02-28 23:59:59.999');
      expect(
          (Jiffy.parseDateTime('2016-02-13 13:12:12', 'yyyy-MM-dd hh:mm:ss')
                ..endOf(Units.MONTH))
              .toString(),
          '2016-02-29 23:59:59.999');
    });
    test(
        'test Jiffy().endOf() method with parsing date time should add and return correct end of date time in years',
        () {
      expect(
          (Jiffy.parseDateTime('2019-10-13 13:12:12', 'yyyy-MM-dd hh:mm:ss')
                ..endOf(Units.YEAR))
              .toString(),
          '2019-12-31 23:59:59.999');
    });

  });
}
