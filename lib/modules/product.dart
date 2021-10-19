import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
 import 'package:shop_app/cubit/cubit.dart';
import 'package:shop_app/cubit/states.dart';
import 'package:shop_app/model/home_model/product.dart';
import 'package:shop_app/shared/constant.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';


class ProductScreen extends StatelessWidget {

  PageController productImages = PageController();
  var scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){
        if (state is AddCartSuccessState)
          if(state.addCartModel.status)
            ShopCubit.get(context).inCart = true;

      },
      builder: (context,state){
        ProductDetailsData ? model = ShopCubit.get(context).productDetailsModel?.data;
        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(


            actions: [
              IconButton(
                  onPressed: () {
                 //   navigateTo(context, SearchScreen(ShopCubit.get(context)));
                  },
                  icon: const Icon(Icons.search)),


            ],
          ),
          body:state is ProductDetailsLoadingState? const Center(child: CircularProgressIndicator(),) :
          Stack(
            alignment: AlignmentDirectional.topCenter,
            children: [
             // ShopCubit.get(context).topSheet(model, context),
              Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: [
                  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        children: [
                          Container(
                              width: double.infinity,
                              child: Text('${model!.name}',style: const TextStyle(fontSize: 20),)),
                          Container(
                            height: 400,
                            width: double.infinity,
                            child: Stack(
                              alignment: AlignmentDirectional.topEnd,
                              children: [
                                PageView.builder(
                                  controller: productImages,
                                  itemBuilder: (context,index) => Image(
                                    image: NetworkImage('${model.images![index]}'),),
                                  itemCount: model.images!.length,
                                ),
                                // IconButton(
                                //   onPressed: ()
                                //   {
                                //     // ShopCubit.get(context).changeToFavorite(model.id);
                                //     // print(model.id);
                                //   },
                                //   // icon: Conditional.single(
                                //   //   context: context,
                                //   //   conditionBuilder:(context) => ShopCubit.get(context).favorites[model.id],
                                //   //   widgetBuilder:(context) => ShopCubit.get(context).favoriteIcon,
                                //   //   fallbackBuilder: (context) => ShopCubit.get(context).unFavoriteIcon,
                                //   // ),
                                //   iconSize: 35,
                                // ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10,),
                          SmoothPageIndicator(
                            controller: productImages,
                            count: model.images!.length,
                            effect: const ExpandingDotsEffect(
                                dotColor: Colors.grey,
                                activeDotColor: Colors.deepOrange,
                                expansionFactor: 4,
                                dotHeight: 7,
                                dotWidth: 10,
                                spacing: 10
                            ),
                          ),
                          const SizedBox(height: 20,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('EGP '
                                  ''+ '${model.price}',style:const TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                              if(model.discount!=0)
                                Row(
                                  children: [
                                    Text('EGP'+'${model.oldPrice}',style:const TextStyle(color: Colors.grey,decoration: TextDecoration.lineThrough),),
                                    const SizedBox(width: 5,),
                                    Text('${model.discount}% OFF',style: const TextStyle(color: Colors.red),),
                                  ],
                                ),
                              const SizedBox(height: 15,),
                              myDivider(),
                              const SizedBox(height: 15,),
                              Row(
                                children: [
                                  const Text('FREE delivery by ',style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold),),
                                  Text('${getDateTomorrow()}'),
                                ],
                              ),
                              const SizedBox(height: 5,),
                              const Text('Order in 19h 16m',style: TextStyle(color: Colors.grey),),
                              const SizedBox(height: 15,),
                              myDivider(),
                              SizedBox(height: 15,),
                              const Text('Offer Details',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold)),
                              const SizedBox(height: 10,),
                              Row(children: const [
                                Icon(Icons.check_circle_outline,color: Colors.green),
                                SizedBox(width: 5,),
                                Text('Enjoy free returns with this offer'),
                              ],),
                              const SizedBox(height: 15,),
                              myDivider(),
                              const SizedBox(height: 15,),
                              Row(children: const [
                                Icon(Icons.check_circle_outline,color: Colors.green),
                                SizedBox(width: 5,),
                                Text('1 Year warranty'),
                              ],),
                              SizedBox(height: 15,),
                              myDivider(),
                              SizedBox(height: 15,),
                              Row(children: const [
                                Icon(Icons.check_circle_outline,color: Colors.green,),
                                SizedBox(width: 5,),
                                Text('Sold by ShopMart'),
                              ],),
                              const SizedBox(height: 15,),
                              myDivider(),
                              const SizedBox(height: 15,),
                              const Text('Overview',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
                              const SizedBox(height: 15,),
                              Text('${model.description}'),
                              const SizedBox(height: 20,),
                            ],
                          ),
                          Container(height: 40,width: double.infinity,)
                        ],),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 60,
                    color: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 10 ,horizontal: 15),
                    child: ElevatedButton(

                        onPressed: (){
                          if(ShopCubit.get(context).cart[model.id]) {
                            showToast(msg: 'Already in Your Cart \nCheck your cart To Edit or Delete ',state: ToastStates.WARNING);
                          }
                          else {
                            ShopCubit.get(context).addToCart(model.id);
                            // scaffoldKey.currentState!.showBottomSheet(
                            //       (context) => Container(
                            //         color: Colors.grey[300],
                            //         padding: EdgeInsets.all(15),
                            //         child: Column(
                            //           mainAxisSize: MainAxisSize.min,
                            //           children: [
                            //             Row(
                            //               children: [
                            //                 Icon(Icons.check_circle, color: Colors.green, size: 30,),
                            //                 SizedBox(width: 10,),
                            //                 Column(
                            //                   crossAxisAlignment: CrossAxisAlignment.start,
                            //                   children: [
                            //                     Text('${model.name}', maxLines: 2,
                            //                       overflow: TextOverflow.ellipsis,),
                            //                     SizedBox(height: 5,),
                            //                     Text('Added to Cart',
                            //                       style: TextStyle(color: Colors.grey, fontSize: 13),)
                            //                   ],
                            //                 ),
                            //               ],
                            //             ),
                            //             SizedBox(height: 10,),
                            //             Row(
                            //               mainAxisAlignment: MainAxisAlignment.end,
                            //               children: [
                            //                 OutlinedButton(
                            //                     onPressed: () {
                            //                       Navigator.pop(context);
                            //                       },
                            //                     child: Text('CONTINUE SHOPPING')
                            //                 ),
                            //                 SizedBox(width: 10,),
                            //                 ElevatedButton(
                            //                   onPressed: () {
                            //                     navigateTo(context, ShopLayout());
                            //                     ShopCubit.get(context).currentIndex = 3;
                            //                     },
                            //                   child: Text('CHECKOUT'),
                            //                 ),
                            //               ],
                            //             ),
                            //           ],
                            //         ),
                            //       ),
                            //   elevation: 50,
                            //   );
                          }
                        },
                        child: Text('Add to Cart',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)
                    ),
                  )
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
