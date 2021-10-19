import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/cubit.dart';
import 'package:shop_app/cubit/states.dart';
import 'package:shop_app/model/categories_model/categories.dart';
import 'package:shop_app/shared/constant.dart';

import 'categore_product.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener:(context,state){} ,
      builder:(context,state)
      {
        return ListView.separated(
            itemBuilder:(context,index) => buildCategoriesItem(ShopCubit.get(context).categoriesModel!.data!.data[index],context),
            separatorBuilder:(context,index) => myDivider(),
            itemCount: ShopCubit.get(context).categoriesModel!.data!.data.length
        );
      } ,
    );
  }

  Widget buildCategoriesItem (DataModel model,context) {
    return
      InkWell(
        onTap: (){
          ShopCubit.get(context).getCategoryDetailData(model.id);
          navigateTo(context, CategoryProductsScreen(model.name));
        },
        child: Container(
          padding: const EdgeInsets.all(15),
          child: Row(
            children:
            [
              Image(image: NetworkImage('${model.image}'),width: 100,height: 100,fit: BoxFit.cover,),
              separator(15, 0),
              Text('${model.name}',style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
              const Spacer(),
              const Icon(Icons.arrow_forward_ios_rounded),
              separator(10,0),
            ],
          ),
        ),
      );
  }
}
