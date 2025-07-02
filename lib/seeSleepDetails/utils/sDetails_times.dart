class SdetailsTimes {
  String userID = "test1";
  String sleepTime = "";
  String wakeupTime = "";
  String sleepHours = "";
  List<String> sleepNotes = new List.filled(1, "", growable: true);
  List<String> dreamNotes = new List.filled(1, "", growable: true);

  List<dynamic> detailList = new List.filled(1, null, growable: true);

  void testCalc() {
    print(calculate("9:30", "PM", "6:15", "AM"));
  }

  String calculate(String sleeptime, String sleepTimeType, String waketime, String wakeTimeType){

    List<String> sleepTimeStrs = sleeptime.split(":");

    List<String> wakeTimeStrs = waketime.split(":");

    if (sleepTimeStrs[0].length == 1)
      sleepTimeStrs[0] = "0" + sleepTimeStrs[0];

    if (wakeTimeStrs[0].length == 1)
      wakeTimeStrs[0] = "0" + wakeTimeStrs[0];

    String day = "22";

    if (sleepTimeType == "PM") {
      int sleepInt = int.parse(sleepTimeStrs[0]) + 12;
      sleepTimeStrs[0] = sleepInt.toString();
    } else if (sleepTimeType == "AM")
      day = "23";

    if (wakeTimeType == "PM") {
      int wakeInt = int.parse(wakeTimeStrs[0]) + 12;
      wakeTimeStrs[0] = wakeInt.toString();
    }

    // var sleepTime = DateTime.parse("2021-05-" + day + " " + sleepTimeStrs[0] + ":" + sleepTimeStrs[1] + ":00");
    var sleepTime = DateTime.parse("2021-05-" + day + " " + sleepTimeStrs[0] + ":" + sleepTimeStrs[1]);
    //var wakeTime = DateTime.parse("2021-05-23 " + wakeTimeStrs[0] + ":" + wakeTimeStrs[1] + ":00");
    var wakeTime = DateTime.parse("2021-05-23 " + wakeTimeStrs[0] + ":" + wakeTimeStrs[1]);

    var elapsed = wakeTime.difference(sleepTime);

    int minutes = elapsed.inMinutes % 60;

    int hours = (elapsed.inMinutes / 60).truncate();

    return hours.toString() + ' hours and ' + minutes.toString() + " mins";

  }


}