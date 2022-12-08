import 'package:cloud_firestore/cloud_firestore.dart';

import 'questionanswer_model.dart';

class ResultModel {
  ResultModel({
    required this.sectionId,
    required this.score,
    required this.questionAnswer,
  });

  DocumentReference sectionId;
  double score;
  List<QuestionAnswer> questionAnswer;

  factory ResultModel.fromJson(Map<String, dynamic> json) => ResultModel(
        sectionId: json["section_id"],
        score: json["score"],
        questionAnswer: List<QuestionAnswer>.from(
            json["question_answer"].map((x) => QuestionAnswer.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "section_id": sectionId,
        "score": score,
        "question_answer":
            List<dynamic>.from(questionAnswer.map((x) => x.toJson())),
      };
}
