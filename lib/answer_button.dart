import 'package:flutter/material.dart';

class AnswerButton extends StatelessWidget {
  const AnswerButton(this.answerText, this.onPressed, {super.key});
  final String answerText;
  final void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      
      
      style: ElevatedButton.styleFrom(
        foregroundColor:Colors.white,
        backgroundColor: Colors.blueGrey.withOpacity(0),
        padding: EdgeInsets.all(17),
        
      ),
      onPressed: onPressed,
      child: Text(answerText,textAlign: TextAlign.center,));
  }
}
