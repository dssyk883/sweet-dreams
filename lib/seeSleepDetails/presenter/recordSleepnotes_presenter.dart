import '../views/recordSleepnotes_view.dart';
import '../utils/sDetails_times.dart';

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:dio/dio.dart';
import '../../api.dart';
import '../../noteLists/noteLists.dart';


class recordSleepnotesPresenter {
  //void insertSleeptime(){}

  set recordSnotesView(recordSleepnotesView value){}

  void recordSleepTimeAndNotes(String sleepTime, List<OneSleepNote> sleepNotes) async {}
}

class BasicRecordSleepnotesPresenter implements recordSleepnotesPresenter {
  //recordSleepnotesViewModel _viewModel = recordSleepnotesViewModel();
  recordSleepnotesView _view = recordSleepnotesView();
  SdetailsTimes _util = SdetailsTimes();

  /*Get these from database - FULL LISTS OF SELECTIONS
  * And initialized with elements in the DB with another size. not 1.
  * */
  List<String> _sleepNotes = new List.filled(1, "", growable: true);
  List<String> _dreamNotes = new List.filled(1, "", growable: true);

  BasicRecordSleepnotesPresenter() {
    this._util = _util;
  }

  @override
  set recordSnotesView(recordSleepnotesView value){
    _view = value;
  }

  @override
  void recordSleepTimeAndNotes(String sleepTime, List<OneSleepNote> sleepNotes) async {
   //TO-DO
    print("Sleep Time: " + sleepTime);
    print("Selected sleep notes: ");
    List<String> sleepNotesReq = [];
    sleepNotes.forEach((oneNote) {
      print(oneNote.note);
      sleepNotesReq.add(oneNote.note);
    });
    final dio = Dio();	// Http client
    final client = RestClient(dio);
    Map<String, dynamic> insertSleepInfo = {
      "userID" : _util.userID,
      "sleepTime" : sleepTime,
      "sleepNotes" : sleepNotesReq,
      "sleepQuality" : "None",
      "dreamNotes" : ["None"],
      "wakeupTime" : "None, ."
    };
    var response = await client.insertSleepDetails(insertSleepInfo);
    print(response);
  }

}