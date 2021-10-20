import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/login/cubit.dart';
import 'package:shop_app/cubit/login/states.dart';
import 'package:shop_app/layout/shop.dart';
import 'package:shop_app/modules/register.dart';
import 'package:shop_app/remote_network/cach_helper.dart';
import 'package:shop_app/shared/component.dart';
import 'package:shop_app/shared/constant.dart';

class LoginScreen extends StatelessWidget {
    LoginScreen({Key? key}) : super(key: key);
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool hidePassword  = true;
  var loginFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>LoginCubit(),
      child: BlocConsumer<LoginCubit,LoginStates>(
        listener: (context,state){
          if(state is LoginSuccessState){
            if(state.loginModel.status!){
              print(state.loginModel.data!.token);
              CacheHelper.saveData(key: 'token', value: state.loginModel.data!.token).then((value) {

                navigateAndKill(context, ShopLayout());
              });

            }else
              {
                showToast(msg:state.loginModel.message,state:ToastStates.ERROR);

              }

          }

        },
        builder: (context,state){
          return  Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key:loginFormKey ,
                    child: Column(children: [

                      defaultFormField(
                          context: context,
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          label: 'Email Address',
                          prefix: Icons.email,
                          validate: (value)
                          {
                            if(value!.isEmpty) {
                              return 'Email Address must be filled';
                            }
                          }
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      defaultFormField(
                          context: context,
                          controller: passwordController,
                          label: 'Password',
                          prefix: Icons.lock,
                          isPassword: !LoginCubit.get(context).showPassword ? true : false,
                          validate: (value)
                          {
                            if(value!.isEmpty) {
                              return'Password must be filled';
                            }
                          },
                          onSubmit: (value)
                          {
                            if (loginFormKey.currentState!.validate()) {
                              LoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text);
                            }

                          },
                          suffix: LoginCubit.get(context).suffixIcon,
                          suffixPressed: ()
                          {
                            LoginCubit.get(context).changeSuffixIcon(context);
                          }
                      ),
                      const SizedBox(height: 25,),
                      state is LoginLoadingState ?
                      const Center(child: CircularProgressIndicator())
                          :defaultButton(
                        text: 'LOGIN',
                        onTap: () {
                          if (loginFormKey.currentState!.validate()) {
                            LoginCubit.get(context).userLogin(
                              email: emailController.text,
                              password: passwordController.text,
                            );
                            token = CacheHelper.getData('token');

                          }

                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text(
                              'Don\'t have an account?'
                          ),
                          TextButton(
                              onPressed: () {
                                navigateTo(context, RegisterScreen());
                              },
                              child: const Text('Register Now')
                          ),
                      ],)


                    ],),
                  ),
                ),
              ),
            ),
          );
        },

      ),
    );
  }
}
