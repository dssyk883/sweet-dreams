import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:units/alarm/presenter/snoozed_presenter.dart';
import '../views/alarm_view.dart';
import '../presenter/alarm_presenter.dart';
import '../../main.dart';
import 'package:flutter/src/material/time.dart';
import 'snoozed_component.dart';



class AlarmPage extends StatefulWidget {
  final AlarmPresenter presenter;

  AlarmPage(this.presenter, {required Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _AlarmPageState createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage> implements AlarmView {

  TimeOfDay selectedTime = TimeOfDay.now();

  @override
  void initState() {
    super.initState();
    this.widget.presenter.alarmView = this;
  }

  @override
  Widget build(BuildContext context) {
    //_text = widget._text;
    return Scaffold(
      appBar: AppBar(
        title: Text("Daily Alarm"),
      ),
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  // Stroked text as border.
                  Text(
                    'Set Alarm',
                    style: TextStyle(
                      fontSize: 60,
                      foreground: Paint()
                        ..style = PaintingStyle.stroke
                        ..strokeWidth = 6
                        ..color = Colors.blue[700]!,
                    ),
                  ),
                  // Solid text as fill.
                  Text(
                    'Set Alarm',
                    style: TextStyle(
                      fontSize: 60,
                      color: Colors.grey[300],
                    ),
                  ),
                ],
              ),
              // Padding(
              //   padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
              //   child: Text(_text,style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blueAccent), ),
              // ),
              Padding(
                padding: EdgeInsets.only(top: 30.0),
                child: ElevatedButton(
                  onPressed: () {
                    _selectTime(context);
                  },
                  child: Text("Choose Time"),
                ),
              ),
              // Padding(
              //   padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
              //   child: Text(_text,style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blueAccent), ),
              // ),
              Padding(
                padding: EdgeInsets.only(top: 30.0),
                child: Text(
                    "Current time is ${selectedTime.hour}:${selectedTime.minute}",
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blueAccent
                    ))
              ),


            ],
          )
      ),
    );
  }

  _selectTime(BuildContext context) async {
    notificationSelected = false;
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      initialEntryMode: TimePickerEntryMode.dial,

    );
    if(timeOfDay != null && timeOfDay != selectedTime)
    {
      setState(() {
        selectedTime = timeOfDay;
      });
      this.widget.presenter.saveInAlarmList(timeOfDay);
    }
    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)
    {
      return SnoozedRoute();
    }));
  }
}

class SnoozedRoute extends StatefulWidget {
  @override
  _SnoozedRoute createState() => _SnoozedRoute();
}

class _SnoozedRoute extends State<SnoozedRoute> {
  @override
  Widget build(BuildContext context) {
    return new SnoozedPage(
      new BasicSnoozedPresenter(), title: 'Alarm snoozed', key: Key("Snoozed"),);
  }
}
