import 'dart:async';
import "package:shared_preferences/shared_preferences.dart";

class SleepLog {}

class SleepStatus {
  SharedPreferences _prefs;
  Future get initalized => _intialized;
  Future _intialized;

  bool _sleeping = false;
  bool get sleeping => _sleeping;
  set sleeping(bool value) {
    if (sleeping == value) return; // Don't update values for no reason
    _sleeping = value;
    _prefs.setBool("sleeping", value);

    if (sleeping) {
      sleepStart = DateTime.now();
      _prefs.setInt("sleepStart", sleepStart.millisecondsSinceEpoch);
    } else {
      sleepEnd = DateTime.now();
      _prefs.setInt("sleepEnd", sleepEnd.millisecondsSinceEpoch);
    }
  }

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

      // TODO: Need error handling
      sleepStart =
          DateTime.fromMillisecondsSinceEpoch(_prefs.getInt("sleepStart"));
      sleepEnd = DateTime.fromMillisecondsSinceEpoch(_prefs.getInt("sleepEnd"));
    } else {
      _prefs.setBool("sleeping", false);
    }
  }
}

class SleepEvent {
  DateTime start;
  DateTime end;

  SleepEvent(this.start, {this.end});
}
