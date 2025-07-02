import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../views/test_view.dart';
import '../presenter/test_presenter.dart';

class TestPage extends StatefulWidget {
  final TestPresenter presenter;

  TestPage(this.presenter, {required Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> implements TestView {

  String _text = "updateText still isn't working";

  @override
  void initState() {
    super.initState();
    this.widget.presenter.testView = this;
  }

  @override
  void updateText(String text){
    print("calling updateText");
    setState(() {
      _text = text;
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
        title: Text("TestPage"),
      ),
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.blueAccent
                ),
                child: Text('TestButton'),
                onPressed: _buttonPress,
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: Text(_text,style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blueAccent), ),
              ),
            ],
          )
      ),
    );
  }
}
