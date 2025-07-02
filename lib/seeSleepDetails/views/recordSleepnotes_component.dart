import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:units/seeSleepDetails/presenter/recordSleepnotes_presenter.dart';
import '../views/recordSleepnotes_view.dart';

import '../../styles/theme1.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import '../../noteLists/noteLists.dart';


class recordSleepnotesPage extends StatefulWidget {
  final recordSleepnotesPresenter presenter;

  recordSleepnotesPage(this.presenter, {required Key? key, required this.title}) : super(key: key);

  final String title;


  @override
  _recordSleepnotesState createState() => _recordSleepnotesState();
}

class _recordSleepnotesState extends State<recordSleepnotesPage> implements recordSleepnotesView {
  var noteLists = new NoteLists();
  var _sleepTime = '';
  var _wakeupTime = '';
  var _sleepHours = '';
  var _dreamNotes = '';
  var _weather = '';
  var _steps = '';
  var _recentDate = '';
  var _noneSelected = "None selected";
  List<String> sleepNotesToString = [];
  static List<OneSleepNote> _sleepNoteList = [];
  List<OneSleepNote> _selectedSleepNotes = [];
  List<MultiSelectItem<OneSleepNote>> _items = [];

  @override
  void initState() {
    super.initState();
    this.widget.presenter.recordSnotesView = this;
    _sleepNoteList = noteLists.SleepNotes;
    _items = _sleepNoteList
        .map((aSleepNote) => MultiSelectItem<OneSleepNote>(aSleepNote, aSleepNote.note))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    var dateFormat = DateFormat('MM.dd.yyyy, hh:mm a');


    var _recordSleepNotesView = Container(
          decoration: BoxDecoration(
            color: Color.fromRGBO(220, 237, 246, 1).withOpacity(.4),
            border: Border.all(
              color: Color.fromRGBO(220, 237, 246, 1),
              width: 2,
            ),
          ),
          child: Column(
            children: <Widget>[
              MultiSelectBottomSheetField(
                initialChildSize: 0.4,
                listType: MultiSelectListType.LIST,
                searchable: true,
                buttonText: Text("How was your day?"),
                title: Text("Sleep Notes"),
                items: _items,
                onConfirm: (values) {
                  _selectedSleepNotes.clear();
                  values.forEach((value) {
                    OneSleepNote oneNote = value! as OneSleepNote;
                    _selectedSleepNotes.add(oneNote);
                  });

                  setState(() {
                    if (_selectedSleepNotes.isNotEmpty) {
                      _noneSelected = '';
                    }
                    else{
                      _noneSelected = "None selected";
                    }
                  });
                },
                chipDisplay: MultiSelectChipDisplay(
                  onTap: (value) {
                    setState(() {
                      //Just handler
                    });
                  },
                ),
              ),


            ],
          ),
        );




    return Scaffold(
        appBar: AppBar(
        title: Text("Sleep"),
    ),
    body: Center(
    child: Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: <Widget>[
      Padding(
        padding: EdgeInsets.only(top: 10),
        child: _recordSleepNotesView,
      ),
      Container(
          padding: EdgeInsets.all(10),
          alignment: Alignment.centerLeft,
          child: Text(
            '$_noneSelected',
            style: TextStyle(color: Colors.black54),
          )),
      Padding(
          padding: EdgeInsets.only(top: 20.0),
          child:
          ElevatedButton(
              style: majorTheme.elevatedButtonTheme.style,
              child: Text('Sleep now'),
              onPressed: () {
                _sleepTime = dateFormat.format(DateTime.now());
                this.widget.presenter.recordSleepTimeAndNotes(_sleepTime, _selectedSleepNotes);
                Navigator.pop(context);
              }))
    ]),
    ));
  }
}