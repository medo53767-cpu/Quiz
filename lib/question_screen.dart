import 'package:flutter/material.dart';
import 'package:quiz/answer_button.dart';
import 'package:quiz/data/questions.dart';

class Questions extends StatefulWidget {
  const Questions(this.onselectanswer, {super.key});
    final void Function(String) onselectanswer;

  @override
  State<Questions> createState() => _QuestionsState();
}

class _QuestionsState extends State<Questions> {
  var currentquestionindax = 0;

  void answerquestion(String answer) {
    setState(() {
      widget.onselectanswer(answer);
      currentquestionindax = currentquestionindax + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    final curentquestion = questions[currentquestionindax];
    return Container(
      padding: EdgeInsets.all(10),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            curentquestion.text,
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 35),

          ...curentquestion.getSuffledAnswers().map((e) {
            return Container(
              margin: EdgeInsets.all(8),
              child: AnswerButton(e, ()=> answerquestion(e)),
            );
          }),
        ],
      ),
    );
  }
}
