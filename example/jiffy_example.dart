import 'package:jiffy/jiffy.dart';
import 'package:jiffy/src/enums/units.dart';

Future<int> main() async {
//  DISPLAY
  Jiffy.parseDateTime([2021, 1, 19])
      .format('MMM do yyyy, h:mm:ss a'); // January 1st 2021, 12:00:00 AM
  DateTime.now().format('EEEE'); // Tuesday
  DateTime.now().format('MMM do yy'); // Mar 2nd 21
  DateTime.now().format('yyyy [escaped] yyyy'); // 2021 escaped 2021
  DateTime.now().format(); // 2021-03-02T15:18:29.922343

// Not passing a string pattern for format method will return an ISO Date format
  DateTime.now().format(); // 2021-03-02T15:18:29.922343

// Using lists
  Jiffy.parseDateTime([2019, 10, 19]).yMMMMd; // January 19, 2021

// Using maps
  Jiffy.parseDateTime({'year': 2019, 'month': 10, 'day': 19, 'hour': 19})
      .yMMMMEEEEdjm; // Monday, October 19, 2020 7:14 PM

  // 'From Now' implementation
  Jiffy.parseDateTime('2007-1-29').fromNow(); // 14 years ago
  Jiffy.parseDateTime([2022, 10, 29]).fromNow(); // in a year
  Jiffy.parseDateTime(DateTime(2050, 10, 29)).fromNow(); // in 30 years

  DateTime.now().startOf(Units.HOUR).fromNow(); // 9 minutes ago

//  'From X' implementation
  var jiffy2 = Jiffy.parseDateTime('2007-1-28');
  var jiffy3 = Jiffy.parseDateTime('2017-1-29', 'yyyy-MM-dd');

  jiffy2.from(jiffy3); // a day ago

  jiffy2.from([2017, 1, 30]); // 2 days ago

//  Displaying the 'Difference' between two date times
//  By default, 'diff' method, get the difference in milliseconds
  var jiffy4 = Jiffy.parseDateTime('2007-1-28', 'yyyy-MM-dd');
  var jiffy5 = Jiffy.parseDateTime('2017-1-29', 'yyyy-MM-dd');
  jiffy4.diff(jiffy5); // 86400000

  // You can also get 'diff' in different units of time
  Jiffy.parseDateTime([2007, 1, 28]).diff([2017, 1, 29], Units.DAY); // -3654

//  RELATIVE TIME
  Jiffy.parseDateTime('2011-10-31').fromNow(); // 8 years ago
  Jiffy.parseDateTime(DateTime(2012, 6, 20)).fromNow(); // 7 years ago

  DateTime.now().startOf(Units.DAY).fromNow(); // 19 hours ago

  DateTime.now().endOf(Units.DAY).fromNow(); // in 5 hours

  DateTime.now().startOf(Units.HOUR).fromNow(); // 9 minutes ago

//  MANIPULATING DATES
  DateTime.now().jiffyAdd(duration: Duration(days: 1)).yMMMMd; // October 20, 2019

  DateTime.now().jiffySubtract(days: 1).yMMMMd; // October 18, 2019

// LOCALES
// The locale method always return a future
// To get locale (The default locale is English)
  await Jiffy.locale(); // en
//  To set locale
  await Jiffy.locale('fr');
  DateTime.now().yMMMMEEEEdjm; // samedi 19 octobre 2019 19:25
  await Jiffy.locale('ar');
  DateTime.now().yMMMMEEEEdjm; // السبت، ١٩ أكتوبر ٢٠١٩ ٧:٢٧ م
  await Jiffy.locale('zh_cn');
  DateTime.now().yMMMMEEEEdjm; // 2019年10月19日星期六 下午7:28

  return 0;
}
