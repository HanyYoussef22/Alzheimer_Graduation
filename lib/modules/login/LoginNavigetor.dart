import '../../Base.dart';
import '../../Models/My_User.dart';

abstract class LoginNavigetor extends BaseNavigetor {
  void GoToHomeFromLogin(MyUser user);
}
