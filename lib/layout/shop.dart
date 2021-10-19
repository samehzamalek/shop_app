
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/cubit.dart';
import 'package:shop_app/cubit/states.dart';
import 'package:shop_app/modules/search.dart';
import 'package:shop_app/shared/constant.dart';
class ShopLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener:(context,state) {

      } ,
      builder: (context,state) {
        ShopCubit cubit =  ShopCubit.get(context);
        return  Scaffold(
          appBar: AppBar(
            titleSpacing: 10,
            title: const Text('Catalog'),

            actions: [
              IconButton(
                  onPressed: () {
                     navigateTo(context, SearchScreen(ShopCubit.get(context)));
                  },
                  icon: const Icon(Icons.search)),
            ],
            elevation: 2,
          ),
          body:
          cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            items:cubit.navBar,
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              return cubit.changeBottomNav(index);

            },

          ),
        );
      },
    );
  }
}
