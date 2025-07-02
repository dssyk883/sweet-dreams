
import '../views/calendarSleepDetails_view.dart';
import '../views/calendarSleepDetails_component.dart';

import '../utils/sDetails_times.dart';

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:dio/dio.dart';
import '../../api.dart';


class calendarSleepDetailsPresenter {
  //void insertSleeptime(){}

  set calendarView(calendarSleepDetailsView value) {}
  void onDateClicked(String date) async {}

}

class BasicCalendarSleepnotesPresenter implements calendarSleepDetailsPresenter {

  calendarSleepDetailsView _view = new calendarSleepDetailsView();
  SdetailsTimes _util = SdetailsTimes();

  /*Get these from database - FULL LISTS OF SELECTIONS
  * And initialized with elements in the DB with another size. not 1.
  * */
  List<String> _details = [];
  List<String> _sleepNotes = List.filled(1, '', growable: true);
  List<String> _dreamNotes = List.filled(1, '', growable: true);

  @override
  set calendarView (calendarSleepDetailsView value){
    _view = value;
  }

  BasicCalendarSleepnotesPresenter() {
    this._util = _util;
  }

  @override
  void onDateClicked(String date) async {
    final dio = Dio();	// Http client
    final client = RestClient(dio);
    List<String> dateTime = date.split(",");
    String passingdate = dateTime[0];
    Map <String, String> req = {"userID" : _util.userID, "thisDate" : passingdate};

    List<String> timeDetails = ["No data", "No data", "No data"];
    var oneDetail = await client.findDetailsOnDate(req);

    if(oneDetail.length > 0){
      _details.clear();
      _sleepNotes.clear();
      _dreamNotes.clear();
      print("onDateClicked: " + oneDetail[0].sleepTime);
      _details.add(oneDetail[0].sleepTime);
      _details.add(oneDetail[0].wakeupTime);
      _sleepNotes = oneDetail[0].sleepNotes;
      _dreamNotes = oneDetail[0].dreamNotes;
      print(oneDetail[0].sleepTime);
      timeDetails = timeToStrings(oneDetail[0].sleepTime, oneDetail[0].wakeupTime);

    }
    _view.updatetimeDetailsOnDate(timeDetails);
    _view.updateNotes(sleepNotes: _sleepNotes, dreamNotes: _dreamNotes);

  }

  List<String> timeToStrings(String sleepTime, String wakeupTime){
    String sleepText = (sleepTime.split(",")[1]);
    print("Wakeuptime");
    print(wakeupTime);
    String wakeupText = (wakeupTime.split(",")[1]);


    String shoursText = "";
    if( wakeupText.length > 3) {
      String wakeTimeType = wakeupText.substring(wakeupText.length -2, wakeupText.length);
      String sleepTimeType = sleepText.substring(sleepText.length -2, sleepText.length);
      String sleepTimeWithoutDate = sleepText.substring(1, sleepText.length - 3);
      String wakeTimeWithoutDate = wakeupText.substring(1, wakeupText.length - 3);
      shoursText = _util.calculate(sleepTimeWithoutDate, sleepTimeType, wakeTimeWithoutDate, wakeTimeType);
    }
    else shoursText = "None";
    List<String> timeDetails = [sleepText, wakeupText, shoursText];
    return timeDetails;
  }
}