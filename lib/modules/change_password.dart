import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/cubit.dart';
import 'package:shop_app/cubit/states.dart';
import 'package:shop_app/shared/constant.dart';

class ChangePasswordScreen extends StatelessWidget {
  TextEditingController currentPass = TextEditingController();
  TextEditingController newPass = TextEditingController();
  var changePasskey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
        listener: (context,state) {},
        builder: (context,state) {
          return Scaffold(
            appBar: AppBar(
              titleSpacing: 0,
              automaticallyImplyLeading: false,

              actions:
              [
                TextButton(
                  onPressed: (){
                    pop(context);
                  },
                  child: const Text('CANCEL',style: TextStyle(color: Colors.grey),),
                ),
              ],
            ),
            body: Container(
                color: Colors.white,
                width: double.infinity,
                //height: 280,
                padding: const EdgeInsets.all(20),
                child: Form(
                  key:changePasskey ,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children :
                      [
                        if(state is ChangePassLoadingState)
                          Column(
                            children: const [
                              LinearProgressIndicator(),
                              SizedBox(height: 20,),
                            ],
                          ),
                        const Text('Current Password',style: TextStyle(fontSize: 15),),
                        TextFormField(
                            controller: currentPass,
                            textCapitalization: TextCapitalization.words,
                            obscureText: !ShopCubit.get(context).showCurrentPassword ? true:false,
                            decoration: InputDecoration(
                                contentPadding:const EdgeInsets.all(15) ,
                                hintText : 'Please enter Current Password',
                                hintStyle: const TextStyle(color: Colors.grey,fontSize: 15),
                                border: const UnderlineInputBorder(),
                                suffixIcon: IconButton(
                                    onPressed: (){
                                      ShopCubit.get(context).changeCurrentPassIcon(context);
                                    },
                                    icon: Icon (ShopCubit.get(context).currentPasswordIcon)
                                )
                            ),
                            validator: (value){
                              if(value!.isEmpty) {
                                return 'This field cant be Empty';
                              }
                            }
                        ),
                        const SizedBox(height: 40,),
                        const Text('New Password',style: TextStyle(fontSize: 15),),
                        TextFormField(
                            controller: newPass,
                            textCapitalization: TextCapitalization.words,
                            obscureText: !ShopCubit.get(context).showNewPassword ? true:false,
                            decoration: InputDecoration(
                                contentPadding:const EdgeInsets.all(15) ,
                                hintText : 'Please enter New Password',
                                hintStyle: const TextStyle(color: Colors.grey,fontSize: 15),
                                border: const UnderlineInputBorder(),
                                suffixIcon: IconButton(
                                    onPressed: (){
                                      ShopCubit.get(context).changeNewPassIcon(context);
                                    },
                                    icon: Icon (ShopCubit.get(context).newPasswordIcon)
                                )
                            ),
                            validator: (value){
                              if(value!.isEmpty) {
                                return 'This field cant be Empty';
                              }
                            }),
                        const Spacer(),
                        Container(
                          height: 40,
                          width: double.infinity,
                          child: ElevatedButton(
                              onPressed: (){
                                if(changePasskey.currentState!.validate())
                                {
                                  ShopCubit.get(context).changePassword(
                                    context: context,
                                    currentPass: currentPass.text,
                                    newPass: newPass.text,
                                  );
                                }
                              },
                              child: const Text('Change Password')
                          ),
                        ),

                      ]),
                )
            ),
          );
        }
    );
  }
}