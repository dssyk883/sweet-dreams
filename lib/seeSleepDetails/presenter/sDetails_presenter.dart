import '../views/sDetails_view.dart';
import '../viewmodel/sDetails_viewmodel.dart';
import '../utils/sDetails_times.dart';

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:dio/dio.dart';
import '../../api.dart';


class SdetailsPresenter {

  void onButtonPressed() {}
  void onSeeSleepTimeClicked() {}
  void loadRecentDetails() {}
  void loadAllDetails() {}
  void getOthers() {}
  //void insertSleeptime(){}

  set detailsView(SdetailsView value){}
}

class BasicSdetailsPresenter implements SdetailsPresenter {
  SdetailsViewModel _viewModel = SdetailsViewModel();
  SdetailsView _view = SdetailsView();
  SdetailsTimes _util = SdetailsTimes();

  BasicSdetailsPresenter() {
    this._viewModel = _viewModel;
    this._util = _util;
  }

  @override
  void onButtonPressed() {

  }

  @override
  set detailsView(SdetailsView value){
    _view = value;
  }

  //Need to change later - how to get saved time info from database
  @override
  void onSeeSleepTimeClicked() {
    var bedHour = 0;
    var bedMinute = 0;
    var wakeHour = 0;
    var wakeMinute = 0;

    loadRecentDetails();
    print("onSeeSleepTimeClicked: " + _util.sleepTime);
  }

  @override
  void getOthers() {
    //USer inputs or api?
    double weather = 42;
    int steps = 5348;
    _view.updateOthers(weather: weather, steps: steps);
  }
  //
  // @override
  // void insertSleeptime() async {
  //   var dateFormat = DateFormat('MM.dd.yyyy, hh:mm a');
  //   var todayDate = dateFormat.format(DateTime.now());
  //
  //   final logger = Logger();	// Logging client
  //   final dio = Dio();	// Http client
  //   final client = RestClient(dio);	// Creating Http client to handle API requests
  //   Map<String, dynamic> insertDocument = {
  //     "name" : "newCollection",
  //     "hash" : todayDate.toString(),
  //     "other": ["Coffee", "Ate late"]
  //   };
  //   client.insertToCollection(insertDocument).then((it) => logger.i(it));
  //   var response = await client.insertToCollection(insertDocument);
  // }

  @override
  void loadRecentDetails() async {
    final logger = Logger();	// Logging client
    final dio = Dio();	// Http client
    final client = RestClient(dio);	// Creating Http client to handle API requests

    Map<String, String> req = {"userID": _util.userID};

    var recentDetail = await client.getRecentDetails(req);

    _util.sleepTime = recentDetail[0].sleepTime;
    _util.wakeupTime = recentDetail[0].wakeupTime;
    _util.sleepNotes = recentDetail[0].sleepNotes;
    _util.dreamNotes = recentDetail[0].dreamNotes;
    print(_util.sleepNotes);
    //Calculator here
    setRecentDetailsView((recentDetail[0].sleepTime).split(",")[0]);

  }

  void setRecentDetailsView(String recentDate){
    _view.updateRecentDate(recentDate: recentDate);
    _view.updateSleepTime(sleepTimeResult: timeToStrings());
    _view.updateNotes(sleepNotes: _util.sleepNotes, dreamNotes: _util.dreamNotes);
  }



  @override
  void loadAllDetails() async {
    final logger = Logger();	// Logging client
    final dio = Dio();	// Http client
    final client = RestClient(dio);	// Creating Http client to handle API requests

    Map<String, String> req = {"userID": _util.userID};
    _util.detailList =  await client.getAllDetails(req);
  }

  //would be changed after calculator is implemented
  List<String> timeToStrings(){
    String sleepText = ((_util.sleepTime).split(",")[1]);
    String wakeupText = ((_util.wakeupTime).split(",")[1]);

    String shoursText = "";
    if(wakeupText.length > 3) {
      String sleepTimeType = sleepText.substring(sleepText.length -2, sleepText.length);
      String sleepTime = sleepText.substring(1, sleepText.length - 3);
      String wakeTime = wakeupText.substring(1, wakeupText.length - 3);

      String wakeTimeType = wakeupText.substring(wakeupText.length -2, wakeupText.length);

      shoursText = _util.calculate(sleepTime, sleepTimeType, wakeTime, wakeTimeType);
    }
    List<String> timeDetails = [sleepText, wakeupText, shoursText];
    return timeDetails;
  }
}