import 'package:shop_app/model/login_model/login.dart';

abstract class LoginStates{}

class LoginInitialState extends LoginStates{}
class LoginLoadingState extends LoginStates{}
class LoginSuccessState extends LoginStates{
  final LoginModel loginModel;

  LoginSuccessState(this.loginModel);

}
class LoginErrorState extends LoginStates{}
class ChangeSuffixIconState extends LoginStates{}