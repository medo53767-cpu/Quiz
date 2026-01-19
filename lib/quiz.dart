import 'package:flutter/material.dart';
import 'package:quiz/data/questions.dart';
import 'package:quiz/home.dart';
import 'package:quiz/question_screen.dart';
import 'package:quiz/result.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  List<String> selectedAnswers = [];
  Widget? activescreen;
  void chooseAnswer(String answer) {
    selectedAnswers.add(answer);
    if (selectedAnswers.length == questions.length) {
      setState(() {
        activescreen = Result(selectedAnswers,restart);
      });
    }
  }

  void restart() {
    selectedAnswers = [];
   setState(() {
      activescreen =  Home(switchscreen);
   });
  }

  @override
  void initState() {
    super.initState();
    activescreen = Home(switchscreen);
  }

  void switchscreen() {
    setState(() {
      activescreen = Questions(chooseAnswer);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.purpleAccent, Colors.pinkAccent],
            ),
          ),
          child: activescreen,
        ),
      ),
    );
  }
}
