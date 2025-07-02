
class SetDetailsViewModel {

  List<OneSleepNote> _sleepNotes = [
    OneSleepNote(0, "Ate late"),
    OneSleepNote(1, "Worked out"),
    OneSleepNote(2, "Alcohol"),
    OneSleepNote(3, "Stressful"),
    OneSleepNote(4, "Good day"),
    OneSleepNote(5, "Nap"),
    OneSleepNote(6, "Coffee"),
  ];

  List<OneSleepNote> get SleepNotes => _sleepNotes;
  set SleepNotes(List<OneSleepNote> newSleepNotes){
    _sleepNotes = newSleepNotes;
  }
}

class OneSleepNote {
  int index = 0;
  String note = "";

  OneSleepNote(int index, String note){
    this.index = index;
    this.note = note;
  }
}

