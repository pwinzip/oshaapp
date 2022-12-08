import 'package:cloud_firestore/cloud_firestore.dart';
import 'result_model.dart';

class AssessmentModel {
  AssessmentModel({
    required this.uid,
    required this.assessmentDate,
    required this.room,
    required this.avgScore,
    required this.results,
  });

  String uid;
  DateTime assessmentDate;
  DocumentReference room;
  double avgScore;
  List<ResultModel> results;

  factory AssessmentModel.fromJson(Map<String, dynamic> json) =>
      AssessmentModel(
        uid: json["UID"],
        assessmentDate: json["assessment_date"],
        room: json["room"],
        avgScore: json["avg_score"],
        results: List<ResultModel>.from(
            json["results"].map((x) => ResultModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "UID": uid,
        "assessment_date": assessmentDate,
        "room": room,
        "avg_score": avgScore,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}
