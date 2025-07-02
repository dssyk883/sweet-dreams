import 'package:flutter/material.dart';
import 'package:units/seeSleepDetails/viewmodel/recordSleepnotes_viewmodel.dart';

import 'seeSleepDetails/views/sDetails_component.dart';
import 'seeSleepDetails/presenter/sDetails_presenter.dart';
import 'seeSleepDetails/presenter/recordSleepnotes_presenter.dart';
import 'seeSleepDetails/views/recordSleepnotes_component.dart';
import 'stats/views/stats_component.dart';
import 'stats/presenter/stats_presenter.dart';
import 'alarm/presenter/alarm_presenter.dart';
import 'alarm/views/alarm_component.dart';
import 'seeSleepDetails/presenter/calendarSleepDetails_presenter.dart';
import 'seeSleepDetails/views/calendarSleepDetails_component.dart';

import 'setSleepDetails/views/set_details_component.dart';
import 'setSleepDetails/presenter/set_details_presenter.dart';
import 'styles/theme1.dart';


class mainTestPage extends StatefulWidget {

  mainTestPage({required Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _mainTestPage createState() => _mainTestPage();
}

class _mainTestPage extends State<mainTestPage> {



  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    //_text = widget._text;
    return Scaffold(
      appBar: AppBar(
        title: Text("Sweet Dreams !"),
      ),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
        const DrawerHeader(
        decoration: BoxDecoration(
          color: Color.fromRGBO(220, 237, 246, 1),
        ),
        child: Text("Other Menu",
        style: TextStyle(fontSize: 20)),
      ),
            ListTile(
              title: const Text('Statistics'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                  return StatsRoute();
                }));
              },
            ),
            ListTile(
              title: const Text('Edit sleep details'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                  return SetDetailsRoute();
                }));
              },
            ),
            ListTile(
              title: const Text('See details in Calendar'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                  return CalendarRoute();
                }));
              },
            ),
            ListTile(
              title: const Text('Recent sleep details'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                  return SdetailsRoute();
                }));
              },
            ),
          ],
    )),
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 20.0),
                child:
                ElevatedButton(
                  style: majorTheme.elevatedButtonTheme.style,
                  // style: ElevatedButton.styleFrom(
                  //     primary: Colors.blueAccent
                  // ),
                  child: Text('Sleep'),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                      return SleepRoute();
                    }));
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.0),
                child:
                ElevatedButton(
                  style: majorTheme.elevatedButtonTheme.style,
                  // style: ElevatedButton.styleFrom(
                  //     primary: Colors.blueAccent
                  // ),
                  child: Text('Alarm'),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                      return AlarmRoute();
                    }));
                  },
                ),
              ),
            ],
          )
      ),
    );
  }
}

class SleepRoute extends StatefulWidget {
  @override
  _SleepRoute createState() => _SleepRoute();
}

class _SleepRoute extends State<SleepRoute>{
  @override
  Widget build(BuildContext context) {
    return new recordSleepnotesPage(
      new BasicRecordSleepnotesPresenter(), title: 'Sleep and Record', key: Key("Sleep"),);
  }
}

class CalendarRoute extends StatefulWidget {
  @override
  _CalendarRoute createState() => _CalendarRoute();
}

class _CalendarRoute extends State<CalendarRoute>{
  @override
  Widget build(BuildContext context) {
    return new calendarSleepDetailsPage(
      new BasicCalendarSleepnotesPresenter(), title: 'Calendar Sleep Details', key: Key("Calendar"),);
  }
}

class SdetailsRoute extends StatefulWidget {
  @override
  _SdetailsRoute createState() => _SdetailsRoute();
}

class _SdetailsRoute extends State<SdetailsRoute> {
  @override
  Widget build(BuildContext context) {
    return new SdetailsPage(
      new BasicSdetailsPresenter(), title: 'Most recent details', key: Key("Sleep Details"),);
  }
}

class SetDetailsRoute extends StatefulWidget {
  @override
  _SetDetailsRoute createState() => _SetDetailsRoute();
}

class _SetDetailsRoute extends State<SetDetailsRoute> {
  @override
  Widget build(BuildContext context) {
    return new SetDetailsPage(
      new BasicSetDetailsPresenter(), title: 'Testing', key: Key("Test"), date: "None");
  }
}

class StatsRoute extends StatefulWidget {
  @override
  _StatsRoute createState() => _StatsRoute();
}

class _StatsRoute extends State<StatsRoute> {
  @override
  Widget build(BuildContext context) {
    return new StatsPage(
      new BasicStatsPresenter(), title: 'Stats', key: Key("Stats"),);
  }
}

class AlarmRoute extends StatefulWidget {
  @override
  _AlarmRoute createState() => _AlarmRoute();
}

class _AlarmRoute extends State<AlarmRoute> {
  @override
  Widget build(BuildContext context) {
    return new AlarmPage(
      new BasicAlarmPresenter(), title: 'Testing', key: Key("Test"),);
  }
}
