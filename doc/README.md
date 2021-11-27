# Jiffy as a DateTime extension

[![.github/workflows/release.yml](https://github.com/itai42/jiffyDateExtension/actions/workflows/release.yml/badge.svg)](https://github.com/itai42/jiffyDateExtension/actions/workflows/release.yml)
[![codecov](https://codecov.io/gh/itai42/jiffyDateExtension/branch/master/graph/badge.svg?token=Z2EGVUGWTE)](https://codecov.io/gh/itai42/jiffyDateExtension)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Platform](https://img.shields.io/badge/platform-flutter%7Cdart%7Cweb%7Candroid%7Cwindows%7Cnull%20safety%7C-Green)](https://github.com/itai42/jiffyDateExtension)


jiffyDateExtension is a Flutter (Windows desktop Android, IOS and Web) date time extension package inspired [jiffy](https://github.com/jama5262/jiffy) which was in turn inspired by [momentjs](https://momentjs.com/) for parsing, manipulating, querying and formatting dates

# Table of content
- [Parsing](#parsing)
    - [Now](#now)
    - [String](#string)
    - [String Formating](#string-formatting)
    - [Maps](#maps)
    - [Unix Timestamp](#unix-timestamp)
    - [List](#list)
    - [UTC](#utc)
- [Get](#get)
    - [Days in Month](#days-in-month)
    - [Day of Week](#day-of-week)
    - [Day of Year](#day-of-year)
    - [Week of Year](#week-of-year)
    - [Quarter](#quarter)
- [Manipulation](#manipulation)
    - [Add](#add)
    - [Subtract](#subtract)
    - [Start of Time](#start-of-time)
    - [End of Time](#end-of-time)
    - [Local](#local)
    - [UTC](#utc)
- [Display](#display)
    - [Format](#format)
    - [Time from Now](#time-from-now)
    - [Time from X](#time-from-x)
    - [Difference](#difference)
    - [Unix Timestamp (Milliseconds)](#unix-timestamp-milliseconds)
    - [Unix Timestamp (Seconds)](#unix-timestamp-seconds)
- [Query](#query)
    - [Is Before](#is-before)
    - [Is Same](#is-same)
    - [Is After](#is-after)
    - [Is Same or Before](#is-same-or-before)
    - [Is Same or After](#is-same-or-after)
    - [Is Between](#is-between)
    - [Leap Year](#leapyear)
- [Locale Support](#locale-support)

# Parsing
### Now
To get the date now, just call `Jiffy.parseDateTime()` without passing any parameters. This will return a Jiffy instance. See below
```dart
Jiffy.parseDateTime(); // Returns a dart DateTime.now()
Jiffy.parseDateTime().format(); // Return a ISO 8601 date time format
```

### String
Creating a Jiffy from a string. See below
```dart
Jiffy.parseDateTime("2021-5-25"); // A calendar date part
Jiffy.parseDateTime("2021/5/25"); // A calendar date part separated by slash "/"
Jiffy.parseDateTime("2021525"); // Basic (short) full date
Jiffy.parseDateTime("2021-5-25 12:00:00.000"); // An hour, minute, second, and millisecond time part
Jiffy.parseDateTime("2021-5-25T12:00:00.000"); // ISO dart format
Jiffy.parseDateTime("2021-5-25T12:00:00.000Z"); // ISO dart format (UTC)
```

### String Formatting
To get a Jiffy date from a string, pass the string and its pattern to Jiffy as is parameters. See below
```dart
Jiffy.parseDateTime("2021-5-25", "yyyy-MM-dd");
Jiffy.parseDateTime("25-5-2021", "dd-MM-yyyy");
Jiffy.parseDateTime("5-2021", "MM-yyyy");
```
You can also parse ordinal date formats. The date pattern for the ordinal date is `do`

```dart
Jiffy.parseDateTime("Jan 19th", "MMM do");
Jiffy.parseDateTime("19th January 2021", "do MMMM yyyy");
```

**_Note: Jiffy runs on top of the [Intl DateFormat](https://pub.dev/documentation/intl/latest/intl/DateFormat-class.html) package, so you can find all the date time patterns used by Jiffy [here](https://pub.dev/documentation/intl/latest/intl/DateFormat-class.html)_**

This is also same for Jiffy default formats. See below
```dart
DateTime.now().MMMEd; // Tue, May 25
Jiffy.parseDateTime("2021-5-25", "yyyy-MM-dd").yMMMMd; // May 25, 2021
```

### Maps
You can also create a Jiffy from a Map, Supported key pairs are,
 
`[ year, month, day, hour, minute, second and millisecond ]`. See below
```dart
Jiffy({
  "hour": 19,
  "minutes": 20
});

Jiffy({
  "year": 2019,
  "month": 10,
  "day": 19,
  "hour": 19
});
```

### Unix Timestamp
Jiffy can also parse timestamp milliseconds and seconds. Just call `Jiffy.unix()` which return a dart Datetime. See below
```dart
// Parsing a timestamp in milliseconds
Jiffy.unix(1318781876406);

// Parsing a timestamp in seconds
Jiffy.unix(1318781876).format(); // 2011-10-16T19:17:56.000
```

**_Note: `Jiffy.unix()` returns a timestamp base on local time. You can also get it in UTC which returns a UTC in dart Datetime. See below_**
```dart
Jiffy.unix(1318781876406).utc();
```

### Jiffy Cloning
Jiffy date time can be created from another Jiffy instance, a way of cloning.
```dart
var jiffy1 = Jiffy.parseDateTime([2021]);
var jiffy2 = Jiffy(jiffy1);
jiffy1.add(years: 10);
jiffy1.year; // 2031
jiffy2.year; // 2021
```

Or you can use the clone method itself
```dart
var jiffy1 = Jiffy.parseDateTime([2021]);
var jiffy2 = jiffy1.clone();
jiffy1.add(years: 10);
jiffy1.year; // 2031
jiffy2.year; // 2021
```

### DateTime
Jiffy date time can be created from a dart DateTime instance. See below
```dart
var dateTime = DateTime.now();
Jiffy.parseDateTime(dateTime);

Jiffy(DateTime(2021, 5, 25)).yMMMM; // May 2021
```

### List
You can also create Jiffy from a List. But they should mirror the following order

`[ year, month, day, hour, minute, second, millisecond ]`
```dart
Jiffy.parseDateTime([2021]); // January 1st 2021
Jiffy.parseDateTime([2021, 10]); // October 1st 2021
Jiffy.parseDateTime([2021, 10, 19]); // October 19th 2021
```

### UTC
Get date time in UTC. See below
```dart
// In local time
DateTime.now().format(); // 2021-03-02T14:35:24.363919

// Change to UTC
var jiffy = (DateTime.now()..utc());
jiffy.format(); // 2021-03-02T11:35:24.363919
```

# Get
### Days in month
Get days in a month (Returns from 28 - 31)
```dart
DateTime.now().daysInMonth;
```
### Day of week
Get day of week (Returns from 1 - 7 that is [Sunday - Saturday] depending on locale start of week)
```dart
DateTime.now().dayOfWeek;
```
### Day of year
Get day o year (Returns from 1 - 366)
```dart
DateTime.now().dayOfYear;
```
### Week of year
Get week of year
```dart
DateTime.now().week;
```
### Quarter
Get quarter (Returns from 1 - 4)
```dart
DateTime.now().quarter;
```

# Manipulation

### Add
This adds time to Jiffy by the following units `years, months, weeks, days, hours, minutes, seconds and milliseconds, microseconds and duration`. See below
```dart
DateTime.now().jiffyAdd(years: 1);
DateTime.now().jiffyAdd(days: 3);
DateTime.now().jiffyAdd(months: 3, duration: Duration(days: 3));
DateTime.now().jiffyAdd(years: 1, weeks: 3, duration: Duration(days: 3));
```
Below are the params that can be used

`[ years, months, weeks, days, hours, minutes, seconds, milliseconds, microseconds, duration ]`

```dart
var jiffy = DateTime.now()
    .jiffyStartOf(Units.DAY)
    .jiffyAdd(days: 7, months: 1)
    .jiffySubtract(years: 1);
jiffy.yMMMdjm; // Apr 8, 2020 9:00 PM
```

**_Note: Months and year are added in respect to how many days there are in a months and if a year is a leap year. See below_**

```dart
Jiffy.parseDateTime("2021-1-31", "yyyy-MM-dd").yMMMd; // Jan 31, 2021
Jiffy.parseDateTime("2021-1-31", "yyyy-MM-dd").add(months: 1).yMMMd; // Feb 28, 2021
```
### Subtract
This subtracts time from Jiffy by the following units `years, months, weeks, days, hours, minutes, seconds and milliseconds`. See below
```dart
DateTime.now().jiffySubtract(years: 1);
DateTime.now().jiffySubtract(days: 3);
```
### Start of Time
This set the Jiffy date time to a specific unit in time in terms of years, months, weeks, days, hours, minutes, seconds and milliseconds. See below

The units that are available are,

`[ Units.MILLISECOND, Units.SECOND, Units.MINUTE, Units.HOUR, Units.DAY, Units.WEEK, Units.MONTH, Units.YEAR ]`

```dart
DateTime.now().startOf(Units.YEAR);    // Set to January 1st, 12:00 am this year
DateTime.now().startOf(Units.MONTH);   // Set to the first of this month, 12:00 am
DateTime.now().startOf(Units.WEEK);    // Set to the first day of this week, 12:00 am
DateTime.now().startOf(Units.DAY);     // Set to 12:00 am today
DateTime.now().startOf(Units.HOUR);    // Set to now, but with 0 mins, 0 secs, and 0 ms
DateTime.now().startOf(Units.MINUTE);  // Set to now, but with 0 seconds and 0 milliseconds
DateTime.now().startOf(Units.SECONDS);  // Set to now, but with 0 milliseconds;
```

```dart
var jiffy = DateTime.now()
    .startOf(Units.DAY)
    .jiffyAdd(days: 1);
    .format("MMMM do yyyy, h:mm:ss a"); // March 3rd 2021, 12:00:00 AM
```

### End of Time
This set the Jiffy date time to a specific unit in time in terms of years, months, weeks, days, hours, minutes, seconds and milliseconds. See below

```dart
DateTime.now().endOf(Units.YEAR);    // Set to December 31st, 23:59:59:999 this year
DateTime.now().endOf(Units.MONTH);   // Set to the end of this month, 23:59:59:999
DateTime.now().endOf(Units.WEEK);    // Set to the end day of this week, 23:59:59:999
DateTime.now().endOf(Units.DAY);     // Set to 23:59:59:999 today
```
### Local
Sets Jiffy to local time. See below
```dart
var jiffy = DateTime.now().utc(); // Time in utc
jiffy = jiffy.local(); // Set to local
```
### UTC
Sets Jiffy to UTC time. See below
```dart
var jiffy = DateTime.now(); // Time in local
jiffy = jiffy.utc(); // Set to utc
```
# Display
### Format
The format function takes in a string pattern, which can be found [here](https://pub.dev/documentation/intl/latest/intl/DateFormat-class.html), and format them. See below
```dart
DateTime.now().format("MMMM do yyyy, h:mm:ss a"); // October 19th 2019, 7:00:53 PM
DateTime.now().format("EEEE"); // Saturday
DateTime.now().format("yyyy [escaped] yyyy"); // 2019 escaped 2019

// Not passing a string pattern for format method will return an ISO Date format
DateTime.now().format(); // 2019-10-19T19:00:53.090646
```
You can also use Intl Dateformat default methods to format. See below
```dart
DateTime.now().yMMMMd; // October 19, 2019
DateTime.now().yMMMMEEEEdjm; // Saturday, October 19, 2019 7:00 PM
```
### Time from Now
This method is used to get the relative time from now. See below
```dart
Jiffy.parseDateTime("2007-1-29").fromNow(); // 14 years ago
Jiffy.parseDateTime([2022, 10, 29]).fromNow(); // in a year
DateTime(2050, 10, 29).fromNow(); // in 30 years

var jiffy = Jiffy().startOf(Units.HOUR).fromNow(); // 9 minutes ago
```

### Time from X
This method is used to get the relative time from a specific date time. See below
```dart
var jiffy1 = Jiffy.parseDateTime("2007-1-28");
var jiffy2 = Jiffy.parseDateTime("2017-1-29", "yyyy-MM-dd");

jiffy1.from(jiffy2); // a day ago

jiffy1.from([2017, 1, 30]); // 2 days ago
```
### Difference
Used to get the difference between two Jiffy date times. See below
```dart
// By default, diff method, get the difference in milliseconds
var jiffy1 = Jiffy.parseDateTime("2007-1-28", "yyyy-MM-dd");
var jiffy2 = Jiffy.parseDateTime("2017-1-29", "yyyy-MM-dd");
jiff1.diff(jiffy2); // 86400000
```
Getting difference in another unit of measurement. The units that are available are,

`[ Units.MILLISECOND, Units.SECOND, Units.MINUTE, Units.HOUR, Units.DAY, Units.WEEK, Units.MONTH, Units.YEAR ]`
```dart
Jiffy.parseDateTime([2007, 1, 28]).diff([2017, 1, 29], Units.DAY); // -3654
```

Also by default `diff` will truncate the result to return a whole number. To get decimal numbers, just pass a third param as `true`. See below
```dart
var jiffy1 = Jiffy.parseDateTime("2008-10", "yyyy-MM");
var jiffy2 = Jiffy.parseDateTime("2007-1", "yyyy-MM");

jiff1.diff(jiffy2, Units.YEAR); // 1
jiff1.diff(jiffy2, Units.YEAR, true); // 1.75
```
**_Note: Months and years are added in respect to how many days there are in a months and if its a year is a leap year._**

### Unix Timestamp (Milliseconds)
To get timestamp in milliseconds see below
```dart
Jiffy().valueOf();
```

### Unix Timestamp (Seconds)
To get timestamp in seconds see below
```dart
Jiffy().unix();
```

# Query
### Is Before
Check if date time is before another date time. See below
```dart
var jiffy1 = Jiffy.parseDateTime("2021-10-20");
var jiffy2 = Jiffy.parseDateTime("2021-10-21");
jiffy1.isBefore(jiffy2); // true
```

You can also check in terms of units of measurement. The below example checks if year is before.
```dart
var jiffy1 = Jiffy.parseDateTime([2020, 10, 20]);

var jiffy2 = Jiffy.parseDateTime("2020-12-31", "yyyy-MM-dd");
var jiffy3 = Jiffy.parseDateTime("2021-01-01", "yyyy-MM-dd");

jiffy1.isBefore(jiffy2, Units.YEAR); // false
jiffy1.isBefore(jiffy3, Units.YEAR); // true
```

### Is Same
Check if date time is same with another date time. See below
```dart
var jiffy1 = Jiffy.parseDateTime("2021-10-20", "yyyy-MM-dd");
var jiffy2 = Jiffy.parseDateTime("2021-10-20", "yyyy-MM-dd");
jiffy1.isSame(jiffy2); // true
```

You can also check in terms of units of measurement. The below example checks if years are the same.
```dart
var jiffy1 = Jiffy.parseDateTime("2021-10-20", "yyyy-MM-dd");

var jiffy2 = Jiffy.parseDateTime("2020-12-31", "yyyy-MM-dd");
var jiffy3 = Jiffy.parseDateTime("2021-01-01", "yyyy-MM-dd");

jiffy1.isSame(jiffy2, Units.YEAR); // false
jiffy1.isSame(jiffy3, Units.YEAR); // true
```

### Is After
Check if date time is after another date time. See below
```dart
var jiffy1 = Jiffy.parseDateTime("2021-10-20", "yyyy-MM-dd");
var jiffy2 = Jiffy.parseDateTime("2021-10-19", "yyyy-MM-dd");
jiffy1.isAfter(jiffy2); // true
```

You can also check in terms of units of measurement. The below example checks if year is after.
```dart
var jiffy1 = Jiffy.parseDateTime("2021-10-20", "yyyy-MM-dd");

var jiffy2 = Jiffy.parseDateTime("2021-01-01", "yyyy-MM-dd");
var jiffy3 = Jiffy.parseDateTime("2020-12-31", "yyyy-MM-dd");

jiffy1.isAfter(jiffy2, Units.YEAR); // false
jiffy1.isAfter(jiffy3, Units.YEAR); // true
```

### Is Same or Before
Check if date time is same or before with another date time. See below
```dart
var jiffy1 = Jiffy.parseDateTime("2021-10-20", "yyyy-MM-dd");

var jiffy2 = Jiffy.parseDateTime("2020-12-31", "yyyy-MM-dd");
var jiffy3 = Jiffy.parseDateTime("2021-12-31", "yyyy-MM-dd");
var jiffy4 = Jiffy.parseDateTime("2022-01-01", "yyyy-MM-dd");

jiffy1.isSameOrBefore(jiffy2, Units.YEAR); // false
jiffy1.isSameOrBefore(jiffy3, Units.YEAR); // true
jiffy1.isSameOrBefore(jiffy4, Units.YEAR); // true
```
### Is Same or After
Check if date time is same or after with another date time. See below
```dart
var jiffy1 = Jiffy.parseDateTime("2021-10-20", "yyyy-MM-dd");

var jiffy2 = Jiffy.parseDateTime("2022-12-31", "yyyy-MM-dd");
var jiffy3 = Jiffy.parseDateTime("2021-01-01", "yyyy-MM-dd");
var jiffy4 = Jiffy.parseDateTime("2020-12-31", "yyyy-MM-dd");

jiffy1.isSameOrAfter(jiffy2, Units.YEAR); // false
jiffy1.isSameOrAfter(jiffy3, Units.YEAR); // true
jiffy1.isSameOrAfter(jiffy4, Units.YEAR); // true
```

### Is Between
Check if a date time is between two date times. See below
```dart
var jiffy1 = Jiffy.parseDateTime("2021-10-20", "yyyy-MM-dd");

var jiffy2 = Jiffy.parseDateTime("2021-01-01", "yyyy-MM-dd");
var jiffy3 = Jiffy.parseDateTime("2023-01-01", "yyyy-MM-dd");

var jiffy4 = Jiffy.parseDateTime("2020-12-31", "yyyy-MM-dd");
var jiffy5 = Jiffy.parseDateTime("2023-01-01", "yyyy-MM-dd");

jiffy1.isBetween(jiffy2, jiffy3, Units.YEAR); // false
jiffy1.isBetween(jiffy4, jiffy5, Units.YEAR); // true
```

### LeapYear
Check if date time is a leap year or not. See below
```dart
Jiffy.parseDateTime("2019", "yyyy").leapYear; // false
Jiffy.parseDateTime("2016", "yyyy").leapYear; // true
```

# Locale Support

```dart
await Jiffy.locale("fr");
DateTime.now().yMMMMEEEEdjm; // samedi 19 octobre 2019 19:25
```

Below are the locales that are supported in Jiffy. More will be added

| Key  | Locale |
| ------------- | ------------- |
| English  | en / en_sg / en_au / en_ca / en_gb / en_ie / en_il / en_nz |
| Spanish  | es / es_do / es_us |
| Chinese  | zh / zh_cn / zh_hk / zh_tw |
| Japanese  | ja |
| German  | de / de_at / de_ch |
| French  | fr / fr_ch / fr_ca |
| Indonesian  | id |
| Italian  | it / it_ch |
| Korean  | ko |
| Russian  | ru |
| Hindi  | hi |
| Arabic  | ar / ar_ly / ar_dz / ar_kw / ar_sa / ar_ma / ar_tn |
| Portuguese  | pt / pt_br |
| Polish  | pl |
| Turkish  | tr |
| Swedish | sv |
| Norwegian | nb |
| Persian | fa |
| Azerbaijani | az |

Getting and setting locales in Jiffy **_always returns a future_**

```dart
// Get the locale (By default, the locale is "en")
await Jiffy.locale(); // en

// To set locale
await Jiffy.locale("fr");
DateTime.now().yMMMMEEEEdjm; // samedi 19 octobre 2019 19:25

await Jiffy.locale("ar");
DateTime.now().yMMMMEEEEdjm; // السبت، ١٩ أكتوبر ٢٠١٩ ٧:٢٧ م

await Jiffy.locale("zh-cn");
DateTime.now().yMMMMEEEEdjm; // 2019年10月19日星期六 下午7:28
```

### Get all available locales

To get all available locales in Jiffy run the following

```dart
Jiffy.getAllAvailableLocales() // returns all locales
```
