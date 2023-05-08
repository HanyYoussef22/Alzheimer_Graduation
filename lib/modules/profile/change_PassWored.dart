import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../shard/shared/components.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);
  static const String RoudeName = 'ChangePassword';

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController passController = TextEditingController();
  TextEditingController confirmController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    passController;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  'Change Password',
                  style: TextStyle(
                      color: Colors.black, fontSize: 30, fontFamily: 'oxygen'),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  'Enter New Password',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 16,
                    fontFamily: 'oxygen',
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                customTextField(
                  hintText: 'Password',
                  cp: 16,
                  Controller: passController,
                  validator: (value) {
                    value != null ? 'Password' : null;
                  },
                  prefixIcon: Icons.lock,
                ),
                SizedBox(
                  height: 15,
                ),
                customTextField(
                  hintText: 'Confirm Password',
                  prefixIcon: Icons.lock,
                  validator: (value) {
                    if (confirmController.text != passController.text) {
                      return 'Password and confirm password doesn\'t match!';
                    }
                    return null;
                  },
                  Controller: confirmController,
                ),
                const SizedBox(
                  height: 35,
                ),
                SizedBox(
                  height: 48,
                  child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.lightBlue),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ))),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          ChangePassword(passController.text);
                          print('test');
                          AwesomeDialog(
                                  btnOkColor: Colors.indigoAccent,
                                  context: context,
                                  dialogType: DialogType.success,
                                  borderSide: const BorderSide(
                                    color: Colors.green,
                                    width: 2,
                                  ),
                                  width: 590,
                                  buttonsBorderRadius: const BorderRadius.all(
                                    Radius.circular(2),
                                  ),
                                  dismissOnTouchOutside: true,
                                  dismissOnBackKeyPress: false,
                                  buttonsTextStyle: TextStyle(fontSize: 17),
                                  headerAnimationLoop: false,
                                  animType: AnimType.bottomSlide,
                                  title: 'Change Successfully',
                                  titleTextStyle: const TextStyle(
                                    fontSize: 17,
                                    fontFamily: 'oxygen',
                                    fontWeight: FontWeight.w700,
                                  ),
                                  descTextStyle: const TextStyle(
                                      fontFamily: 'oxygen', fontSize: 15),
                                  desc: 'Passwored Change Successfully.',
                                  showCloseIcon: true,
                                  btnOkOnPress: () {},
                                  btnOkText: 'OK')
                              .show();
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.lock,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            'Change Password',
                            style: TextStyle(
                                fontSize: 19,
                                fontFamily: 'oxygen',
                                fontWeight: FontWeight.w800),
                          ),
                        ],
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void ChangePassword(String password) async {
    //Create an instance of the current user.
    User? firebaseUser;
    firebaseUser = await FirebaseAuth.instance.currentUser;

    //Pass in the password to updatePassword.
    firebaseUser?.updatePassword(password).then((_) {
      print("Successfully changed password");
    }).catchError((error) {
      print("Password can't be changed" + error.toString());
      //This might happen, when the wrong password is in, the user isn't found, or if the user hasn't logged in recently.
    });
  }
}
