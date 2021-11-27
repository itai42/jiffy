import 'dart:math';

import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/src/enums/startOfWeek.dart';
import 'package:jiffy/src/enums/units.dart';
import 'package:jiffy/src/locale/availableLocales.dart';
import 'package:jiffy/src/locale/locale.dart';
import 'package:jiffy/src/utils/exception.dart';
import 'package:jiffy/src/utils/normalize_units.dart';
import 'package:jiffy/src/utils/regex.dart';
import 'package:jiffy/src/utils/replace.dart';

mixin HasDateTimeRead{
  DateTime get dateTime;
}
mixin HasDateTimeWrite{
  set dateTime(DateTime val);
}
extension Jiffy on DateTime {

  static const daysInMonthArray = [
    0,
    31,
    28,
    31,
    30,
    31,
    30,
    31,
    31,
    30,
    31,
    30,
    31
  ];

  static bool isLeapYear(int year) =>
      (year % 4 == 0) && ((year % 100 != 0) || (year % 400 == 0));
  bool get leapYear => isLeapYear(year);

  static int getDaysInMonth(int year, int month) {
    var result = daysInMonthArray[month];
    if (month == 2 && isLeapYear(year)) result++;
    return result;
  }

  int monthsUntil(DateTime other){
    return (other.year - year) * 12 + (other.month-month);
  }
  DateTime get firstDayOfMonth {
    return isUtc ?
    DateTime.utc(
        year,
        month,
        1,
        hour,
        minute,
        second,
        millisecond,
        microsecond)
        : DateTime(
        year,
        month,
        1,
        hour,
        minute,
        second,
        millisecond,
        microsecond);
  }
  DateTime get lastDayOfMonth {
    return isUtc ?
    DateTime.utc(
        year,
        month,
        daysInMonth,
        hour,
        minute,
        second,
        millisecond,
        microsecond)
        : DateTime(
        year,
        month,
        daysInMonth,
        hour,
        minute,
        second,
        millisecond,
        microsecond);
  }

  static Locale? _internalDefaultLocale;
  static Locale get defaultLocale => _internalDefaultLocale ??= _initializeLocale();

  //DateTime get dateTime => this;

  static DateTime parseDateTime([var input, String? pattern]) {
    return _parse(input, pattern);
  }

  static DateTime dateFromUnixTimestamp(int timestamp) {
    var timestampLength = timestamp.toString().length;
    if (timestampLength != 10 && timestampLength != 13) {
      throw JiffyException(
              'The timestamp passed must be in seconds or milliseconds e.g. 1570963450 or 1570963450123')
          .cause;
    }
    if (timestampLength == 10) timestamp *= 1000;
    return DateTime.fromMillisecondsSinceEpoch(timestamp);
  }

  static DateTime _parse(var input, [String? pattern]) {
    var dateTime;
    if (input == null && pattern == null) {
      dateTime = DateTime.now();
    } else if (input is DateTime) {
      dateTime = input;
    } else if (input is HasDateTimeRead) {
      dateTime = input.dateTime;
    } else if (input is Map) {
      dateTime = _parseMap(input);
    } else if (input is List) {
      dateTime = _parseList(input);
    } else if (input is String) {
      dateTime = _parseString(input, pattern);
    } else {
      throw JiffyException(
              'Jiffy only accepts String, List, Map, DateTime or Jiffy itself as parameters')
          .cause;
    }
    return dateTime;
  }

  static DateTime _parseMap(Map input) {
    input.forEach((key, value) {
      validateUnits(key);
    });
    if (input.isEmpty) {
      return DateTime.now();
    } else {
      return DateTime(
          input['year'] ?? input['years'] ?? input['y'] ?? DateTime.now().year,
          input['month'] ??
              input['months'] ??
              input['M'] ??
              DateTime.now().month,
          input['day'] ?? input['days'] ?? input['d'] ?? DateTime.now().day,
          input['hour'] ?? input['hours'] ?? input['h'] ?? DateTime.now().hour,
          input['minute'] ??
              input['minutes'] ??
              input['m'] ??
              DateTime.now().minute,
          input['second'] ??
              input['seconds'] ??
              input['s'] ??
              DateTime.now().second,
          input['millisecond'] ??
              input['milliseconds'] ??
              input['ms'] ??
              DateTime.now().millisecond);
    }
  }

  static DateTime _parseList(List input) {
    if (input.isEmpty) {
      return DateTime.now();
    } else {
      return DateTime(
          input[0],
          input.length > 1 ? input[1] : 1,
          input.length > 2 ? input[2] : 1,
          input.length > 3 ? input[3] : 0,
          input.length > 4 ? input[4] : 0,
          input.length > 5 ? input[5] : 0,
          input.length > 6 ? input[6] : 0);
    }
  }

  static DateTime _parseString(String input, String? pattern) {
    if (pattern != null) {
      return DateFormat(replacePatternInput(pattern))
          .parse(replaceParseInput(input));
    } else if (matchHyphenStringDateTime(input)) {
      return DateFormat('yyyy-MM-dd').parse(input);
    } else if (matchDartStringDateTime(input) ||
        matchISOStringDateTime(input)) {
      return DateTime.parse(input).toLocal();
    } else if (matchSlashStringDateTime(input)) {
      return DateFormat('yyyy/MM/dd').parse(input);
    } else if (matchBasicStringDateTime().hasMatch(input)) {
      return DateFormat('yyyy/MM/dd')
          .parse(input.replaceAllMapped(matchBasicStringDateTime(), (match) {
        return '${match.group(1)}/${match.group(2)}/${match.group(3)}';
      }));
    } else {
      throw JiffyException(
              'Date time not recognized, a pattern must be passed, e.g. Jiffy("12, Oct", "dd, MMM")')
          .cause;
    }
  }

  static Locale _initializeLocale() {
    var currentLocale = Intl.getCurrentLocale();
    _internalDefaultLocale = getLocale(currentLocale);
    _internalDefaultLocale!.code = currentLocale.toLowerCase();
    return _internalDefaultLocale!;
  }

  static Future<Locale> locale([String? locale]) async {
    _initializeLocale();
    if (locale != null) {
      if (isLocalAvailable(locale)) {
        throw JiffyException(
                'The locale "$locale" does not exist in Jiffy, run Jiffy.getAllAvailableLocales() for more locales')
            .cause;
      }
      await initializeDateFormatting();
      Intl.defaultLocale = locale;
      _internalDefaultLocale = getLocale(locale);
      _internalDefaultLocale!.code = locale.toLowerCase();
    }
    return Future.value(_internalDefaultLocale!);
  }

  static List<String> getAllAvailableLocales() {
    return getAllLocales();
  }

  int get dayOfWeek {
    var weekDays = [1, 2, 3, 4, 5, 6, 7, 1, 2];
    var weekDayIndex = weekday - 1;

    switch (defaultLocale.startOfWeek()) {
      case StartOfWeek.MONDAY:
        weekDayIndex += 0;
        break;
      case StartOfWeek.SUNDAY:
        weekDayIndex += 1;
        break;
      case StartOfWeek.SATURDAY:
        weekDayIndex += 2;
        break;
    }
    return weekDays[weekDayIndex];
  }

  int get daysInMonth => getDaysInMonth(year, month);

  int get dayOfYear => int.parse(DateFormat('D').format(this)); //ToDo: make better?

  int get week => ((dayOfYear - dayOfWeek + 10) / 7).floor();

  int get quarter => int.parse(DateFormat('Q').format(this)); //ToDo: make better?

//  MANIPULATE
  DateTime jiffyAdd({
    Duration duration = Duration.zero,
    int years = 0,
    int months = 0,
    int weeks = 0,
    int days = 0,
    int hours = 0,
    int minutes = 0,
    int seconds = 0,
    int milliseconds = 0,
    int microseconds = 0,
  }) {
    var dayOfMonth = day;
    var monthStart = firstDayOfMonth;

    var utcDateTime = _addMonths(monthStart, months + years * 12);
    var ret = DateTime(
        utcDateTime.year,
        utcDateTime.month,

        min(dayOfMonth, getDaysInMonth(utcDateTime.year, utcDateTime.month)),
        utcDateTime.hour,
        utcDateTime.minute,
        utcDateTime.second,
        utcDateTime.millisecond,
        utcDateTime.microsecond);
    ret = ret.add(duration + Duration(
      days: days + (weeks * 7),
      hours: hours,
      minutes: minutes,
      seconds: seconds,
      milliseconds: milliseconds,
      microseconds: microseconds,
    ));
    return ret;
  }

  DateTime jiffySubtract({
    Duration duration = Duration.zero,
    int years = 0,
    int months = 0,
    int weeks = 0,
    int days = 0,
    int hours = 0,
    int minutes = 0,
    int seconds = 0,
    int milliseconds = 0,
    int microseconds = 0,
  }) {
    var totalMonths = months + years * 12;
    var ret = this;
    if (totalMonths < 0){
      ret = _addMonths(ret, -totalMonths);
    }
    ret = ret.subtract(duration);
    ret = ret.subtract(Duration(
      days: days + weeks * 7,
      hours: hours,
      minutes: minutes,
      seconds: seconds,
      milliseconds: milliseconds,
      microseconds: microseconds,
    ));
    if (totalMonths > 0){
      ret = _addMonths(ret, -totalMonths);
    }
    return ret;
  }

  DateTime startOf(Units units) {
    switch (units) {
      case Units.MILLISECOND:
        return DateTime(
            year,
            month,
            day,
            hour,
            minute,
            second,
            millisecond);
      case Units.SECOND:
        return DateTime(year, month, day,
            hour, minute, second);
      case Units.MINUTE:
        return DateTime(year, month, day,
            hour, minute);
      case Units.HOUR:
        return DateTime(
            year, month, day, hour);
      case Units.DAY:
        return DateTime(year, month, day);
      case Units.WEEK:
        var newDate = jiffySubtract(duration: Duration(days: dayOfWeek - 1));
        return DateTime(newDate.year, newDate.month, newDate.day);
      case Units.MONTH:
        return DateTime(year, month, 1);
      case Units.YEAR:
        return DateTime(year);
      default:
        return this;
    }
  }

  DateTime endOf(Units units) {
    switch (units) {
      case Units.MILLISECOND:
        return DateTime(
            year,
            month,
            day,
            hour,
            minute,
            second,
            millisecond);
      case Units.SECOND:
        return DateTime(year, month, day,
            hour, minute, second, 999);
      case Units.MINUTE:
        return DateTime(year, month, day,
            hour, minute, 59, 999);
      case Units.HOUR:
        return DateTime(year, month, day,
            hour, 59, 59, 999);
      case Units.DAY:
        return DateTime(
            year, month, day, 23, 59, 59, 999);
      case Units.WEEK:
        var newDate = jiffyAdd(duration: Duration(days: DateTime.daysPerWeek - dayOfWeek));
        return DateTime(newDate.year, newDate.month, newDate.day, 23, 59, 59, 999);
      case Units.MONTH:
        var ldom = daysInMonthArray[month];
        if (leapYear && month == 2) {
          ldom = 29;
        }
        return DateTime(year, month, ldom, 23, 59, 59, 999);
      case Units.YEAR:
        return DateTime(year, 12, 31, 23, 59, 59, 999);
    }
  }


  DateTime addMonths(int months) {
    final r = months % 12;
    final q = (months - r) ~/ 12;
    var newYear = year + q;
    var newMonth = month + r;
    if (newMonth > 12) {
      newYear++;
      newMonth -= 12;
    }
    final newDay = min(day, daysInMonth);
    if (isUtc) {
      return DateTime.utc(newYear, newMonth, newDay, hour, minute,
          second, millisecond, microsecond);
    } else {
      return DateTime(newYear, newMonth, newDay, hour, minute,
          second, millisecond, microsecond);
    }
  }
  static DateTime _addMonths(DateTime from, int months) {
    final r = months % 12;
    final q = (months - r) ~/ 12;
    var newYear = from.year + q;
    var newMonth = from.month + r;
    if (newMonth > 12) {
      newYear++;
      newMonth -= 12;
    }
    final newDay = min(from.day, getDaysInMonth(newYear, newMonth));
    if (from.isUtc) {
      return DateTime.utc(newYear, newMonth, newDay, from.hour, from.minute,
          from.second, from.millisecond, from.microsecond);
    } else {
      return DateTime(newYear, newMonth, newDay, from.hour, from.minute,
          from.second, from.millisecond, from.microsecond);
    }
  }

//  DISPLAY
  String format([String? pattern]) {
    if (pattern == null) return toIso8601String();
    var ordinal = defaultLocale.ordinal(day);
    var escaped = replaceEscapePattern(pattern);
    var newPattern = replaceOrdinalDatePattern(escaped, ordinal);
    return DateFormat(newPattern).format(this);
  }

  String get E => DateFormat.E().format(this);

  String get EEEE => DateFormat.EEEE().format(this);

  String get LLL => DateFormat.LLL().format(this);

  String get LLLL => DateFormat.LLLL().format(this);

  String get Md => DateFormat.Md().format(this);

  String get MEd => DateFormat.MEd().format(this);

  String get MMM => DateFormat.MMM().format(this);

  String get MMMd => DateFormat.MMMd().format(this);

  String get MMMEd => DateFormat.MMMEd().format(this);

  String get MMMM => DateFormat.MMMM().format(this);

  String get MMMMd => DateFormat.MMMMd().format(this);

  String get MMMMEEEEd => DateFormat.MMMMEEEEd().format(this);

  String get QQQ => DateFormat.QQQ().format(this);

  String get QQQQ => DateFormat.QQQQ().format(this);

  String get yM => DateFormat.yM().format(this);

  String get yMd => DateFormat.yMd().format(this);

  String get yMEd => DateFormat.yMEd().format(this);

  String get yMMM => DateFormat.yMMM().format(this);

  String get yMMMd => DateFormat.yMMMd().format(this);

  String get yMMMdjm => DateFormat.yMMMd().add_jm().format(this);

  String get yMMMEd => DateFormat.yMMMEd().format(this);

  String get yMMMEdjm => DateFormat.yMMMEd().add_jm().format(this);

  String get yMMMM => DateFormat.yMMMM().format(this);

  String get yMMMMd => DateFormat.yMMMMd().format(this);

  String get yMMMMdjm => DateFormat.yMMMMd().add_jm().format(this);

  String get yMMMMEEEEd => DateFormat.yMMMMEEEEd().format(this);

  String get yMMMMEEEEdjm => DateFormat.yMMMMEEEEd().add_jm().format(this);

  String get yQQQ => DateFormat.yQQQ().format(this);

  String get yQQQQ => DateFormat.yQQQQ().format(this);

  String get Hm => DateFormat.Hm().format(this);

  String get Hms => DateFormat.Hms().format(this);

  String get j => DateFormat.j().format(this);

  String get jm => DateFormat.jm().format(this);

  String get jms => DateFormat.jms().format(this);

  String fromNow() {
    return defaultLocale.getRelativeTime(this);
  }

  String from(var input) {
    var dateTime = _parse(input);
    return defaultLocale.getRelativeTime(this, dateTime);
  }

  num diff(var input, [Units units = Units.MILLISECOND, bool asFloat = false]) {
    var dateTime = _parse(input);
    num diff;

    var dt1 = millisecondsSinceEpoch;
    var dt2 = dateTime.millisecondsSinceEpoch;

    switch (units) {
      case Units.MILLISECOND:
        diff = dt1 - dt2;
        break;
      case Units.SECOND:
        diff = (dt1 - dt2) / Duration.millisecondsPerSecond;
        break;
      case Units.MINUTE:
        diff = (dt1 - dt2) / Duration.millisecondsPerMinute;
        break;
      case Units.HOUR:
        diff = (dt1 - dt2) / Duration.millisecondsPerHour;
        break;
      case Units.DAY:
        diff = (dt1 - dt2) / Duration.millisecondsPerDay;
        break;
      case Units.WEEK:
        diff = ((dt1 - dt2) / Duration.millisecondsPerDay) / 7;
        break;
      case Units.MONTH:
        diff = _monthDiff(this, dateTime);
        break;
      case Units.YEAR:
        diff = _monthDiff(this, dateTime) / 12;
        break;
    }
    if (!asFloat) return _absFloor(diff);
    return diff;
  }

  num _monthDiff(DateTime a, DateTime b) {
    var wholeMonthDiff = ((b.year - a.year) * 12) + (b.month - a.month);
    var anchor = _addMonths(a, wholeMonthDiff);
    var anchor2;
    var adjust;

    if (b.millisecondsSinceEpoch - anchor.millisecondsSinceEpoch < 0) {
      anchor2 = _addMonths(a, wholeMonthDiff - 1);
      adjust = (b.millisecondsSinceEpoch - anchor.millisecondsSinceEpoch) /
          (anchor.millisecondsSinceEpoch - anchor2.millisecondsSinceEpoch);
    } else {
      anchor2 = _addMonths(a, wholeMonthDiff + 1);
      adjust = (b.millisecondsSinceEpoch - anchor.millisecondsSinceEpoch) /
          (anchor2.millisecondsSinceEpoch - anchor.millisecondsSinceEpoch);
    }
    return -(wholeMonthDiff + adjust);
  }

  int _absFloor(num number) {
    if (number < 0) {
      return number.ceil();
    } else {
      return number.floor();
    }
  }

  int valueOf() {
    return millisecondsSinceEpoch;
  }

  int unix() {
    return (millisecondsSinceEpoch / 1000).round();
  }

//  QUERY
  bool jiffyIsBefore(var input, [Units units = Units.MILLISECOND]) {
    var dateTime = _parse(input);
    if (units == Units.MILLISECOND) {
      return valueOf() < dateTime.millisecondsSinceEpoch;
    }
    var endOfMs = (endOf(units)).valueOf();
    return endOfMs < dateTime.millisecondsSinceEpoch;
  }

  bool jiffyIsAfter(var input, [Units units = Units.MILLISECOND]) {
    var dateTime = _parse(input);
    if (units == Units.MILLISECOND) {
      return valueOf() > dateTime.millisecondsSinceEpoch;
    }
    var startOfMs = (startOf(units)).valueOf();
    return dateTime.millisecondsSinceEpoch < startOfMs;
  }

  bool isSame(var input, [Units units = Units.MILLISECOND]) {
    var dateTime = _parse(input);
    if (units == Units.MILLISECOND) {
      return valueOf() == dateTime.millisecondsSinceEpoch;
    }
    var startOfMs = (startOf(units)).valueOf();
    var endOfMs = (endOf(units)).valueOf();
    var dateTimeMs = dateTime.millisecondsSinceEpoch;
    return startOfMs <= dateTimeMs && dateTimeMs <= endOfMs;
  }

  bool isSameOrBefore(var input, [Units units = Units.MILLISECOND]) {
    var dateTime = _parse(input);
    return isSame(dateTime, units) || jiffyIsBefore(dateTime, units);
  }

  bool isSameOrAfter(var input, [Units units = Units.MILLISECOND]) {
    var dateTime = _parse(input);
    return isSame(dateTime, units) || jiffyIsAfter(dateTime, units);
  }

  bool isBetween(var inputFrom, var inputTo,
      [Units units = Units.MILLISECOND]) {
    var dateTimeFrom = _parse(inputFrom);
    var dateTimeTo = _parse(inputTo);
    return jiffyIsAfter(dateTimeFrom, units) && jiffyIsBefore(dateTimeTo, units);
  }

  bool isInRange(var inputFromIclusive, var inputToExclusive,
      [Units units = Units.MILLISECOND]) {
    var dateTimeFrom = _parse(inputFromIclusive);
    var dateTimeTo = _parse(inputToExclusive);
    return isSameOrAfter(dateTimeFrom, units) && jiffyIsBefore(dateTimeTo, units);
  }

  static bool? isDateTime(dynamic input) => (input == null)?null:(input is DateTime);
}
