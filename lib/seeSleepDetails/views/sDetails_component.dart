import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../views/sDetails_view.dart';
import '../presenter/sDetails_presenter.dart';
import '../../styles/theme1.dart';
import 'package:flutter/widgets.dart';
import '../utils/sDetails_times.dart';
import 'package:intl/intl.dart';
import '../../styles/CustomTextStyle.dart';


class SdetailsPage extends StatefulWidget {
  final SdetailsPresenter presenter;

  SdetailsPage(this.presenter, {required Key? key, required this.title}) : super(key: key);

  final String title;


  @override
  _SdetailsState createState() => _SdetailsState();
}

class _SdetailsState extends State<SdetailsPage> implements SdetailsView {

  var _bedTime = '';
  var _wakeupTime = '';
  var _sleepHours = '';
  var _sleepNotes = '';
  var _dreamNotes = '';
  var _weather = '';
  var _steps = '';
  var _recentDate = '';

  @override
  void initState(){
    super.initState();
    this.widget.presenter.detailsView = this;
    _seeDetailsPressed();
  }

  void _buttonPress() {
    this.widget.presenter.onButtonPressed();
  }

  void _seeDetailsPressed() {
    this.widget.presenter.onSeeSleepTimeClicked();
  }

  @override
  void updateRecentDate ({required String recentDate}){
    setState(() {
      _recentDate = recentDate;
    });
  }

  @override
  void updateSleepTime({required List<String> sleepTimeResult}){
    print("In Component:" + sleepTimeResult[0]);
    setState(() {
      _bedTime = sleepTimeResult[0];
      print("sleepTimeresult[0] in Component:" + sleepTimeResult[0]);
      print("_bedtime in Component:" + _bedTime);
      _wakeupTime = sleepTimeResult[1];
      _sleepHours = sleepTimeResult[2];
    });
  }

  @override
  void updateNotes({required List<String> sleepNotes, required List<String> dreamNotes}){
    for(var sn in sleepNotes){
      if(sn != null){
        _sleepNotes += sn + ". ";
      }
    }
    for(var dn in dreamNotes){
      if(dn != null){
        _dreamNotes += dn + ". ";
      }
    }

  }

  @override
  void updateOthers({required double weather, required int steps}){
    _weather = weather.toString() + ' F';
    _steps = steps.toString();
  }

  @override
  Widget build(BuildContext context) {
    var _recentDateText = Text(
      'Sleep details on ' + '$_recentDate',
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

    var _othersView = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          height: 30,
          width: 300,
          color: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              color: Color.fromRGBO(220, 237, 246, 1),
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
            ),
            // child: new Center(
            child:
            new Text("Others",
              style: CustomTextStyle.listText(context),
            ),
            // ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 20),
          child: Text(
            'Weather',
            style: CustomTextStyle.subTitle(context),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 20),
          child: Text(
            '$_weather',
            style: CustomTextStyle.contents(context),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 15),
          child: Text(
              'Steps',
              style: CustomTextStyle.subTitle(context)
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 15),
          child: Text(
              '$_steps',
              style: CustomTextStyle.contents(context)
          ),
        ),
      ],
    );


    return Scaffold(
      appBar: AppBar(
        title: Text("Sleep Details"),
      ),
      body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: _recentDateText,
              ),

              Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: _sleepTimeView,
              ),
              Padding(
                padding: EdgeInsets.only(top: 15),
                child: _notesView,
              ),
      ]),
    ));


  }


}