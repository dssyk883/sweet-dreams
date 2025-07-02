import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../presenter/stats_presenter.dart';
import '../viewmodel/stats_viewmodel.dart';
import '../views/stats_view.dart';
import '../views/chart.dart';
import 'package:charts_flutter/flutter.dart' as charts;


class StatsPage extends StatefulWidget {
  final StatsPresenter presenter;

  StatsPage(this.presenter, {required Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _StatsPageState createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> implements StatsView {
  String _text = "";
  List _theGoods = [];

  @override
  void initState() {
    super.initState();
    this.widget.presenter.statsView = this;
  }

  @override
  void updateText(String text){
    setState(() {
      _text = text;
    });
  }


  @override
  void updateStats(List theGoods){
    setState(() {
      _theGoods = theGoods;
      //_theGoods = [];
    });
  }

  void _buttonPress() {
    this.widget.presenter.onButtonPressed();
  }

  @override
  Widget build(BuildContext context) {
    //_text = widget._text;
    return Scaffold(
      appBar: AppBar(
        title: Text("Stats Page"),
      ),
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                  width: 400.0,
                  height: 200.0,
                  child: SimpleBarChart.withTheGoods(_theGoods, "Sleep Notes")
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: Text("Sleep Notes"),
              ),
              SizedBox(
                  width: 400.0,
                  height: 200.0,
                  child: SimpleBarChart.withTheGoods(_theGoods, "Dream Notes")
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: Text("Dream Notes"),
              ),
            ],
          )
      ),
    );
  }
}
