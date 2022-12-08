import 'package:cloud_firestore/cloud_firestore.dart';

class RoomModel {
  String room;
  String institution;
  List<DocumentReference> results = [];

  RoomModel({
    required this.room,
    required this.institution,
    required this.results,
  });

  factory RoomModel.fromJson(Map<String, dynamic> json) => RoomModel(
        room: json["room"],
        institution: json["institution"],
        results: List<DocumentReference>.from(json["results"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "room": room,
        "institution": institution,
        "results": List<dynamic>.from(results.map((x) => x)),
      };
}
