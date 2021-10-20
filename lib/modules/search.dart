import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/cubit.dart';
import 'package:shop_app/cubit/search/cubit.dart';
import 'package:shop_app/cubit/search/states.dart';
import 'package:shop_app/model/search_model/search.dart';
import 'package:shop_app/modules/product.dart';
import 'package:shop_app/shared/constant.dart';

class SearchScreen extends StatelessWidget {
  ShopCubit shopCubit;
  SearchScreen(this.shopCubit);
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit,SearchStates>(
        listener: (context, state){},
        builder:(context, state) {
          SearchCubit cubit = SearchCubit.get(context);

          return Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                toolbarHeight: 60,
                title: Padding(
                  padding: const EdgeInsets.all(7),
                  child: Row(
                    children: [
                      Container(
                        height: 35,
                        width: 250,
                        child: TextFormField(
                          style: Theme.of(context).textTheme.bodyText1,
                          controller: searchController,
                          textCapitalization: TextCapitalization.words,
                          keyboardType: TextInputType.text,
                          autofocus: true,
                          decoration: const InputDecoration(
                            hintText: 'What are you looking for ?',
                            hintStyle: TextStyle(fontSize: 15),
                            prefixIcon: Icon(Icons.search,color: Colors.blue,),
                          ),
                          onChanged: (value) {
                            cubit.getSearchData(value);
                          },
                        ),
                      ),
                      const Spacer(),
                      TextButton(
                          onPressed: ()
                          {
                            pop(context);
                          },
                          child: const Text('cancel',style: TextStyle(color: Colors.black),)
                      ),
                    ],
                  ),
                ),
              ),
              body: state is SearchLoadingState ?
              const Center(child: CircularProgressIndicator()):
              cubit.searchModel != null?
              searchController.text.isEmpty?
              Container(): ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context,index) =>searchItemBuilder(cubit.searchModel?.data.data[index],shopCubit,context) ,
                separatorBuilder:(context,index) => myDivider(),
                itemCount:cubit.searchModel?.data.data.length ?? 10,
              ) :
              Container()
          );
        },

      ),
    );
  }
  Widget searchItemBuilder(SearchProduct? model,ShopCubit shopCubit,context){
    return  InkWell(
      onTap: (){
        shopCubit.getProductData(model!.id);
        navigateTo(context, ProductScreen());
      },
      child: Container(
        height: 120,
        padding: const EdgeInsets.all(10),
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
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

}