import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../../../Models/My_User.dart';

class DataBaseUtil {
  static CollectionReference<MyUser> getUserCollectin() {
    return FirebaseFirestore.instance
        .collection(MyUser.CollecationName)
        .withConverter(
        fromFirestore: (snapshot, _) => MyUser.fromJson(snapshot.data()!),
        toFirestore: (user, _) => user.toJson());
  }

//creat data base For User By Id user For Register Screen
  static Future<void> creatDBforUser(MyUser user) {
    return getUserCollectin().doc(user.id).set(user);
  }


  static Future<MyUser> readUser(String uId) async {
    //Response Data For User By login ,take uId
    var userSnapshot = await getUserCollectin().doc(uId).get();
    return userSnapshot.data()!;
  }

  static Stream<DocumentSnapshot<MyUser>> readUserFromFirStoreStrem(
      String uId) {
    return getUserCollectin().doc(uId).snapshots();
  }

  static Future<void> deleteImage(
      {required String imageUrl, required String userId}) async {
    // Delete image from Firebase Storage
    final storageRef = FirebaseStorage.instance.refFromURL(imageUrl);
    storageRef.delete();
  }

  static Future<void> updateImagesForDelete(
      {required int index, required String userId}) async {
    final userRef = getUserCollectin().doc(userId);


    await userRef.update({
      'listimageurl': [index].removeAt(index),
    });
  }

  // FieldValue.arrayRemove([imageUrl]
  static Future<void> UpdateUser(
      {required String userId, required String newName}) async {
    getUserCollectin().doc(userId).update({'fName': newName});
  }
// static Future<MyUser> readUrser(String userId)async{
//   var userSnapShot=await getUserCollectin().doc(userId).get();
//   return userSnapShot.data()!;
// }


}
