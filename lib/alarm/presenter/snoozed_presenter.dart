import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:units/alarm/views/snoozed_view.dart';
import 'package:units/noteLists/noteLists.dart';
import '../viewmodel/snoozed_viewmodel.dart';
import 'package:logger/logger.dart';
import 'package:dio/dio.dart';
import '../../api.dart';

import '../views/alarm_view.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../../main.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_native_timezone/flutter_native_timezone.dart';

class SnoozedPresenter {
  set snoozedView(SnoozedView value){}
  set snoozedViewModel (SnoozedViewModel vmodel) {}

  void loadDetailsOnDate(String date) async {}
  void saveButtonPressed(String wakeupTime, String sleepQuality, List<OneDreamNote> dreamNotes){}
}

class BasicSnoozedPresenter implements SnoozedPresenter {

  SnoozedView _view = SnoozedView();
  SnoozedViewModel _viewmodel = SnoozedViewModel();

  BasicSnoozedPresenter() {
    this._viewmodel = _viewmodel;
  }

  @override
  set snoozedView(SnoozedView value) {
    _view = value;
  }

  @override
  set snoozedViewModel(SnoozedViewModel vmodel){
    _viewmodel = vmodel;
  }

  @override
  void saveButtonPressed(String wakeupTime, String sleepQuality, List<OneDreamNote> dreamNotes){
    print("sleepnotes:");
    print(_viewmodel.sleepNotes);
    recordSleepTimeAndNotes(_viewmodel.date, _viewmodel.sleepTime, wakeupTime, sleepQuality,
    _viewmodel.sleepNotes, dreamNotes);
  }

  @override
  void loadDetailsOnDate(String date) async {
    final logger = Logger();	// Logging client
    final dio = Dio();	// Http client
    final client = RestClient(dio);	// Creating Http client to handle API requests

    Map<String, String> req = {"userID": _viewmodel.userID, "thisDate" : date};

    var recentDetail = await client.findDetailsOnDate(req);
    if(recentDetail.length != 0) {
      _viewmodel.sleepTime = recentDetail[0].sleepTime;
      _viewmodel.wakeupTime = recentDetail[0].wakeupTime;
      _viewmodel.sleepNotes = recentDetail[0].sleepNotes;
      _viewmodel.dreamNotes = recentDetail[0].dreamNotes;
      _viewmodel.sleepQuality = recentDetail[0].sleepQuality;
      _viewmodel.date = recentDetail[0].sleepTime.split(",")[0];
      print(_viewmodel.sleepNotes);
    }
    else { //if No data found
      _viewmodel.sleepTime = '';
      _viewmodel.wakeupTime = '';
      _viewmodel.sleepNotes = [];
      _viewmodel.dreamNotes = [];
      _viewmodel.sleepQuality = '';
    }
  }

  @override
  void recordSleepTimeAndNotes(String date, String sleepTime, String wakeupTime, String sleepQuality, List<String> sleepNotes, List<OneDreamNote> dreamNotes) async {

    List<String> sleepNotesReq = sleepNotes;
    List<String> dreamNotesReq = [];
    String dateSleepTime = sleepTime;
    String dateWakeTime = wakeupTime;

    dreamNotes.forEach((oneNote) {
      dreamNotesReq.add(oneNote.note);
    });
    print("dreamNotesReq");
    print(dreamNotesReq);
    final dio = Dio();	// Http client
    final client = RestClient(dio);
    Map<String, dynamic> updateSleepInfo = {
      "userID" : _viewmodel.userID,
      "updateDate" : date,
      "sleepTime" : dateSleepTime,
      "sleepNotes" : sleepNotesReq,
      "sleepQuality" : sleepQuality,
      "dreamNotes" : dreamNotesReq,
      "wakeupTime" : dateWakeTime
    };
    print(updateSleepInfo);
    var response = await client.updateSleepDetails(updateSleepInfo);
    print(response);
  }

}