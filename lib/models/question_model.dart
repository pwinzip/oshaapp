import 'package:cloud_firestore/cloud_firestore.dart';

class Question {
  String description;
  String suggestText;
  String? suggestImgUrl;
  String questionNo;
  DocumentReference sectionDocId;

  Question({
    required this.description,
    required this.suggestText,
    this.suggestImgUrl,
    required this.questionNo,
    required this.sectionDocId,
  });

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        description: json["description"],
        suggestText: json["suggest_text"],
        suggestImgUrl: json["suggest_imgUrl"],
        questionNo: json["question_no"],
        sectionDocId: json["section_docid"],
      );

  Map<String, dynamic> toJson() => {
        "description": description,
        "suggest_text": suggestText,
        "suggest_imgUrl": suggestImgUrl,
        "question_no": questionNo,
        "section_docid": sectionDocId,
      };
}
