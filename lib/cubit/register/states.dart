import 'package:shop_app/model/login_model/login.dart';

abstract class  RegisterStates{}
class RegisterInitialState extends RegisterStates{}
class RegisterLoadingState extends RegisterStates{}
class RegisterSuccessState extends RegisterStates{
  final LoginModel signUpUserModel;

  RegisterSuccessState(this.signUpUserModel);

}
class RegisterErrorState extends RegisterStates{}
class  SuffixIconState extends RegisterStates{}
