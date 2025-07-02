
class SdetailsViewModel {
  int _bedHour = 0;
  int _bedMinute = 0;
  int _wakeHour = 0;
  int _wakeMinute = 0;
  int _sleepHours = 0;

  int get bedHour => _bedHour;
  set bedHour(int bedhour){
    _bedHour = bedhour;
  }

  int get bedMinute => _bedMinute;
  set bedMinute(int bedMinute){
    _bedMinute = bedMinute;
  }

  int get wakeHour => _wakeHour;
  set wakeHour(int wakeHour){
    _wakeHour = wakeHour;
  }

  int get wakeMinute => _wakeMinute;
  set wakeMinute(int wakeMinute){
    _wakeMinute = wakeMinute;
  }

  int get sleepHours => _sleepHours;
  set sleeHours(int sleepHours){
    _sleepHours = sleepHours;
  }

  String getWakeTime(){
    return _wakeHour.toString() + ":" + _wakeMinute.toString();
  }

  String get bedTimeInString => _bedHour.toString() + ":" + _bedMinute.toString();
  String get wakeTimeInString => _wakeHour.toString() + ":" + _wakeMinute.toString();
  String get SleepHours => _sleepHours.toString();
}