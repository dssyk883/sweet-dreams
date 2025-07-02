import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../viewmodel/alarm_viewmodel.dart';
import '../views/alarm_view.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../../main.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_native_timezone/flutter_native_timezone.dart';

class AlarmPresenter {
  void saveInAlarmList(TimeOfDay timeDay){}
  set alarmView(AlarmView value){}

}

class BasicAlarmPresenter implements AlarmPresenter {
  AlarmViewModel _viewModel = AlarmViewModel();
  AlarmView _view = AlarmView();
  BasicAlarmPresenter() {
    this._viewModel = _viewModel;
  }

  void saveInAlarmList(TimeOfDay timeDay) async {

    await _configureLocalTimeZone();
    DateTime dateNow = new DateTime.now();
    tz.TZDateTime alarmTZtime;
    print("Timepicker Hour: " + timeDay.hour.toString());
    print("DateTime Hour (now) : " + dateNow.toString());
    if(timeDay.hour >= dateNow.hour && timeDay.minute >= dateNow.minute) {
      alarmTZtime = new tz.TZDateTime(tz.local, dateNow.year, dateNow.month, dateNow.day, timeDay.hour, timeDay.minute);
    }
    else {
      alarmTZtime = new tz.TZDateTime(tz.local, dateNow.year, dateNow.month, dateNow.day + 1, timeDay.hour, timeDay.minute);
    }
    _viewModel.alarmList.add(alarmTZtime);
    scheduleAlarm(alarmTZtime);
  }

  @override
  set alarmView(AlarmView value) {
    _view = value;
  }


  Future<void> _configureLocalTimeZone() async {
    tz.initializeTimeZones();
    final String? timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName!));
  }

  void scheduleAlarm(tz.TZDateTime scheduledAlarmTime) async {
    print("scheduledAlarm: " + scheduledAlarmTime.toString());
    await _configureLocalTimeZone();
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'alarm_notification',
        'alarm_notif',
        icon: 'swd_logo',
        sound: RawResourceAndroidNotificationSound('res_custom_alarmsound'),
        //uriSound
        playSound: true,
        largeIcon: DrawableResourceAndroidBitmap('swd_logo'),
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker',
        additionalFlags: Int32List.fromList(<int>[4])
    );

    var iOSPlatformChannelSpecifics = IOSNotificationDetails(
        sound: 'alarmsound.wav',
        presentAlert: true,
        presentBadge: true,
        presentSound: true);

    NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.zonedSchedule(
        3,
        'Morning',
        'Wake up',
        //tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
        scheduledAlarmTime,
        platformChannelSpecifics,
      androidAllowWhileIdle: true,
        payload: "recordDreamNotes",
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime);

  }
}
