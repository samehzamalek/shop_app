import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/register/states.dart';
import 'package:shop_app/model/login_model/login.dart';
 import 'package:shop_app/remote_network/dio_helper.dart';
import 'package:shop_app/remote_network/end_point.dart';
import 'package:shop_app/shared/constant.dart';

class SignInCubit extends Cubit<RegisterStates>
{
  SignInCubit() : super(RegisterInitialState());

  static SignInCubit get(context) => BlocProvider.of(context);

    LoginModel? signInModel;

  void signUp({
    required String name,
    required String phone,
    required String email,
    required String password,
  }) {
    emit(RegisterLoadingState());
    DioHelper.postData(
        url: REGISTER,
        token: token,
        data:
        {
          'name': '$name',
          'email': '$email',
          'phone': '$phone',
          'password': '$password',
        }).then((value) {
      signInModel = LoginModel.fromJson(value.data);
      emit(RegisterSuccessState(signInModel!));
    }).catchError((error) {
      print(error.toString());
      emit(RegisterErrorState());
    });
  }

  bool showPassword = false;
  IconData suffixIcon = Icons.visibility;
  void changeSuffixIcon(context){
    showPassword =! showPassword;
    if(showPassword)
      suffixIcon = Icons.visibility_off;
    else
      suffixIcon = Icons.visibility;
    emit(SuffixIconState());
  }

  bool showConfirmPassword = false;
  IconData confirmSuffixIcon = Icons.visibility;
  void changeConfirmSuffixIcon(context){
    showConfirmPassword =! showConfirmPassword;
    if(showConfirmPassword) {
      confirmSuffixIcon = Icons.visibility_off;
    } else {
      confirmSuffixIcon = Icons.visibility;
    }
    emit(SuffixIconState());
  }

}