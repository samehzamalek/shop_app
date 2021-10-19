import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/cubit.dart';
import 'package:shop_app/layout/shop.dart';
import 'package:shop_app/modules/onboarding.dart';
import 'package:shop_app/remote_network/cach_helper.dart';
import 'package:shop_app/remote_network/dio_helper.dart';
import 'package:shop_app/shared/bloc_observer.dart';
import 'package:shop_app/shared/constant.dart';
import 'package:shop_app/shared/themes.dart';
import 'modules/login.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
   Widget widget;
  bool? showOnBoard = CacheHelper.getData('ShowOnBoard');
   token = CacheHelper.getData('token');
  if(showOnBoard !=null){
    if(token != null ) {
      widget =ShopLayout();
    } else {
      widget =LoginScreen();
    }
  }else{
    widget = OnBoardingScreen();
  }

  runApp( MyApp(
    startWidget:widget,
  ));

}

class MyApp extends StatelessWidget {
  final Widget? startWidget;
    MyApp({Key? key,this.startWidget}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(

      providers: [
        BlocProvider(create: (BuildContext context)=>
        ShopCubit()..getHomeData()..getCategories()..getFavoriteData()..getAddresses()..getProfileData()..getCartData()
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme:  lightMode(),
        home:startWidget,

      ),
    );
  }
}

