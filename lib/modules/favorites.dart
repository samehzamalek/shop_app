import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:shop_app/cubit/cubit.dart';
import 'package:shop_app/cubit/states.dart';
import 'package:shop_app/model/favorites_model/favorites.dart';
import 'package:shop_app/modules/product.dart';
import 'package:shop_app/shared/constant.dart';

class FavoritesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener:(context,state) {},
      builder:(context,state)
      {
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
          body: Conditional.single(
              context: context,
              conditionBuilder:(context) => state is !FavoritesLoadingState,
              widgetBuilder: (context) => SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            const Text('My Saved Items',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                            const SizedBox(width: 5,),
                            Text('(${ShopCubit.get(context).favoritesModel!.data!.total} items)',style: const TextStyle(color: Colors.grey),),
                          ],
                        )),
                    ListView.separated(
                        physics:const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder:(context,index) => favoriteProducts(ShopCubit.get(context).favoritesModel!.data!.data[index].product,context),
                        separatorBuilder:(context,index) =>myDivider(),
                        itemCount: ShopCubit.get(context).favoritesModel!.data!.data.length
                    ),
                  ],
                ),
              ),
              fallbackBuilder:(context) => const Center(child: CircularProgressIndicator())),
        );

      } ,
    );
  }

  Widget favoriteProducts(FavoriteProduct? model,context)
  {
    return InkWell(
      onTap: (){
        ShopCubit.get(context).getProductData(model!.id);
        navigateTo(context, ProductScreen());
      },
      child: Container(
        height: 180,
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Container(
              height: 100,
              child: Row(
                children:
                [
                  Image(image: NetworkImage('${model!.image}'),width: 100,height: 100,),
                  const SizedBox(width: 10,),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:
                      [
                        Text('${model.name}',
                          style: const TextStyle(fontSize: 15,),maxLines: 3,overflow: TextOverflow.ellipsis,),
                        const Spacer(),
                        Text('EGP '+'${model.price}',style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                        if(model.discount != 0)
                          Text('EGP'+'${model.oldPrice}',style: const TextStyle(decoration: TextDecoration.lineThrough,color: Colors.grey),),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const Spacer(),
            Row(
              children:
              [
                const Icon(Icons.shopping_cart_outlined,color: Colors.grey,),
                TextButton(
                    onPressed: (){
                      // ShopCubit.get(context).changeToFavorite(model.id);
                      // ShopCubit.get(context).addToCart(model.id);

                    },
                    child: const Text('Add To Cart',style: TextStyle(color: Colors.grey,),)
                ),
                const Spacer(),
                const Icon(Icons.delete_outline_outlined,color: Colors.grey,),
                TextButton(
                    onPressed: ()
                    {
                      ShopCubit.get(context).changeToFavorite(model.id);
                      ShopCubit.get(context).getFavoriteData();
                    },
                    child: const Text('Remove',style: TextStyle(color: Colors.grey,))
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
