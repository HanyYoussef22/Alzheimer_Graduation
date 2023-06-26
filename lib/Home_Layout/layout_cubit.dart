import 'dart:io';
import 'dart:math';
import 'package:alzahimer/shard/network/remote/datdbase/database_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:alzahimer/Models/My_User.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'layout_states.dart';

class LayoutCubit extends Cubit<LayoutStates> {
  LayoutCubit() : super(LayoutInitialState());

  static LayoutCubit get(context) => BlocProvider.of(context);
  MyUser? model;


  void getUserData() async {
    emit(GetUserLoadState());
    await FirebaseFirestore.instance
        .collection('user')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      model = MyUser.fromJson(value.data()!);

      // userModel = UserModel.fromJson(value.data()!);
      if (kDebugMode) {
        print(value.data());
      }
      emit(GetUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetUserErrorState());
    });
  }

  File? profileImage;

  ImagePicker picker = ImagePicker();

  Future<void> getProfileImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(ProfileImagePickSuccessState());
    } else {
      print('No selected Images');
      emit(ProfileImagePickErrorState());
    }
  }

  void profileImageUpload({
    required String name,
    required String phone,
  }) {
    emit(UserUpdateLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        updateUser(
          name: name,
          phone: phone,
          profile: value,
        );
        print(value);
      }).catchError((error) {
        emit(ProfileImageUploadErrorState());
        print(error.toString());
      });
    }).catchError((error) {
      emit(ProfileImageUploadErrorState());

      print(error.toString());
    });
  }

  void updateUser({
    required String name,
    required String phone,
    String? profile,
  }) {
    emit(UserUpdateLoadingState());

    MyUser userModel = MyUser(
      fName: name,
      id: model!.id,
      phone: phone,
      registerDate: model!.registerDate,
      birthDate: model!.birthDate,
      email: model!.email,
      image: profile ?? model!.image,
      listimageurl: [],
    );
    FirebaseFirestore.instance
        .collection('user')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update(userModel.toJson())
        .then(
      (value) {
        emit(UserUpdateSuccessState());
        getUserData();
      },
    ).catchError(
      (error) {
        print(error.toString());
        emit(UserUpdateErrorState());
      },
    );
  }
}
