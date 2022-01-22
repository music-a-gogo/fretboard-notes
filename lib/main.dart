import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(Quizzler());
}

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        // appBar: AppBar(key: "s"),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Answer(),
        ),
      ),
    );
  }
}

class Answer extends StatefulWidget {
  const Answer({Key? key}) : super(key: key);

  @override
  _AnswerState createState() => _AnswerState();
}

class _AnswerState extends State<Answer> {
  Text Question = Text("");
  int QuestionString = 0;
  int QuestionFret = 0;
  // Name of the String, E A D G B E
  // int StringNo = 1;
  List<int> StringNos = [1, 2, 3, 4, 5, 6];
  // FretNum
  // int FretNum = 1;
  List<int> FretNums = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];
  // Show Right or Wrong Area
  Widget Result = Text("");
  // StartButton Visualbility
  bool startButtonVisible = true;

  // Show you are right or wrong
  void showRightOrWrong(bool b) => (b) {
        if (b == true) {
          setState(() {
            Result = const Text(
              "✅ Congratulations! You are Correct",
              style: TextStyle(color: Colors.teal),
            );
          });
        } else {
          setState(() {
            Result = const Text(
              "❌ Sorry, Try Again",
              style: TextStyle(color: Colors.red),
            );
          });
        }
        ;
      }(b);

  // Calculate the right answer
  int getRightAnswer(int n, int f) => (n, f) {
        var start = 0;
        switch (n) {
          case 1:
            {
              // E string
              start = 4;
            }
            break;
          case 2:
            {
              // B string
              start = 11;
            }
            break;
          case 3:
            {
              // G string
              start = 7;
            }
            break;
          case 4:
            {
              // D string
              start = 2;
            }
            break;
          case 5:
            {
              // A string
              start = 9;
            }
            break;
          case 6:
            {
              // E string
              start = 4;
            }
            break;
        }
        return ((start + f) % 12).toInt();
      }(n, f);

  // Generate New Question
  int getNewStringNo() => () {
        int r = Random().nextInt(StringNos.length);
        return StringNos.elementAt(r);
      }();
  int getNewFreNo() => () {
        int r = Random().nextInt(FretNums.length);
        return FretNums.elementAt(r);
      }();
  Text combineQuestion(int s, int f) => (s, f) {
        String questionText = "$s String $f Fret";
        return Text(
          questionText,
          style: const TextStyle(
            color: Colors.teal,
            fontWeight: FontWeight.bold,
            fontSize: 40,
          ),
        );
      }(s, f);
  void NewQuestion() => () {
        setState(() {
          QuestionString = getNewStringNo();
          QuestionFret = getNewFreNo();
          Question = combineQuestion(QuestionString, QuestionFret);
        });
      }();
  // Check Answer
  bool checkAnswer(int yourAnswer, int stringNo, int fretNum) => (yourAnswer) {
        return yourAnswer == getRightAnswer(stringNo, fretNum);
      }(yourAnswer);
  // Answer Box
  OutlinedButton makeButton(String name, int distance) => (name, distance) {
        return OutlinedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.teal),
            fixedSize: MaterialStateProperty.all(
              const Size.fromWidth(1),
            ),
          ),
          onPressed: () {
            bool res = checkAnswer(distance, QuestionString, QuestionFret);

            if (res) {
              NewQuestion();
              showRightOrWrong(true);
            } else {
              showRightOrWrong(false);
            }
            ;
          },
          child: Text(
            name,
            style: const TextStyle(
              color: Colors.white70,
              fontWeight: FontWeight.w600,
            ),
          ),
        );
      }(name, distance);

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      // Question Area
      Question,
      // some space here
      SizedBox(
        height: 100,
      ),
      // Answer Buttons
      // Row1: C C# D D# E F
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          makeButton("C", 0),
          makeButton("C#/Db", 1),
          makeButton("D", 2),
          makeButton("D#/Eb", 3),
          makeButton("E", 4),
          makeButton("F", 5),
        ],
      ),
      // Row2: F# G G# A A# B
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          makeButton("F#/Gb", 6),
          makeButton("G", 7),
          makeButton("G#/Ab", 8),
          makeButton("A", 9),
          makeButton("A#/Bb", 10),
          makeButton("B", 11),
        ],
      ),
      SizedBox(
        height: 10,
      ),
      Result,
      // Start Button
      Visibility(
        visible: startButtonVisible,
        child: TextButton(
            onPressed: () {
              NewQuestion();
              startButtonVisible = false;
            },
            child: const Text("Start")),
      )
    ]);
  }
}
