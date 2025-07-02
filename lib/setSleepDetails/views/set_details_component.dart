import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:units/styles/theme1.dart';
import '../views/set_details_view.dart';
import '../presenter/set_details_presenter.dart';
//import '../viewmodel/set_details_viewmodel.dart';
import '../../noteLists/noteLists.dart';

class SetDetailsPage extends StatefulWidget {
  final SetDetailsPresenter presenter;

  SetDetailsPage(this.presenter, {required Key? key, required this.title, required this.date}) : super(key: key);
  final String title;
  final String date;

  @override
  _SetDetailsPageState createState() => _SetDetailsPageState();
}

class _SetDetailsPageState extends State<SetDetailsPage> implements SetDetailsView {

  TimeOfDay selectedTime = TimeOfDay.now();

  String _text = "";
  // late TextEditingController _bedTimeController;
  // late TextEditingController _wakeupTimeController;
  late TextEditingController _sleepQualityController;

  var _date = '';

  var _bedTime = '';
  var _wakeupTime = '';
  var _sleepHours = '';
  var _sleepNotes = '';
  var _dreamNotes = '';
  var _sleepQuality = '';
  var _weather = '';
  var _steps = '';
  var _recentDate = '';

  var _bedTimeText = '';
  var _wakeupTimeText = '';

  double _currentSliderValue = 0;

  var _noneSelected = "None selected";
  List<String> sleepNotesToString = [];
  static List<OneSleepNote> _sleepNoteList = [
  OneSleepNote(0, "Ate late"),
  OneSleepNote(1, "Worked out"),
  OneSleepNote(2, "Alcohol"),
  OneSleepNote(3, "Stressful"),
  OneSleepNote(4, "Good day"),
  OneSleepNote(5, "Nap"),
  OneSleepNote(6, "Coffee"),
  ];
  List<OneSleepNote> _selectedSleepNotes = [];
  List<MultiSelectItem<OneSleepNote>> _sleepNoteItems = [];

  List<String> dreamNotesToString = [];
  static List<OneDreamNote> _dreamNoteList = NoteLists().DreamNotes;

  List<OneDreamNote> _selectedDreamNotes = [];
  List<MultiSelectItem<OneDreamNote>> _dreamNoteItems = [];



  @override
  void initState() {
    super.initState();
    this.widget.presenter.setDetailsView = this;
    _date = this.widget.date;
    _sleepNoteItems = _sleepNoteList
        .map((aSleepNote) => MultiSelectItem<OneSleepNote>(aSleepNote, aSleepNote.note))
        .toList();
    _dreamNoteItems = _dreamNoteList
        .map((aDreamNote) => MultiSelectItem<OneDreamNote>(aDreamNote, aDreamNote.note))
        .toList();
    // _bedTimeController = TextEditingController();
    // _wakeupTimeController = TextEditingController();
    _sleepQualityController = TextEditingController();
    _seeDetails();

  }

  void _seeDetails() {

    if(_date == "None"){
      this.widget.presenter.loadRecentDetails();
    }
    else {
      this.widget.presenter.loadDetailsOnDate(_date);
    }
  }

  void updateText(String text){
    print("calling updateText");
  }

  @override
  void updateRecentDate ({required String recentDate}){
    setState(() {
      _recentDate = recentDate;
      print(_recentDate);
    });
  }

  @override
  void updateSleepTime({required List<String> sleepTimeResult}){
    print("In Component:" + sleepTimeResult[0]);
    setState(() {

      _bedTimeText = "0:00";
      _wakeupTimeText = "0:00";
      _bedTime = sleepTimeResult[0];
      print("sleepTimeresult[0] in Component:" + sleepTimeResult[0]);
      print("_bedtime in Component:" + _bedTime);
      var length = sleepTimeResult.length;
      print("length: $length");
      _wakeupTime = sleepTimeResult[1];
      _sleepQuality = sleepTimeResult[2];
      print(2);
      _bedTimeText = _bedTime;
      _wakeupTimeText = _wakeupTime;
      _sleepQualityController.text = _sleepQuality;
      print(3);
    });
  }

  @override
  void updateNotes({required List<String> sleepNotes, required List<String> dreamNotes}) {
    for (var sn in sleepNotes) {
      if (sn != null) {
        _sleepNotes += sn + ". ";
      }
    }
    for (var dn in dreamNotes) {
      if (dn != null) {
        _dreamNotes += dn + ". ";
      }
    }
  }

  void _saveButtonPress() {
    print("bedtime saved as: " + _bedTimeText);
    this.widget.presenter.recordSleepTimeAndNotes(_date, _bedTimeText, _wakeupTimeText, _currentSliderValue, _selectedSleepNotes, _selectedDreamNotes);

  }

  @override
  void dispose() {
    // _bedTimeController.dispose();
    // _wakeupTimeController.dispose();
    _sleepQualityController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    var _qualitySlider = Slider(
      value: _currentSliderValue,
      min: 0,
      max: 10,
      divisions: 10,
      label: _currentSliderValue.round().toString(),
      onChanged: (double value) {
        setState(() {
          _currentSliderValue = value;
        });
      },
    );

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
            buttonText: Text("Sleep Notes"),
            title: Text("Sleep notes"),
            items: _sleepNoteItems,
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

    var _recordDreamNotesView = Container(
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
            buttonText: Text("Dream Notes"),
            title: Text("Dream notes"),
            items: _dreamNoteItems,
            onConfirm: (values) {
              _selectedDreamNotes.clear();
              values.forEach((value) {
                OneDreamNote oneNote = value! as OneDreamNote;
                _selectedDreamNotes.add(oneNote);
              });

              setState(() {
                if (_selectedDreamNotes.isNotEmpty) {
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
        title: Text("Set sleep details"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 20.0, left: 40.0, right: 40.0),
              child:
              Text("Bed time: " + _bedTimeText, textAlign: TextAlign.center,)
            ),
            Padding(
              padding: EdgeInsets.only(left: 40.0, right: 40.0),
              child:
                TextButton(
                  child: Text('edit'),
                  onPressed: () {
                    _selectTime(context);
                  },
                )
            ),
            Padding(
              padding: EdgeInsets.only( left: 40.0, right: 40.0),
              child:
              Text("Wakeup time: " + _wakeupTimeText, textAlign: TextAlign.center,)
            ),
            Padding(
                padding: EdgeInsets.only(left: 40.0, right: 40.0),
                child:
                TextButton(
                  child: Text('edit'),
                  onPressed: () {
                    _selectWakeTime(context);
                  },
                )
            ),
            Padding(
                padding: EdgeInsets.only(left: 40.0, right: 40.0),
                child:
                Text("Sleep quality", textAlign: TextAlign.center,)
            ),
            Padding(
              padding: EdgeInsets.only( left: 40.0, right: 40.0),
              child: _qualitySlider
            ),
            Padding(
              padding: EdgeInsets.only( top: 10),
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
              padding: EdgeInsets.only( top: 10),
              child: _recordDreamNotesView,
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
                // style: ElevatedButton.styleFrom(
                //     primary: Colors.blueAccent
                // ),
                child: Text('Save Sleep Details'),
                onPressed: _saveButtonPress,
              ),
            ),
          ]
        )

      ),
    );
  }
  _selectTime(BuildContext context) async {
    print("wtf");
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      initialEntryMode: TimePickerEntryMode.dial,

    );
    if(timeOfDay != null && timeOfDay != selectedTime)
    {
      setState(() {
        selectedTime = timeOfDay;
        _bedTimeText = selectedTime.format(context);
      });
    }
    print(selectedTime.format(context));
  }
  _selectWakeTime(BuildContext context) async {
    print("wtf");
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      initialEntryMode: TimePickerEntryMode.dial,

    );
    if(timeOfDay != null && timeOfDay != selectedTime)
    {
      setState(() {
        selectedTime = timeOfDay;
        _wakeupTimeText = selectedTime.format(context);
      });
    }
    print(selectedTime.format(context));
  }

}
