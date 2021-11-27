import 'package:jiffy/jiffy.dart';
import 'package:jiffy/src/enums/units.dart';
import 'package:test/test.dart';

void main() {
  group('Test Jiffy query date time', () {
    test(
        'test Jiffy().isBefore() method with parsing date time should return true or false if date time is before',
        () {
      var jiffy1 = Jiffy.parseDateTime('2010-10-20', 'yyyy-MM-dd');
      var jiffy2 = Jiffy.parseDateTime('2010-12-31', 'yyyy-MM-dd');
      var jiffy3 = Jiffy.parseDateTime('2011-01-01', 'yyyy-MM-dd');
      expect(jiffy1.jiffyIsBefore(Jiffy.parseDateTime('2010-10-21', 'yyyy-MM-dd')), true);
      expect(jiffy1.jiffyIsBefore(jiffy2, Units.YEAR), false);
      expect(jiffy1.jiffyIsBefore(jiffy3, Units.YEAR), true);
    });
    test(
        'test Jiffy().isAfter() method with parsing date time should return true or false if date time is after',
        () {
      var jiffy1 = Jiffy.parseDateTime('2010-10-20', 'yyyy-MM-dd');
      var jiffy2 = Jiffy.parseDateTime('2010-01-01', 'yyyy-MM-dd');
      expect(jiffy1.jiffyIsAfter(Jiffy.parseDateTime('2010-10-19', 'yyyy-MM-dd')), true);
      expect(jiffy1.jiffyIsAfter(jiffy2, Units.YEAR), false);
      expect(jiffy1.jiffyIsAfter([2009, 12, 31], Units.YEAR), true);
    });
    test(
        'test Jiffy().isSame() method with parsing date time should return true or false if date time is same',
        () {
      var jiffy1 = Jiffy.parseDateTime('2010-10-20', 'yyyy-MM-dd');
      var jiffy2 = Jiffy.parseDateTime('2009-12-31', 'yyyy-MM-dd');
      var jiffy3 = Jiffy.parseDateTime('2010-01-01', 'yyyy-MM-dd');
      expect(jiffy1.isSame(Jiffy.parseDateTime('2010-10-20', 'yyyy-MM-dd')), true);
      expect(jiffy1.isSame(jiffy2, Units.YEAR), false);
      expect(jiffy1.isSame(jiffy3, Units.YEAR), true);
    });
    test(
        'test Jiffy().isSameOrBefore() method with parsing date time should return true or false if date time is same or before',
        () {
      var jiffy1 = Jiffy.parseDateTime('2010-10-20', 'yyyy-MM-dd');
      var jiffy2 = Jiffy.parseDateTime('2009-12-31', 'yyyy-MM-dd');
      var jiffy3 = Jiffy.parseDateTime('2010-12-31', 'yyyy-MM-dd');
      expect(jiffy1.isSameOrBefore(Jiffy.parseDateTime('2010-10-21', 'yyyy-MM-dd')), true);
      expect(jiffy1.isSameOrBefore(Jiffy.parseDateTime('2010-10-19', 'yyyy-MM-dd')), false);
      expect(jiffy1.isSameOrBefore(jiffy2, Units.YEAR), false);
      expect(jiffy1.isSameOrBefore(jiffy3, Units.YEAR), true);
    });
    test(
        'test Jiffy().isSameOrAfter() method with parsing date time should return true or false if date time is same or after',
        () {
      var jiffy1 = Jiffy.parseDateTime('2010-10-20', 'yyyy-MM-dd');
      var jiffy2 = Jiffy.parseDateTime('2011-12-31', 'yyyy-MM-dd');
      var jiffy3 = Jiffy.parseDateTime('2010-01-01', 'yyyy-MM-dd');
      expect(jiffy1.isSameOrAfter(Jiffy.parseDateTime('2010-10-19', 'yyyy-MM-dd')), true);
      expect(jiffy1.isSameOrAfter(Jiffy.parseDateTime('2010-10-21', 'yyyy-MM-dd')), false);
      expect(jiffy1.isSameOrAfter(jiffy2, Units.YEAR), false);
      expect(jiffy1.isSameOrAfter(jiffy3, Units.YEAR), true);
    });
    test(
        'test Jiffy().isBetween() method with parsing date time should return true or false if date time is between two date times',
        () {
      var jiffy1 = Jiffy.parseDateTime('2010-10-20');
      var jiffy2 = Jiffy.parseDateTime('2010-10-19');
      expect(jiffy1.isBetween(jiffy2, DateTime(2010, 10, 25)), true);
      expect(jiffy1.isBetween([2010, 1, 1], '2012-01-01', Units.YEAR), false);
    });
    test(
        'test Jiffy().isLeapYear() method with parsing date time should return true or false if date time is leap year',
        () {
      expect(Jiffy.parseDateTime('2010', 'yyyy').leapYear, false);
      expect(Jiffy.parseDateTime('2016', 'yyyy').leapYear, true);
    });
  });
}
