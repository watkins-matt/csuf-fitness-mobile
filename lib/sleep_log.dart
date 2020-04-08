import 'dart:async';
import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import "package:shared_preferences/shared_preferences.dart";

extension Normalize on DateTime {
  DateTime normalize() {
    return DateTime(this.year, this.month, this.day);
  }
}

class SleepDataProvider extends ChangeNotifier {
  SplayTreeMap<String, SleepLog> cache = SplayTreeMap<String, SleepLog>();

  SleepLog getDate(DateTime date) {
    String dateString = DateFormat.yMMMMd().format(date);

    if (cache.containsKey(dateString)) {
      return cache[dateString];
    } else {
      SleepLog log = SleepLog(date.normalize());
      cache[dateString] = log;
      return log;
    }
  }
}

/// Represents all sleep events for one specific day
class SleepLog {
  final DateTime date;
  List<SleepEvent> events = <SleepEvent>[];
  Duration get length {
    int ms = 0;
    events.forEach((event) {
      ms += event.length.inMilliseconds;
    });

    return Duration(milliseconds: ms);
  }

  SleepLog(this.date);
}

/// Represents one instance of a user sleeping for a specific time period.
class SleepEvent {
  DateTime start;
  DateTime end;
  Duration get length => end.difference(start);

  SleepEvent(this.start, this.end);
}

class SleepStatus {
  SharedPreferences _prefs;
  Future get initialized => _intialized;
  Future _intialized;

  bool _sleeping = false;
  bool get sleeping => _sleeping;
  set sleeping(bool value) {
    if (sleeping == value) return; // Don't update values for no reason
    _sleeping = value;
    _prefs.setBool("sleeping", value);

    if (sleeping) {
      sleepEnd = null;
      sleepStart = DateTime.now();
      _prefs.setInt("sleepStart", sleepStart.millisecondsSinceEpoch);
    } else {
      sleepEnd = DateTime.now();
      _prefs.setInt("sleepEnd", sleepEnd.millisecondsSinceEpoch);
    }
  }

  SleepEvent get lastEvent => SleepEvent(sleepStart, sleepEnd);

  Duration get sleepLength => sleepEnd != null
      ? sleepEnd.difference(sleepStart)
      : sleepStart != null ? DateTime.now().difference(sleepStart) : Duration();

  DateTime sleepStart;
  DateTime sleepEnd;

  static final SleepStatus _instance = SleepStatus._internal();
  SleepStatus._internal() {
    _intialized = _init();
  }

  factory SleepStatus() {
    return _instance;
  }

  Future _init() async {
    _prefs = await SharedPreferences.getInstance();

    if (_prefs.containsKey("sleeping")) {
      _sleeping = _prefs.getBool("sleeping");
      if (_prefs.containsKey("sleepStart")) {
        sleepStart =
            DateTime.fromMillisecondsSinceEpoch(_prefs.getInt("sleepStart"));
      }

      if (_prefs.containsKey("sleepEnd")) {
        sleepEnd =
            DateTime.fromMillisecondsSinceEpoch(_prefs.getInt("sleepEnd"));
      }
    } else {
      _prefs.setBool("sleeping", false);
    }
  }
}
