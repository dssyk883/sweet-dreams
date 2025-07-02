
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:units/setSleepDetails/presenter/set_details_presenter.dart';
import 'package:units/setSleepDetails/views/set_details_component.dart';
import 'package:units/styles/theme1.dart';
import '../presenter/calendarSleepDetails_presenter.dart';
import 'calendarSleepDetails_view.dart';
import '../../styles/CustomTextStyle.dart';

class calendarSleepDetailsPage extends StatefulWidget {
  final calendarSleepDetailsPresenter presenter;

  calendarSleepDetailsPage(this.presenter, {required Key? key, required this.title}) : super(key: key);

  final String title;


  @override
  _calendarSleepDetailsState createState() => _calendarSleepDetailsState();

  }
DateTime? _selectedDay;
var dateFormat = DateFormat('MM.dd.yyyy');

class _calendarSleepDetailsState extends State<calendarSleepDetailsPage> implements calendarSleepDetailsView{

  DateTime _focusedDay = DateTime.now();

  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _firstDay = DateTime.now();
  DateTime _lastDay = DateTime.now();
  String _selectedDayString = '';
  String _wakeupTime = '';
  String _bedTime = '';
  String _sleepHours = '';
  String _sleepNotes = '';
  String _dreamNotes = '';
  final ScrollController _Controller = ScrollController();


  @override
  void updatetimeDetailsOnDate(List<String> timeDetails){
    print("updateTimeDetailsonDate: ");
    print(timeDetails);
    setState(() {
      _bedTime = timeDetails[0];
      _wakeupTime = timeDetails[1];
      _sleepHours = timeDetails[2];
    });
  }

  @override
  void updateNotes({required List<String> sleepNotes, required List<String> dreamNotes}){
    print("updateNotes: ");
    print(sleepNotes);
    String tempSnotes = '';
    String tempDnotes = '';
    for(var sn in sleepNotes){
      if(sn != null){
        tempSnotes += sn + ". ";
      }
    }
    for(var dn in dreamNotes){
      if(dn != null){
        tempDnotes += dn + ". ";
      }
    }
    setState(() {
      _sleepNotes = tempSnotes;
      _dreamNotes = tempDnotes;
    });
  }

  void passSelectedDate(DateTime selectedDay){
    String selectedDateString = dateFormat.format(selectedDay);
    print("passSelectedDate: " + selectedDateString);
    setState(() {
      _selectedDayString = selectedDateString;
    });
    this.widget.presenter.onDateClicked(selectedDateString);
  }



  @override
  void initState() {
    super.initState();
    this.widget.presenter.calendarView = this;
    _focusedDay = DateTime.now();
    _firstDay = _focusedDay.subtract(const Duration(days: 30));
    _lastDay = _focusedDay.add(const Duration(days: 30));
  }

  @override
  Widget build(BuildContext context) {
    var _dateText = Text(
      'Sleep details on ' + '$_selectedDayString',
      style: CustomTextStyle.subTitle(context),
    );

    var _sleepTimeView = Column(
      //mainAxisAlignment: MainAxisAlignment.center,
      //crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          height: 30,
          width: 350,
          color: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              color: Color.fromRGBO(220, 237, 246, 1),
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
            ),
            // child: new Center(
            child:
            new Text("Sleep time details",
              style: CustomTextStyle.listText(context),
            ),
            // ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10),
          child: Text(
            "You slept at ",
            style: CustomTextStyle.contents(context),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10),
          child: Text(
            '$_bedTime',
            style: CustomTextStyle.boldContents(context),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 15),
          child: Text(
            "Woke up at ",
            style: CustomTextStyle.contents(context),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10),
          child: Text(
              '$_wakeupTime',
              style: CustomTextStyle.boldContents(context)
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 15),
          child: Text(
            "You slept for ",
            style: CustomTextStyle.contents(context),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10),
          child: Text(
              '$_sleepHours',
              style: CustomTextStyle.boldContents(context)
          ),
        ),
      ],
    );

    var _notesView = Column(
      //mainAxisAlignment: MainAxisAlignment.center,
      //crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          height: 30,
          width: 350,
          color: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              color: Color.fromRGBO(220, 237, 246, 1),
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
            ),
            // child: new Center(
            child:
            new Text("Notes",
              style: CustomTextStyle.listText(context),
            ),
            // ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 20),
          child: Text(
            'Sleep Notes',
            style: CustomTextStyle.subTitle(context),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 20),
          child: Text(
            '$_sleepNotes',
            style: CustomTextStyle.contents(context),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 15),
          child: Text(
              'Dream Notes',
              style: CustomTextStyle.subTitle(context)
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 15),
          child: Text(
              '$_dreamNotes',
              style: CustomTextStyle.contents(context)
          ),
        ),
      ],
    );

    var _calendar = TableCalendar(
      focusedDay: _focusedDay,
      firstDay: _firstDay,
      lastDay: _lastDay,
      calendarFormat: _calendarFormat,
      selectedDayPredicate: (day) {
        return isSameDay(_selectedDay, day);
      },
      onDaySelected: (selectedDay, focusedDay) {
        if (!isSameDay(_selectedDay, selectedDay)) {
          print(selectedDay);
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay;
            passSelectedDate(selectedDay);
          });
        }
      }, //onDaySelected
    );

    var _editDetailsButton = Padding(
      padding: EdgeInsets.only(top: 20.0),
      child:
      ElevatedButton(
        style: majorTheme.elevatedButtonTheme.style,
        // style: ElevatedButton.styleFrom(
        //     primary: Colors.blueAccent
        // ),
        child: Text('Edit details on this date'),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
            return SetDetailsRoute();
          }));
        },
      ),
    );

    var _allDetailsView = ListView(
      controller: _Controller,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      padding: EdgeInsets.only(bottom: 20),
      children: <Widget>[
        Container(
          child: _calendar,
        ),
        Container(
          alignment: Alignment.center,
          child: _dateText,
        ),
        Container(
          child: _sleepTimeView,
        ),
        Container(
          child: _notesView,
        ),
        Container(
          child: _editDetailsButton,
        ),
      ],
    );

    return Scaffold(
        appBar: AppBar(
          title: Text("Calendar"),
        ),
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                      child: _allDetailsView,
                      ),
                ]
            )
        )
    );
  }
}


class SetDetailsRoute extends StatefulWidget {
  @override
  _SetDetailsRoute createState() => _SetDetailsRoute();
}

class _SetDetailsRoute extends State<SetDetailsRoute> {
  String DateToString(DateTime? onDate){
    String dateString = "None";

    if(onDate != null){
      dateString = dateFormat.format(onDate);
    }
    print("_SetDetailsRoute: " + dateString);
    return dateString;
  }


  @override
  Widget build(BuildContext context) {
    return new SetDetailsPage(
        new BasicSetDetailsPresenter(), title: 'Testing', key: Key("Test"), date: DateToString(_selectedDay));
  }
}