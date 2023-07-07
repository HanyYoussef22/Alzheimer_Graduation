import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_states.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(LoginLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      if (kDebugMode) {
        print(value.user!.email);
      }
      emit(LoginSuccessState(value.user!.uid));
    }
    ).catchError((error) {
      emit(LoginFailureState(error.toString()));
      if (kDebugMode) {
        print("error => $error");
      }
    });
  }
}
