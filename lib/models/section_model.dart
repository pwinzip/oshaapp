import 'package:cloud_firestore/cloud_firestore.dart';

class SectionModel {
  String title;
  String sectionName;
  List<DocumentReference> questions;

  SectionModel({
    required this.title,
    required this.sectionName,
    required this.questions,
  });

  factory SectionModel.fromJson(Map<String, dynamic> json) => SectionModel(
        title: json["title"],
        sectionName: json["section_name"],
        questions:
            List<DocumentReference>.from(json["questions"].map((x) => x)),
      );

  factory SectionModel.fromSnapshot(DocumentSnapshot snapshot) {
    final newsection =
        SectionModel.fromJson(snapshot.data() as Map<String, dynamic>);
    return newsection;
  }

  Map<String, dynamic> toJson() => {
        "title": title,
        "section_Name": sectionName,
        "questions": List<dynamic>.from(questions.map((x) => x)),
      };
}
