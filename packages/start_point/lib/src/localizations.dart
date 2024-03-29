// MIT License
//
// Copyright (c) 2017-present qazyn951230 qazyn951230@gmail.com
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'date_picker.dart';

/// Determines the order of the columns inside [DatePicker] in
/// time and date time mode.
enum DatePickerDateTimeOrder {
  /// Order of the columns, from left to right: date, hour, minute, am/pm.
  ///
  /// Example: Fri Aug 31 | 02 | 08 | PM.
  date_time_dayPeriod,
  /// Order of the columns, from left to right: date, am/pm, hour, minute.
  ///
  /// Example: Fri Aug 31 | PM | 02 | 08.
  date_dayPeriod_time,
  /// Order of the columns, from left to right: hour, minute, am/pm, date.
  ///
  /// Example: 02 | 08 | PM | Fri Aug 31.
  time_dayPeriod_date,
  /// Order of the columns, from left to right: am/pm, hour, minute, date.
  ///
  /// Example: PM | 02 | 08 | Fri Aug 31.
  dayPeriod_time_date,
}

/// Determines the order of the columns inside [DatePicker] in date mode.
enum DatePickerDateOrder {
  /// Order of the columns, from left to right: day, month, year.
  ///
  /// Example: 12 | March | 1996
  dmy,
  /// Order of the columns, from left to right: month, day, year.
  ///
  /// Example: March | 12 | 1996
  mdy,
  /// Order of the columns, from left to right: year, month, day.
  ///
  /// Example: 1996 | March | 12
  ymd,
  /// Order of the columns, from left to right: year, day, month.
  ///
  /// Example: 1996 | 12 | March
  ydm,
}

/// Defines the localized resource values used by the  widgets.
///
/// See also:
///
///  * [DefaultLocalizations], the default, English-only, implementation
///    of this interface.
// TODO(xster): Supply non-english strings.
abstract class StartLocalizations {
  /// Year that is shown in [DatePicker] spinner corresponding to the
  /// given year index.
  ///
  /// Examples: datePickerYear(1) in:
  ///
  ///  - US English: 2018
  ///  - Korean: 2018년
  // The global version uses date symbols data from the intl package.
  String datePickerYear(int yearIndex);

  /// Month that is shown in [DatePicker] spinner corresponding to
  /// the given month index.
  ///
  /// Examples: datePickerMonth(1) in:
  ///
  ///  - US English: January
  ///  - Korean: 1월
  // The global version uses date symbols data from the intl package.
  String datePickerMonth(int monthIndex);

  /// Day of month that is shown in [DatePicker] spinner corresponding
  /// to the given day index.
  ///
  /// Examples: datePickerDayOfMonth(1) in:
  ///
  ///  - US English: 1
  ///  - Korean: 1일
  // The global version uses date symbols data from the intl package.
  String datePickerDayOfMonth(int dayIndex);

  /// The medium-width date format that is shown in [DatePicker]
  /// spinner. Abbreviates month and days of week.
  ///
  /// Examples:
  ///
  /// - US English: Wed Sep 27
  /// - Russian: ср сент. 27
  // The global version is based on intl package's DateFormat.MMMEd.
  String datePickerMediumDate(DateTime date);

  /// Hour that is shown in [DatePicker] spinner corresponding
  /// to the given hour value.
  ///
  /// Examples: datePickerHour(1) in:
  ///
  ///  - US English: 1
  ///  - Arabic: ٠١
  // The global version uses date symbols data from the intl package.
  String datePickerHour(int hour);

  /// Semantics label for the given hour value in [DatePicker].
  // The global version uses the translated string from the arb file.
  String datePickerHourSemanticsLabel(int hour);

  /// Minute that is shown in [DatePicker] spinner corresponding
  /// to the given minute value.
  ///
  /// Examples: datePickerMinute(1) in:
  ///
  ///  - US English: 01
  ///  - Arabic: ٠١
  // The global version uses date symbols data from the intl package.
  String datePickerMinute(int minute);

  /// Semantics label for the given minute value in [DatePicker].
  // The global version uses the translated string from the arb file.
  String datePickerMinuteSemanticsLabel(int minute);

  /// The order of the date elements that will be shown in [DatePicker].
  // The global version uses the translated string from the arb file.
  DatePickerDateOrder get datePickerDateOrder;

  /// The order of the time elements that will be shown in [DatePicker].
  // The global version uses the translated string from the arb file.
  DatePickerDateTimeOrder get datePickerDateTimeOrder;

  /// The abbreviation for ante meridiem (before noon) shown in the time picker.
  // The global version uses the translated string from the arb file.
  String get anteMeridiemAbbreviation;

  /// The abbreviation for post meridiem (after noon) shown in the time picker.
  // The global version uses the translated string from the arb file.
  String get postMeridiemAbbreviation;

  /// Label shown in date pickers when the date is today.
  // The global version uses the translated string from the arb file.
  String get todayLabel;

  /// The term used by the system to announce dialog alerts.
  // The global version uses the translated string from the arb file.
  String get alertDialogLabel;

  /// Hour that is shown in [TimerPicker] corresponding to
  /// the given hour value.
  ///
  /// Examples: timerPickerHour(1) in:
  ///
  ///  - US English: 1
  ///  - Arabic: ١
  // The global version uses date symbols data from the intl package.
  String timerPickerHour(int hour);

  /// Minute that is shown in [TimerPicker] corresponding to
  /// the given minute value.
  ///
  /// Examples: timerPickerMinute(1) in:
  ///
  ///  - US English: 1
  ///  - Arabic: ١
  // The global version uses date symbols data from the intl package.
  String timerPickerMinute(int minute);

  /// Second that is shown in [TimerPicker] corresponding to
  /// the given second value.
  ///
  /// Examples: timerPickerSecond(1) in:
  ///
  ///  - US English: 1
  ///  - Arabic: ١
  // The global version uses date symbols data from the intl package.
  String timerPickerSecond(int second);

  /// Label that appears next to the hour picker in
  /// [TimerPicker] when selected hour value is `hour`.
  /// This function will deal with pluralization based on the `hour` parameter.
  // The global version uses the translated string from the arb file.
  String timerPickerHourLabel(int hour);

  /// Label that appears next to the minute picker in
  /// [TimerPicker] when selected minute value is `minute`.
  /// This function will deal with pluralization based on the `minute` parameter.
  // The global version uses the translated string from the arb file.
  String timerPickerMinuteLabel(int minute);

  /// Label that appears next to the minute picker in
  /// [TimerPicker] when selected minute value is `second`.
  /// This function will deal with pluralization based on the `second` parameter.
  // The global version uses the translated string from the arb file.
  String timerPickerSecondLabel(int second);

  /// The term used for cutting
  // The global version uses the translated string from the arb file.
  String get cutButtonLabel;

  /// The term used for copying
  // The global version uses the translated string from the arb file.
  String get copyButtonLabel;

  /// The term used for pasting
  // The global version uses the translated string from the arb file.
  String get pasteButtonLabel;

  /// The term used for selecting everything
  // The global version uses the translated string from the arb file.
  String get selectAllButtonLabel;

  /// The `Localizations` from the closest [Localizations] instance
  /// that encloses the given context.
  ///
  /// This method is just a convenient shorthand for:
  /// `Localizations.of<Localizations>(context, Localizations)`.
  ///
  /// References to the localized resources defined by this class are typically
  /// written in terms of this method. For example:
  ///
  /// ```dart
  /// Localizations.of(context).anteMeridiemAbbreviation;
  /// ```
  static StartLocalizations of(BuildContext context) {
    return Localizations.of<StartLocalizations>(context, Localizations);
  }
}

class _LocalizationsDelegate extends LocalizationsDelegate<StartLocalizations> {
  const _LocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => locale.languageCode == 'en';

  @override
  Future<StartLocalizations> load(Locale locale) => DefaultLocalizations.load(locale);

  @override
  bool shouldReload(_LocalizationsDelegate old) => false;

  @override
  String toString() => 'DefaultLocalizations.delegate(en_US)';
}

/// US English strings for the  widgets.
class DefaultLocalizations implements StartLocalizations {
  /// Constructs an object that defines the  widgets' localized strings
  /// for US English (only).
  ///
  /// [LocalizationsDelegate] implementations typically call the static [load]
  /// function, rather than constructing this class directly.
  const DefaultLocalizations();

  static const List<String> _shortWeekdays = <String>[
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun',
  ];

  static const List<String> _shortMonths = <String>[
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];

  static const List<String> _months = <String>[
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];



  @override
  String datePickerYear(int yearIndex) => yearIndex.toString();

  @override
  String datePickerMonth(int monthIndex) => _months[monthIndex - 1];

  @override
  String datePickerDayOfMonth(int dayIndex) => dayIndex.toString();

  @override
  String datePickerHour(int hour) => hour.toString();

  @override
  String datePickerHourSemanticsLabel(int hour) => hour.toString() + " o'clock";

  @override
  String datePickerMinute(int minute) => minute.toString().padLeft(2, '0');

  @override
  String datePickerMinuteSemanticsLabel(int minute) {
    if (minute == 1)
      return '1 minute';
    return minute.toString() + ' minutes';
  }

  @override
  String datePickerMediumDate(DateTime date) {
    return '${_shortWeekdays[date.weekday - DateTime.monday]} '
      '${_shortMonths[date.month - DateTime.january]} '
      '${date.day.toString().padRight(2)}';
  }

  @override
  DatePickerDateOrder get datePickerDateOrder => DatePickerDateOrder.mdy;

  @override
  DatePickerDateTimeOrder get datePickerDateTimeOrder => DatePickerDateTimeOrder.date_time_dayPeriod;

  @override
  String get anteMeridiemAbbreviation => 'AM';

  @override
  String get postMeridiemAbbreviation => 'PM';

  @override
  String get todayLabel => 'Today';

  @override
  String get alertDialogLabel => 'Alert';

  @override
  String timerPickerHour(int hour) => hour.toString();

  @override
  String timerPickerMinute(int minute) => minute.toString();

  @override
  String timerPickerSecond(int second) => second.toString();

  @override
  String timerPickerHourLabel(int hour) => hour == 1 ? 'hour' : 'hours';

  @override
  String timerPickerMinuteLabel(int minute) => 'min.';

  @override
  String timerPickerSecondLabel(int second) => 'sec.';

  @override
  String get cutButtonLabel => 'Cut';

  @override
  String get copyButtonLabel => 'Copy';

  @override
  String get pasteButtonLabel => 'Paste';

  @override
  String get selectAllButtonLabel => 'Select All';

  /// Creates an object that provides US English resource values for the
  ///  library widgets.
  ///
  /// The [locale] parameter is ignored.
  ///
  /// This method is typically used to create a [LocalizationsDelegate].
  static Future<StartLocalizations> load(Locale locale) {
    return SynchronousFuture<StartLocalizations>(const DefaultLocalizations());
  }

  /// A [LocalizationsDelegate] that uses [DefaultLocalizations.load]
  /// to create an instance of this class.
  static const LocalizationsDelegate<StartLocalizations> delegate = _LocalizationsDelegate();
}
