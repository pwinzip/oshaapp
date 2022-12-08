import 'package:cloud_firestore/cloud_firestore.dart';

class QuestionAnswer {
  QuestionAnswer({
    required this.questionDocid,
    required this.answer,
  });

  DocumentReference questionDocid;
  bool answer;

  factory QuestionAnswer.fromJson(Map<String, dynamic> json) => QuestionAnswer(
        questionDocid: json["question_docid"],
        answer: json["answer"],
      );

  Map<String, dynamic> toJson() => {
        "question_docid": questionDocid,
        "answer": answer,
      };
}
