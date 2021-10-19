import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/cubit.dart';
import 'package:shop_app/cubit/states.dart';
import 'package:shop_app/shared/component.dart';
import 'package:shop_app/shared/constant.dart';


import 'change_password.dart';

class ProfileScreen extends StatelessWidget {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state) {
        if(state is UpdateProfileSuccessState)
          if(state.updateUserModel.status!)
            showToast(msg: state.updateUserModel.message,state: ToastStates.SUCCESS);
          else
            showToast(msg: state.updateUserModel.message,state: ToastStates.ERROR);
      },
      builder: (context,state)
      {
        ShopCubit cubit =  ShopCubit.get(context);
        var model = cubit.userModel;
        nameController.text = model!.data!.name!;
        phoneController.text =model.data!.phone!;

        return  Scaffold(
          appBar: AppBar(
            titleSpacing: 0,

          ),
          body: SingleChildScrollView(
            child: Container(
              color: Colors.grey[300],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: Colors.white,
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Ahlan ${cubit.userModel!.data!.name!.split(' ').elementAt(0)}',
                          style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold,),),
                        Text('${cubit.userModel!.data!.email}',style: const TextStyle(fontSize: 15),),
                      ],
                    ),
                  ),
                  SizedBox(height: 15,),
                  Container(
                    color: Colors.white,
                    width: double.infinity,
                    height: 280,
                    padding: const EdgeInsets.all(10),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children :
                        [
                          if(state is UpdateProfileLoadingState)
                            Column(
                              children: const [
                                LinearProgressIndicator(),
                                SizedBox(height: 20,),
                              ],
                            ),
                          Row(
                            children: [
                              const Text('PERSONAL INFORMATION',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                              const Spacer(),
                              TextButton(
                                  onPressed: ()
                                  {
                                    // editPressed(
                                    //     context: context,
                                    //     name: nameController.text,
                                    //     phone: phoneController.text,
                                    //     email: cubit.userModel!.data!.email
                                    // );
                                  },
                                  child: Row(
                                    children: [
                                      const Icon(Icons.edit,color: Colors.grey,size: 15,),
                                      const SizedBox(width: 5,),
                                      Text('$editText',style: const TextStyle(color: Colors.grey),),
                                    ],
                                  )
                              ),
                            ],
                          ),
                          const SizedBox(height: 15,),

                          const Text('Name',style: TextStyle(fontSize: 15),),
                          defaultFormField(
                              controller: nameController,
                              context: context,
                              prefix: Icons.person,
                              enabled: isEdit ? true:false,
                              validate: (value){}
                          ),
                          const SizedBox(height: 40,),
                          const Text('Phone',style: TextStyle(fontSize: 15),),
                          defaultFormField(
                              context: context,
                              controller: phoneController,
                              prefix: Icons.phone,
                              enabled: isEdit ? true:false,
                              validate: (value){}
                          ),
                        ]
                    ),
                  ),
                  const SizedBox(height: 15,),
                  Container(
                    color: Colors.white,
                    width: double.infinity,

                    padding: const EdgeInsets.all(15),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('SECURITY INFORMATION',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                        const SizedBox(height: 5,),
                        OutlinedButton(
                            onPressed: (){
                              navigateTo(context,ChangePasswordScreen());
                            },
                            child: const Text('Change Password')
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height:200)
                ],
              ),
            ),
          ),
        );
      },
    );  }
}
