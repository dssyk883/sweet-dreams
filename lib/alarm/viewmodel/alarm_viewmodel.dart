class AlarmViewModel {
  List<DateTime> _alarmList = [];
  String _alarmText = "";

  List<DateTime> get alarmList => _alarmList;
  String get alarmText => _alarmText;
  set alarmText(String inputText){
    _alarmText = inputText;
  }

}

