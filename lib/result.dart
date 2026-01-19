import 'package:flutter/material.dart';
import 'package:quiz/data/questions.dart';

class Result extends StatefulWidget {
  const Result(this.selectedAnswers, this.restart, {super.key});
  final void Function() restart;
  final List<String> selectedAnswers;

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> with SingleTickerProviderStateMixin {
  late final List<Map<String, Object>> summaryData;

  @override
  void initState() {
    super.initState();
    summaryData = getSummaryData();
  }

  List<Map<String, Object>> getSummaryData() {
    final List<Map<String, Object>> summary = [];
    for (var i = 0; i < widget.selectedAnswers.length; i++) {
      summary.add({
        'question_index': i,
        'question': questions[i].text,
        'correct_answer': questions[i].answer[0],
        'user_answer': widget.selectedAnswers[i],
      });
    }
    return summary;
  }

  @override
  Widget build(BuildContext context) {
    final numCorrect = summaryData
        .where((e) => e['user_answer'] == e['correct_answer'])
        .length;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Text(
              'You answered $numCorrect out of ${questions.length} correctly!',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 18),

            
            ...summaryData.asMap().entries.map((entry) {
              final index = entry.key;
              final e = entry.value;

              return TweenAnimationBuilder(
                tween: Tween<Offset>(
                  begin: const Offset(1, 0), 
                  end: Offset.zero,
                ),
                duration: Duration(milliseconds: 300 + index * 100),
                curve: Curves.easeOut,
                builder: (context, Offset offset, child) {
                  return Transform.translate(
                    offset: Offset(offset.dx * 200, 0),
                    child: Opacity(
                      opacity: 1.0 - offset.dx.abs(),
                      child: child,
                    ),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: e['user_answer'] == e['correct_answer']
                          ? [Colors.blueAccent, Colors.lightBlueAccent]
                          : [Colors.redAccent, Colors.orangeAccent],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 6,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 16,
                          child: Text(
                            ((e['question_index'] as int) + 1).toString(),
                            style: TextStyle(
                              color: e['user_answer'] == e['correct_answer']
                                  ? Colors.blueAccent
                                  : Colors.redAccent,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                e['question'].toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  const Icon(Icons.check_circle, color: Colors.white, size: 16),
                                  const SizedBox(width: 4),
                                  Text(
                                    e['correct_answer'].toString(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(
                                    e['user_answer'] == e['correct_answer']
                                        ? Icons.check_circle
                                        : Icons.cancel,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    e['user_answer'].toString(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),

            const SizedBox(height: 20),
            OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.white),
              ),
              onPressed: widget.restart ,
              icon: const Icon(Icons.restart_alt_outlined, color: Colors.white),
              label: const Text('Restart Quiz', style: TextStyle(color: Colors.white)),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
