import 'package:alzahimer/Models/My_User.dart';
import 'package:alzahimer/shard/Provider/user_Provider.dart';
import 'package:alzahimer/shard/network/remote/datdbase/database_utils.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../shard/shared/components.dart';

class ChangeName extends StatefulWidget {
  // const ChangeName({Key? key}) : super(key: key);
  static const String RoudeName = 'ChangeName';

  @override
  State<ChangeName> createState() => _ChangeNameState();
}

class _ChangeNameState extends State<ChangeName> {
  TextEditingController nameController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    nameController;
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          title: StreamBuilder<DocumentSnapshot<MyUser>>(
            stream: DataBaseUtil.readUserFromFirStoreStrem(
                provider.firebaseUser!.uid),
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
                    ' ${user.fName}',
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              );
            },
          )),
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
                  'Change Name',
                  style: TextStyle(
                      color: Colors.black, fontSize: 30, fontFamily: 'oxygen'),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  'Enter New Name You Want To Change',
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
                  hintText: 'New Name',
                  cp: 16,
                  Controller: nameController,
                  validator: (value) {
                    value != null ? 'Enter Your Name' : null;
                  },
                  prefixIcon: Icons.person,
                ),
                SizedBox(
                  height: 15,
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
                          ChangeName(
                              newName: nameController.text,
                              userId: provider.user!.id);
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
                            desc: 'Name Change Successfully.',
                            showCloseIcon: true,
                            btnOkOnPress: () {
                              Navigator.pop(context);
                            },
                            btnOkText: 'OK',
                          ).show();
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.person,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            'Change Name',
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

  // Future<void> initValue() async {
  //   var provider= Provider.of<UserProvider>(context,listen: false);
  //
  //   User? firebaseUser;
  //   firebaseUser =  FirebaseAuth.instance.currentUser;
  //   provider.user=await DataBaseUtil.readUser(firebaseUser?.uid ?? "");
  // }

  void ChangeName({required String userId, required String newName}) async {
    DataBaseUtil.UpdateUser(userId: userId, newName: newName);
  }
}
