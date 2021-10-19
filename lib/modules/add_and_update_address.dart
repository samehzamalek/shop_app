import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/cubit.dart';
import 'package:shop_app/cubit/states.dart';
import 'package:shop_app/shared/constant.dart';

import 'address.dart';

class UpdateAddressScreen extends StatelessWidget {
  TextEditingController nameControl = TextEditingController();
  TextEditingController cityControl = TextEditingController();
  TextEditingController regionControl = TextEditingController();
  TextEditingController detailsControl = TextEditingController();
  TextEditingController notesControl = TextEditingController();

  var addressFormKey = GlobalKey<FormState>();

  final bool isEdit;
  final int ?addressId;
  final String? name;
  final String? city;
  final String? region;
  final String? details;
  final String? notes;
  UpdateAddressScreen({
    required this.isEdit,
    this.addressId,
    this.name,
    this.city,
    this.region,
    this.details,
    this.notes,
  });


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state) {},
      builder: (context,state) {
        if(isEdit) {
          nameControl.text = name!;
          cityControl.text = city!;
          regionControl.text = region!;
          detailsControl.text = details!;
          notesControl.text = notes!;
        }
        return Scaffold(
          appBar: AppBar(
            titleSpacing: 0,

            actions: [
              IconButton(
                  onPressed: () {
                  //  navigateTo(context, SearchScreen(ShopCubit.get(context)));
                  },
                  icon: const Icon(Icons.search)),


            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(15),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Form(
                key: addressFormKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children :
                    [
                      if(state is AddAddressLoadingState)
                        Column(
                          children: const [
                            LinearProgressIndicator(),
                            SizedBox(height: 20,),
                          ],
                        ),
                      const Text('Location Information',style: TextStyle(fontSize: 17),),
                      const SizedBox(height: 30,),

                      const Text('Name',style: TextStyle(fontSize: 15),),
                      TextFormField(
                          controller: nameControl,
                          textCapitalization: TextCapitalization.words,
                          decoration: const InputDecoration(
                            hintText : 'Please enter your Location name',
                            hintStyle: TextStyle(color: Colors.grey,fontSize: 15),
                            border: UnderlineInputBorder(),
                          ),
                          validator: (value){
                            if(value!.isEmpty) {
                              return 'This field cant be Empty';
                            }
                          }
                      ),
                      const SizedBox(height: 40,),
                      const Text('City',style: TextStyle(fontSize: 15),),
                      TextFormField(
                          controller: cityControl,
                          textCapitalization: TextCapitalization.words,
                          decoration: const InputDecoration(
                            hintText : 'Please enter your City name',
                            hintStyle: TextStyle(color: Colors.grey,fontSize: 15),
                            border: UnderlineInputBorder(),
                          ),
                          validator: (value){
                            if(value!.isEmpty) {
                              return 'This field cant be Empty';
                            }
                          }
                      ),
                      const SizedBox(height: 40,),
                      const Text('Region',style: TextStyle(fontSize: 15),),
                      TextFormField(
                          controller: regionControl,
                          textCapitalization: TextCapitalization.words,
                          decoration: const InputDecoration(
                            hintText : 'Please enter your region',
                            hintStyle: TextStyle(color: Colors.grey,fontSize: 15),
                            border: UnderlineInputBorder(),
                          ),
                          validator: (value){
                            if(value!.isEmpty) {
                              return 'This field cant be Empty';
                            }
                          }
                      ),
                      const SizedBox(height: 40,),
                      const Text('Details',style: TextStyle(fontSize: 15),),
                      TextFormField(
                          controller: detailsControl,
                          textCapitalization: TextCapitalization.words,
                          decoration: const InputDecoration(
                            hintText : 'Please enter some details',
                            hintStyle: TextStyle(color: Colors.grey,fontSize: 15),
                            border: UnderlineInputBorder(),
                          ),
                          validator: (value){
                            if(value!.isEmpty) {
                              return 'This field cant be Empty';
                            }
                          }
                      ),
                      const SizedBox(height: 40,),
                      const Text('Notes',style: TextStyle(fontSize: 15),),
                      TextFormField(
                          controller: notesControl,
                          textCapitalization: TextCapitalization.words,
                          decoration: const InputDecoration(
                            hintText : 'Please add some notes to help find you',
                            hintStyle: TextStyle(color: Colors.grey,fontSize: 15),
                            border: UnderlineInputBorder(),
                          ),
                          validator: (value){
                            if(value!.isEmpty) {
                              return 'This field cant be Empty';
                            }
                          }
                      ),
                      const SizedBox(height: 40,),
                      Container(
                        height: 50,
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: () {
                              if(addressFormKey.currentState!.validate())
                              {
                                if(isEdit)
                                {
                                  ShopCubit.get(context).updateAddress(
                                      addressId: addressId,
                                      name: nameControl.text,
                                      city: cityControl.text,
                                      region: regionControl.text,
                                      details: detailsControl.text,
                                      notes: notesControl.text);
                                  if (state is AddAddressSuccessState) {
                                    if (state.addAddressModel.status) {
                                      navigateTo(context, AddressesScreen());
                                    }
                                  }
                                }
                                else {
                                  ShopCubit.get(context).addAddress(
                                      name: nameControl.text,
                                      city: cityControl.text,
                                      region: regionControl.text,
                                      details: detailsControl.text,
                                      notes: notesControl.text);
                                  if (state is AddAddressSuccessState) {
                                    if (state.addAddressModel.status) {
                                      navigateTo(context, AddressesScreen());
                                    }
                                  }
                                }
                              }
                            },
                            child: const Text('SAVE ADDRESS',style: TextStyle(color: Colors.black,fontSize: 15),)
                        ),
                      ),
                    ]
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
