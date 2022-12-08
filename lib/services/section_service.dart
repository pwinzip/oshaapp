import 'package:cloud_firestore/cloud_firestore.dart';

class SectionService {
  final CollectionReference sectionCollection =
      FirebaseFirestore.instance.collection("Sections");

  Future<QuerySnapshot> getSection() {
    return sectionCollection.get();
  }

  Stream<QuerySnapshot> getSectionStream() {
    return sectionCollection.snapshots();
  }
}
