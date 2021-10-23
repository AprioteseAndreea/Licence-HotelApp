import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app_flutter/models/user_model.dart';

class UserRepository {
  // // 1
  // final CollectionReference collection =
  //     FirebaseFirestore.instance.collection('users');
  // // 2
  // Stream<QuerySnapshot> getStream() {
  //   return collection.snapshots();
  // }
  //
  // Future<QuerySnapshot<Object?>> getDocs() async {
  //   return await collection.get();
  // }
  //
  // // 3
  // Future<DocumentReference> addPet(User user) {
  //   return collection.add(user.toJson());
  // }
  //
  // // 4
  // void updatePet(User user) async {
  //   await collection.doc(user.referenceId).update(user.toJson());
  // }
  //
  // // 5
  // void deletePet(User user) async {
  //   await collection.doc(user.referenceId).delete();
  // }
}
