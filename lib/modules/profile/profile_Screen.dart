import 'dart:io';
import 'package:alzahimer/Models/My_User.dart';
import 'package:alzahimer/login/login_screen.dart';import 'package:alzahimer/modules/profile/change_PassWored.dart';
import 'package:alzahimer/shard/network/remote/datdbase/database_utils.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../shard/Provider/user_Provider.dart';
import 'change_name.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);
  static const String RoudeName = 'ProfileScreen';

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _Strem = true;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // void initState() {
  //   super.initState();
  //   // Register an ID token listener
  //   _auth.idTokenChanges().listen((User? user) {
  //     if (user == null) {
  //       // The user is signed out.
  //     } else {
  //       // The user is signed in and has a new ID token.
  //     }
  //   });
  // }
  @override
  Widget build(BuildContext context) {
    var providere = Provider.of<UserProvider>(context);
    // User? firebaseUser;
    // firebaseUser = FirebaseAuth.instance.currentUser;

    var userid;
    // userid=firebaseUser?.uid;
    // providere.firebaseUser=firebaseUser;
    var mediaqureHeight = MediaQuery.of(context).size.height;
    var mediaqureWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: StreamBuilder<DocumentSnapshot<MyUser>>(
            stream: DataBaseUtil.readUserFromFirStoreStrem(
                providere.firebaseUser!.uid),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot<MyUser>> snapshot) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }
              if (!snapshot.hasData) {
                return Text('No Data');
              }
              final DocumentSnapshot<MyUser> documentSnapshot = snapshot.data!;
              if (!documentSnapshot.exists) {
                return Text('Document does not exist');
              }
              final MyUser user = documentSnapshot.data()!;
              providere.user = user;
              return Row(
                children: [
                  Icon(
                    Icons.person,
                    color: Colors.purple,
                    size: 40,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    'Welcome ${user.fName}',
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              );
            },
          )

          // title: Text('Welcome  ${providere.user?.fName}',style: TextStyle(color: Colors.black),),
          ),
      body: Column(
        children: [
          Spacer(
            flex: 1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, ChangePassword.RoudeName);
                  setState(() {});
                },
                child: Card(
                  margin: EdgeInsets.all(10),
                  elevation: 50,
                  shadowColor: Colors.black45,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Container(
                    height: mediaqureHeight * 0.15,
                    width: mediaqureWidth * 0.40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Color(0xfff7f7f7),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.edit,
                          color: Colors.purple,
                          size: 40,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Password',
                          style: TextStyle(
                            color: Colors.purple,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, ChangeName.RoudeName);
                },
                child: Card(
                  margin: EdgeInsets.all(10),
                  elevation: 50,
                  shadowColor: Colors.black45,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Container(
                    height: mediaqureHeight * 0.15,
                    width: mediaqureWidth * 0.40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Color(0xfff7f7f7),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.person,
                          color: Colors.purple,
                          size: 40,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Name',
                          style: TextStyle(
                            color: Colors.purple,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  LogoutFun();
                },
                child: Card(
                  margin: EdgeInsets.all(10),
                  elevation: 50,
                  shadowColor: Colors.black45,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Container(
                    height: mediaqureHeight * 0.15,
                    width: mediaqureWidth * 0.40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Color(0xfff7f7f7),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.logout,
                          color: Colors.purple,
                          size: 40,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Logout',
                          style: TextStyle(
                            color: Colors.purple,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  AwesomeDialog(
                          btnOkColor: Colors.indigoAccent,
                          context: context,
                          dialogType: DialogType.question,
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
                          title: 'Do You Want Delete Account',
                          titleTextStyle: const TextStyle(
                            fontSize: 17,
                            fontFamily: 'oxygen',
                            fontWeight: FontWeight.w700,
                          ),
                          descTextStyle: const TextStyle(
                              fontFamily: 'oxygen', fontSize: 15),
                          desc:
                              'Warning all data Will Be Deleted Can Recover it',
                          showCloseIcon: true,
                          btnOkOnPress: () {
                            DeleteAccount();
                          },
                          btnOkText: 'OK')
                      .show();
                },
                child: Card(
                  margin: EdgeInsets.all(10),
                  elevation: 50,
                  shadowColor: Colors.black45,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Container(
                    height: mediaqureHeight * 0.15,
                    width: mediaqureWidth * 0.40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Color(0xfff7f7f7),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.design_services,
                          color: Colors.purple,
                          size: 40,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Delete Account',
                          style: TextStyle(
                            color: Colors.purple,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
          Spacer(
            flex: 4,
          ),
        ],
      ),
    );
  }

  void LogoutFun() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;

    try {
      var providere = Provider.of<UserProvider>(context, listen: false);
      await FirebaseAuth.instance.signOut();
      User? FirebaseUser = FirebaseAuth.instance.currentUser;
      providere.firebaseUser = FirebaseUser;
      Navigator.pushNamed(context, '/login_screen');
      // User is now signed out.
    } catch (e) {
      // An error occurred while trying to sign out the user.
      print('Failed to sign out user: $e');
    }
  }

  DeleteAccount() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      var providere = Provider.of<UserProvider>(context, listen: false);
      try {
        await user.delete();
        User? FirebaseUser = FirebaseAuth.instance.currentUser;
        providere.firebaseUser = FirebaseUser;
        Navigator.pushNamed(context, 'login_screen');
      } catch (e) {
        // An error occurred while trying to delete the user account.
        print('Failed to delete user account: $e');
      }
    }
  }
}
