import 'package:cloud_firestore/cloud_firestore.dart';

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
// static Future<MyUser> readUrser(String userId)async{
//   var userSnapShot=await getUserCollectin().doc(userId).get();
//   return userSnapShot.data()!;
// }
}
