abstract class RegisterStates {}


class RegisterInitialState extends RegisterStates {}
class RegisterLoadingState extends RegisterStates {}

class RegisterSuccessState extends RegisterStates {
  final String ui;
  RegisterSuccessState(this.ui);
}

class RegisterFailureState extends RegisterStates {
  final String error;
  RegisterFailureState(this.error);
}
class CreateUserSuccessState extends RegisterStates {}

class CreateUserErrorState extends RegisterStates {}