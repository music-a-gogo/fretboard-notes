class NoteButton {
  /*
  noteButtonText will can contains a forward slash
  For example:
  "G#/Ab"
   */
  String noteButtonText = "";
  /*
   intervalWithC is the semitone distance between it and a lower C note
   For example:
   Note C's intervalWithC is 0
   Note D's intervalWithC is 2
   Note B's intervalWithC is 11
   */
  int intervalWithC = 0;

  // constructor
  NoteButton(String n, int i) {
    noteButtonText = n;
    intervalWithC = i;
  }
}
