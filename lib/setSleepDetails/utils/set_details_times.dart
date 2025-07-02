class SetDetailsTimes {
  String userID = "test1";
  String sleepTime = "";
  String wakeupTime = "";
  String sleepHours = "";
  String sleepQuality = "";
  List<String> sleepNotes = new List.filled(1, "", growable: true);
  List<String> dreamNotes = new List.filled(1, "", growable: true);

  List<dynamic> detailList = new List.filled(1, null, growable: true);


  List<dynamic> calculator (int bedHour, int bedMinute, int wakeHour, int wakeMinute){
    List result = new List.filled(3, null, growable: false);
    //Do calculation
    result[0] = sleepTime;
    result[1] = wakeupTime;
    result[2] = sleepHours;
    result[3] = sleepQuality;
    return result;
  }

}