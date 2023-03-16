import 'package:firebase_auth/firebase_auth.dart';

import '../../Base.dart';
import '../../shard/network/remote/datdbase/database_utils.dart';
import 'LoginNavigetor.dart';

class LoginViewModel extends BaseViewModel<LoginNavigetor> {
  String? massege;

  Future<void> LoginInEmail(
      {required String emailAddress, required String password}) async {
    try {
      print('Login');
      navigetor.showLoading(IsDissmassable: false);
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);
      print('Login is Successfully1');
      navigetor.hidMassage();
      var user = await DataBaseUtil.readUser(credential.user?.uid ?? "");
      navigetor.GoToHomeFromLogin(user);
      print('Login is Successfully2');
      // massege='Login Successfully';
      // massege='Login Successfully';
      if (user == null) {
        massege = 'Failed Complete Sing in Pleas Try again later';
      } else {
        navigetor.hidMassage();
        navigetor.GoToHomeFromLogin(user);
      }
      // navigetor.hidMassage();
    } on FirebaseAuthException catch (e) {
      navigetor.hidMassage();
      if (e.code == 'user-not-found') {
        massege = 'No user found for that email.';
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        massege = 'Wrong password provided for that user.';

        print('Wrong password provided for that user.');
      }
      navigetor.showMassage(massege!);
    }
  }
}
