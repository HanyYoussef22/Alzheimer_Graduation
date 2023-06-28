abstract class LoginStates {}


class LoginInitialState extends LoginStates {}
class LoginLoadingState extends LoginStates {}

class LoginSuccessState extends LoginStates {
 final String ui;
LoginSuccessState(this.ui);}
class LoginFailureState extends LoginStates {
  final String error;
  LoginFailureState(this.error);
}

