import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/cubit.dart';
import 'package:shop_app/cubit/states.dart';
import 'package:shop_app/model/profile_model/faqs.dart';
import 'package:shop_app/shared/constant.dart';

class FAQsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
        listener: (context,state){},
        builder: (context,state){
          ShopCubit cubit = ShopCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              titleSpacing: 0,

            ),
            body:state is FAQsLoadingState? const Center(child: CircularProgressIndicator(),):
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      color: Colors.grey[300],
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      child: const Text('FAQs',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)),
                  ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder:(context,index) => faqsItemBuilder(cubit.faqsModel.data!.data![index]) ,
                      separatorBuilder:(context,index) => myDivider(),
                      itemCount: cubit.faqsModel.data!.data!.length
                  ),
                ],
              ),
            ),
          );
        }
    );
  }
  Widget faqsItemBuilder (FAQsData model)
  {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
        [
          Text('${model.question}',style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
          const SizedBox(height: 15,),
          Text('${model.answer}',style: const TextStyle(fontSize: 15),)
        ],
      ),
    );
  }
}
