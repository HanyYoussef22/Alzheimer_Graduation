abstract class RegisterStates {}


class RegisterInitialState extends RegisterStates {}
class RegisterLoadingState extends RegisterStates {}

class RegisterSuccessState extends RegisterStates {}

class RegisterFailureState extends RegisterStates {}
class CreateUserSuccessState extends RegisterStates {}

class CreateUserErrorState extends RegisterStates {}