import 'package:jiffy/jiffy.dart';
import 'package:test/test.dart';

void main() {
  group('Test Jiffy cloning', () {
    test('Test assignment constancy (not really necessary but there used to be a clone() function to test so I left this here). function no manipulation should be equal', () {
      var jiffy1 = Jiffy.parseDateTime([2021]);
      var jiffy2 = jiffy1;
      expect(jiffy1.year, jiffy2.year);
    });
    test(
        'Test with constancy (not really necessary but there used to be a clone() function to test so I left this here) function manipulation by adding 10 years should not be equal',
        () {
      var jiffy1 = Jiffy.parseDateTime([2021]);
      var jiffy2 = jiffy1;
      jiffy1.jiffyAdd(years: 10);
      expect(jiffy1.year, isNot(jiffy2.year));
    });
    test('Test clone from instance no manipulation should be equal', () {
      var jiffy1 = Jiffy.parseDateTime([2021]);
      var jiffy2 = Jiffy.parseDateTime(jiffy1);
      expect(jiffy1.year, jiffy2.year);
    });
    test(
        'Test clone from instance manipulation by adding 10 years should not be equal',
        () {
      var jiffy1 = Jiffy.parseDateTime([2021]);
      var jiffy2 = Jiffy.parseDateTime(jiffy1);
      jiffy1.jiffyAdd(years: 10);
      expect(jiffy1.year, isNot(jiffy2.year));
    });
  });

  group('Test Jiffy datetime instance', () {
    test(
        'test Jiffy() instance without parsing time and pattern should set correct datetime',
        () {
      expect(Jiffy.parseDateTime().year, DateTime.now().year);
      expect(Jiffy.parseDateTime().month, DateTime.now().month);
    });
    test(
        'test Jiffy() instance with parsing time and pattern should set correct date time',
        () {
      expect(Jiffy.parseDateTime('2009', 'yyyy').year, 2009);
      expect(Jiffy.parseDateTime('Oct, 2009', 'MMM, yyyy').year, 2009);
    });
    test(
        'test Jiffy() instance with parsing ordinal pattern should return correct ordinal date',
        () {
      expect(
          Jiffy.parseDateTime('Oct 1st 19', 'MMM do yy').format('MMM do yy'), 'Oct 1st 19');
      expect(
          Jiffy.parseDateTime('Oct 2st 19', 'MMM do yy').format('MMM do yy'), 'Oct 2nd 19');
      expect(
          Jiffy.parseDateTime('Oct 3st 19', 'MMM do yy').format('MMM do yy'), 'Oct 3rd 19');
      expect(
          Jiffy.parseDateTime('Oct 10st 19', 'MMM do yy').format('MMM do yy'), 'Oct 10th 19');
      expect(
          Jiffy.parseDateTime('Oct 21st 19', 'MMM do yy').format('MMM do yy'), 'Oct 21st 19');
    });
    test(
        'test Jiffy() instance with parsing empty string pattern should set correct date time',
        () {
      expect(Jiffy.parseDateTime('2009', '').year, 1970);
    });
    test(
        'test Jiffy() instance with parsing empty string time and pattern should set correct date time',
        () {
      expect(Jiffy.parseDateTime('', '').year, 1970);
    });
    test(
        'test Jiffy() instance with parsing Datetime object should set correct date time',
        () {
      expect(Jiffy.parseDateTime(DateTime(2019)).year, 2019);
    });
    test(
        'test Jiffy() instance with parsing Jiffy object should set correct date time',
        () {
      expect(Jiffy.parseDateTime(Jiffy.parseDateTime('2009', 'yyyy')).year, 2009);
    });
    test(
        'test Jiffy() instance with parsing Map object should set correct date time',
        () {
      expect(Jiffy.parseDateTime({'y': 2009}).year, 2009);
      expect(Jiffy.parseDateTime({'M': 2}).year, DateTime.now().year);
    });
    test(
        'test Jiffy() instance with parsing empty Map object should set correct date time',
        () {
      expect(Jiffy.parseDateTime({}).year, DateTime.now().year);
    });
    test(
        'test Jiffy() instance with parsing Array object should set correct date time',
        () {
      expect(Jiffy.parseDateTime([2009, 1]).year, 2009);
    });
    test(
        'test Jiffy() instance with parsing empty Array should set correct date time',
        () {
      expect(Jiffy.parseDateTime([]).year, DateTime.now().year);
    });
    test(
        'test Jiffy().dateTime get method with parsing time and pattern should return date time string',
        () {
      expect(Jiffy.parseDateTime('Oct, 2009', 'MMM, yyyy').toString(),
          '2009-10-01 00:00:00.000');
    });
    test(
        'test Jiffy() instance with parsing pattern and empty time should return exception',
        () {
      try {
        Jiffy.parseDateTime('', 'yyyy');
      } catch (e) {
        expect(e.toString(),
            'FormatException: Trying to read yyyy from  at position 0');
      }
    });
    test(
        'test Jiffy() instance with parsing wrong time and pattern should return exception',
        () {
      try {
        Jiffy.parseDateTime('Oct', 'yyyy');
      } catch (e) {
        expect(e.toString(),
            'FormatException: Trying to read yyyy from Oct at position 0');
      }
    });
    test(
        'test Jiffy() instance with parsing time and without pattern should return exception',
        () {
      try {
        Jiffy.parseDateTime('');
      } catch (e) {
        expect(e.toString(),
            'JiffyException: Date time not recognized, a pattern must be passed, e.g. Jiffy("12, Oct", "dd, MMM")');
      }
    });
    test(
        'test Jiffy() instance with parsing other than String, List, Map, DateTime or Jiffy itself',
        () {
      try {
        Jiffy.parseDateTime(2);
      } catch (e) {
        expect(e.toString(),
            'JiffyException: Jiffy only accepts String, List, Map, DateTime or Jiffy itself as parameters');
      }
    });
  });

  group('Test Jiffy.unix datetime instance', () {
    test(
        'test Jiffy.unix() instance with parsing timestamp in seconds should set date time',
        () {
      expect(Jiffy.dateFromUnixTimestamp(1570963450).year,
          DateTime.fromMillisecondsSinceEpoch(1570963450000).year);
      expect(Jiffy.dateFromUnixTimestamp(1570963450).month,
          DateTime.fromMillisecondsSinceEpoch(1570963450000).month);
    });
    test(
        'test Jiffy.unix() instance with parsing timestamp in milliseconds should set date time',
        () {
      expect(Jiffy.dateFromUnixTimestamp(1570963450000).year,
          DateTime.fromMillisecondsSinceEpoch(1570963450000).year);
      expect(Jiffy.dateFromUnixTimestamp(1570963450000).month,
          DateTime.fromMillisecondsSinceEpoch(1570963450000).month);
    });
    test(
        'test Jiffy.unix() instance with parsing timestamp not in seconds or milliseconds should return exception',
        () {
      try {
        Jiffy.dateFromUnixTimestamp(157096345);
      } catch (e) {
        expect(e.toString(),
            'JiffyException: The timestamp passed must be in seconds or milliseconds e.g. 1570963450 or 1570963450123');
      }
    });
  });
}
