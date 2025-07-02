import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:multi_select_flutter/bottom_sheet/multi_select_bottom_sheet_field.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';
import 'package:units/alarm/presenter/snoozed_presenter.dart';
import 'package:units/styles/theme1.dart';
import 'snoozed_view.dart';
import '../../main.dart';
import '../../noteLists/noteLists.dart';


class SnoozedPage extends StatefulWidget {
  final SnoozedPresenter presenter;

  SnoozedPage(this.presenter, {required Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _SnoozedPage createState() => _SnoozedPage();
}

class _SnoozedPage extends State<SnoozedPage> implements SnoozedView{

  DateTime sleepDate = DateTime.now();
  var dateFormat = DateFormat('MM.dd.yyyy');
  var dateTimeFormat = DateFormat('MM.dd.yyyy, hh:mm a');
  String sleepDateString = '';
  String wakeupTime = '';
  double _currentSliderValue = 0;


  NoteLists _notelist = new NoteLists();
  List<String> dreamNotesToString = [];

  var _noneSelected = "None selected";
  List<OneDreamNote> _selectedDreamNotes = [];
  List<MultiSelectItem<OneDreamNote>> _dreamNoteItems = [];

  @override
  void initState() {
    super.initState();
    this.widget.presenter.snoozedView = this;
    _dreamNoteItems = _notelist.DreamNotes
        .map((aDreamNote) => MultiSelectItem<OneDreamNote>(aDreamNote, aDreamNote.note))
        .toList();
    this.widget.presenter.loadDetailsOnDate(dateFormat.format(sleepDate));
  }

  void _saveButtonPress() {
    print(_selectedDreamNotes);
    this.widget.presenter.saveButtonPressed(wakeupTime, _currentSliderValue.toString(), _selectedDreamNotes);
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
          title: Text("Record Sleep"),
        ),
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Visibility(
                      child: Padding(
                          padding: EdgeInsets.only(top: 20.0),
                          child:
                          ElevatedButton(
                              style: majorTheme.elevatedButtonTheme.style,
                              child: Text('SNOOZE'),
                              onPressed: () {
                                setState(() {
                                  notificationSelected = true;
                                });
                                wakeupTime = dateTimeFormat.format(SnoozedWakeupTime!);
                                sleepDate = SnoozedWakeupTime!.subtract(Duration(days: 1));
                                sleepDateString = dateFormat.format(sleepDate);
                              })),
                      visible: !notificationSelected),
                  Visibility(
                    child: Padding(
                      padding: EdgeInsets.only( top: 10),
                      child: _recordDreamNotesView,
                    ),
                    visible: notificationSelected,
                  ),
                  Visibility(
                      child: Container(
                          padding: EdgeInsets.all(10),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '$_noneSelected',
                            style: TextStyle(color: Colors.black54),
                          )),
                      visible: notificationSelected),
                  Visibility(
                      child: Padding(
                          padding: EdgeInsets.only(left: 40.0, right: 40.0),
                          child:
                          Text("Sleep quality", textAlign: TextAlign.center,)
                      ),
                      visible: notificationSelected),
                  Visibility(
                      child: Padding(
                          padding: EdgeInsets.only( left: 40.0, right: 40.0),
                          child: _qualitySlider
                      ),
                      visible: notificationSelected),
                  Visibility(
                      child: Padding(
                          padding: EdgeInsets.only(top: 20.0),
                          child:
                          ElevatedButton(
                            style: majorTheme.elevatedButtonTheme.style,
                            // style: ElevatedButton.styleFrom(
                            //     primary: Colors.blueAccent
                            // ),
                            child: Text('Save Sleep Details'),
                            onPressed: () {
                              _saveButtonPress();
                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                              },
                          )),
                      visible: notificationSelected),
                    ],
                    ),
                  ),
            );
  }
}