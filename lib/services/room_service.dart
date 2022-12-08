import 'package:cloud_firestore/cloud_firestore.dart';

class RoomService {
  final CollectionReference roomCollection =
      FirebaseFirestore.instance.collection("Rooms");

  Future<QuerySnapshot> getRoom() {
    return roomCollection.orderBy("room").get();
  }

  Stream<QuerySnapshot> getRoomStream() {
    return roomCollection.snapshots();
  }
}
