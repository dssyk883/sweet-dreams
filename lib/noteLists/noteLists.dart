
class NoteLists {

  List<OneSleepNote> _sleepNotes = [
    OneSleepNote(0, "Ate late"),
    OneSleepNote(1, "Worked out"),
    OneSleepNote(2, "Alcohol"),
    OneSleepNote(3, "Stressful"),
    OneSleepNote(4, "Good day"),
    OneSleepNote(5, "Nap"),
    OneSleepNote(6, "Coffee"),
  ];

  List<OneDreamNote> _dreamNotes = [
    OneDreamNote(0, "No dreams"),
    OneDreamNote(1, "Can't remember at all"),
    OneDreamNote(2, "Nightmare"),
    OneDreamNote(3, "Sweet dream"),
    OneDreamNote(4, "Lucid dream"),
    OneDreamNote(5, "Vivid dream"),
  ];

  List<OneSleepNote> get SleepNotes => _sleepNotes;
  List<OneDreamNote> get DreamNotes => _dreamNotes;
  set SleepNotes(List<OneSleepNote> newSleepNotes){
    _sleepNotes = newSleepNotes;
  }
  set DreamNotes(List<OneDreamNote> newDreamNotes){
    _dreamNotes = newDreamNotes;
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

class OneDreamNote {
  int index = 0;
  String note = "";
  OneDreamNote(int index, String note){
    this.index = index;
    this.note = note;
  }
}