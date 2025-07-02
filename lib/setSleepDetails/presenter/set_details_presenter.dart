import '../views/set_details_view.dart';
//import '../viewmodel/set_details_viewmodel.dart';
import '../../noteLists/noteLists.dart';
import '../utils/set_details_times.dart';

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:dio/dio.dart';
import '../../api.dart';
import 'package:intl/intl.dart';

class SetDetailsPresenter {

  void loadRecentDetails() {}
  void loadDetailsOnDate(String date) async {}
  void onSaveButtonPressed() {}
  //void loadDetailsOnDate(String date) {}
  void recordSleepTimeAndNotes(String date, String sleepTime, String wakeupTime, double sleepQuality, List<OneSleepNote> sleepNotes, List<OneDreamNote> dreamNotes) async {}
  set setDetailsView(SetDetailsView value){}

}

class BasicSetDetailsPresenter implements SetDetailsPresenter{
  //SetDetailsViewModel _viewModel = SetDetailsViewModel();
  SetDetailsView _view = SetDetailsView();
  SetDetailsTimes _util = SetDetailsTimes();

  BasicSetDetailsPresenter() {
    //this._viewModel = _viewModel;
    this._util = _util;
  }

  // void _loadUnit() async {
  //   loadRecentDetails();
  // }

  @override
  set setDetailsView(SetDetailsView value) {
    _view = value;
  }

  @override
  void onSaveButtonPressed() {

  }

  @override
  void loadRecentDetails() async {
    final logger = Logger();	// Logging client
    final dio = Dio();	// Http client
    final client = RestClient(dio);	// Creating Http client to handle API requests

    Map<String, String> req = {"userID": _util.userID};

    var recentDetail = await client.getRecentDetails(req);
  print(1);
    _util.sleepTime = recentDetail[0].sleepTime;
    _util.wakeupTime = recentDetail[0].wakeupTime;
    _util.sleepNotes = recentDetail[0].sleepNotes;
    _util.dreamNotes = recentDetail[0].dreamNotes;
    _util.sleepQuality = recentDetail[0].sleepQuality;
    print(_util.sleepNotes);
    //Calculator here
    setRecentDetailsView((recentDetail[0].sleepTime).split(",")[0]);
  }

  @override
  void loadDetailsOnDate(String date) async {
    final logger = Logger();	// Logging client
    final dio = Dio();	// Http client
    final client = RestClient(dio);	// Creating Http client to handle API requests

    Map<String, String> req = {"userID": _util.userID, "thisDate" : date};

    var recentDetail = await client.findDetailsOnDate(req);
    if(recentDetail.length != 0) {
      _util.sleepTime = recentDetail[0].sleepTime;
      _util.wakeupTime = recentDetail[0].wakeupTime;
      _util.sleepNotes = recentDetail[0].sleepNotes;
      _util.dreamNotes = recentDetail[0].dreamNotes;
      _util.sleepQuality = recentDetail[0].sleepQuality;
      setRecentDetailsView((recentDetail[0].sleepTime).split(",")[0]);
    }
    else { //if No data found
      _util.sleepTime = '';
      _util.wakeupTime = '';
      _util.sleepNotes = [];
      _util.dreamNotes = [];
      _util.sleepQuality = '';

      setRecentDetailsView('');
    }

    print(_util.sleepNotes);
    //Calculator here

  }

  String getSleepTime() {
    return _util.sleepTime;
  }

  void setRecentDetailsView(String recentDate){
    if(recentDate != ''){
      _view.updateRecentDate(recentDate: recentDate);
      _view.updateSleepTime(sleepTimeResult: timeToStrings());
      _view.updateNotes(sleepNotes: _util.sleepNotes, dreamNotes: _util.dreamNotes);
    }
  }

  //would be changed after calculator is implemented
  List<String> timeToStrings(){
    String sleepText = ((_util.sleepTime).split(",")[1]);
    String wakeupText = ((_util.wakeupTime).split(",")[1]);
    String sleepQuality = (_util.sleepQuality);

    List<String> timeDetails = [sleepText, wakeupText, sleepQuality];
    return timeDetails;
  }

  @override
  void recordSleepTimeAndNotes(String date, String sleepTime, String wakeupTime, double sleepQuality, List<OneSleepNote> sleepNotes, List<OneDreamNote> dreamNotes) async {

    print("Sleep Time: " + sleepTime);
    List<String> sleepNotesReq = [];
    List<String> dreamNotesReq = [];
    String dateSleepTime = date + ", " + sleepTime;
    String dateWakeTime = "None";
    if (wakeupTime != null && wakeupTime != "") {
      dateWakeTime = incrementDate(date) + ", " + wakeupTime;
    }
    else {
      dateWakeTime = "None";
    }
    sleepNotes.forEach((oneNote) {
      print(oneNote.note);
      sleepNotesReq.add(oneNote.note);
    });
    dreamNotes.forEach((oneNote) {
      print(oneNote.note);
      dreamNotesReq.add(oneNote.note);
    });
    String strSleepQuality = sleepQuality.toString();
    final dio = Dio();	// Http client
    final client = RestClient(dio);
    Map<String, dynamic> insertSleepInfo = {
      "userID" : _util.userID,
      "updateDate" : date,
      "sleepTime" : dateSleepTime,
      "sleepNotes" : sleepNotesReq,
      "sleepQuality" : strSleepQuality,
      "dreamNotes" : dreamNotesReq,
      "wakeupTime" : dateWakeTime
    };
    print(insertSleepInfo);
    var response = await client.updateSleepDetails(insertSleepInfo);
    print(response);
  }

  String incrementDate(oldDate) {
    String returnDate = "";
    print("yup");
    print(oldDate);
    int intMonth = int.parse(oldDate.split(".")[2]);
    int intDay = int.parse(oldDate.split(".")[0]);
    int intYear = int.parse(oldDate.split(".")[1]);
    var date = new DateTime(intMonth, intDay, intYear);
    var newDate = new DateTime(date.year, date.month, date.day + 1);
    String month = newDate.month.toString();
    String day = newDate.day.toString();
    String year = newDate.year.toString();
    returnDate = month + "." + day + "." + year;
    print("returnDate =" + returnDate);
    return returnDate;
  }

    // @override
    // void loadDetailsOnDate(String date) async {
    //   final dio = Dio();	// Http client
    //   final client = RestClient(dio);
    //
    //   List<String> dateTime = date.split(",");
    //   // Map <String, String> req = {"userID" : _util.userID, "date" : dateTime[0]};
    //   Map <String, String> req = {"userID" : _util.userID, "thisDate" : "11.05.2021"};
    //   print(1);
    //   //var oneDetail = await client.getDetailsOnDate(req);
    //   var oneDetail = await client.findDetailsOnDate(req);
    //   print(1.5);
    //   print(oneDetail.length);
    //   print("values:");
    //   _util.sleepTime = oneDetail[0].sleepTime;
    //   print(oneDetail[0].sleepTime);
    //   _util.wakeupTime = oneDetail[0].wakeupTime;
    //   print(oneDetail[0].wakeupTime);
    //   _util.sleepNotes = oneDetail[0].sleepNotes;
    //   print(oneDetail[0].sleepNotes);
    //   _util.dreamNotes = oneDetail[0].dreamNotes;
    //   print(oneDetail[0].dreamNotes);
    //   _util.sleepQuality = oneDetail[0].sleepQuality;
    //   print(oneDetail[0].sleepQuality);
    //   print(2);
    //
    //   setRecentDetailsView((oneDetail[0].sleepTime).split(",")[0]);
    // }

}