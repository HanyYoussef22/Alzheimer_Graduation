import 'package:alzahimer/Models/My_User.dart';
import 'package:alzahimer/modules/sign_up/register_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class RegisterCubit extends Cubit<RegisterStates> {

  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);


  void userRegister({
    required String email,
    required String password,
    required String name,
    required String birthDate,
  }) {
    emit(RegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print(value.user!.email);
      userCreate(
          name: name, email: email, uId: value.user!.uid,
      birthDate: birthDate,
      );

      emit(RegisterSuccessState(value.user!.uid));
    }).catchError((error) {
      print(error.toString());
      if (error.code == 'weak-password') {
        emit(RegisterFailureState('The password is too weak.'));
      } else if (error.code == 'email-already-in-use') {
        emit(RegisterFailureState('The email address is already in use.'));
      } else if (error.code == 'invalid-email') {
        emit(RegisterFailureState('The email address is invalid.'));
      } else {
        emit(RegisterFailureState('An error occurred during registration.'));
      }
    });
  }

  void userCreate({
    required String name,
    required String email,
    required String uId,
    required String birthDate,
    String? image,
  }) {
    MyUser model = MyUser(
      id: uId,
      email: email,
      fName: name,
      image: image ??
          'https://previews.123rf.com/images/kritchanut/kritchanut1406/kritchanut140600093/29213195-male-silhouette-avatar-profile-picture.jpg',
      phone: '01000000000',

      registerDate: DateFormat('yyyy-MM-dd')
          .format(DateTime.now()).toString(),
      birthDate: birthDate,
      listimageurl: [],
    );
    FirebaseFirestore.instance
        .collection('user')
        .doc(uId)
        .set(model.toJson())
        .then((value) {
      emit(CreateUserSuccessState());
    }).catchError((err) {
      emit(CreateUserErrorState());
      print('hello error$err');
    });
  }




}