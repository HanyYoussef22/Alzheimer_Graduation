import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../../Models/My_User.dart';
import '../network/remote/datdbase/database_utils.dart';

class UserProvider extends ChangeNotifier {
  User? firebaseUser;
  MyUser? user;

  UserPrvider() {
    initMyUser();
  }

  UserProvider() {
    firebaseUser = FirebaseAuth.instance.currentUser;
    initMyUser();
  }

  void initMyUser() async {
    if (firebaseUser != null) {
      user = await DataBaseUtil.readUser(firebaseUser?.uid ?? "");
    }
  }
}
