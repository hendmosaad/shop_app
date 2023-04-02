import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layouts/ShopLayOut.dart';
import 'package:shop_app/modules/login_screen.dart';
import 'package:shop_app/modules/on_borading.dart';
import 'package:shop_app/shared/component/widgets/constatnts.dart';
import 'package:shop_app/shared/network/local/bloc/bloc_observer.dart';
import 'package:shop_app/shared/network/local/bloc/shop_cubit.dart';
import 'package:shop_app/shared/network/local/bloc/shop_states.dart';
import 'package:shop_app/shared/network/local/shared_pref/shared_pref.dart';
import 'package:shop_app/shared/network/remote/dio/dio_helper.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();

  await CacheHelper.initShared();
  DioHelper.init();
  bool? isLast;
  token=await CacheHelper.getData(key: 'token');
  print(token);
  print(status);
  isLast=await CacheHelper.getData(key: 'isLast');

    Widget? intialPage;

   if(isLast ==null||isLast==false){
     intialPage=OnBoardingScreen();
   }else{
     if(token ==null){
       intialPage =LoginScreen();
     }else{
       intialPage=LayOutScreen();
     }

}
  runApp( MyApp(intialPage: intialPage,));
}

class MyApp extends StatelessWidget {
  MyApp({required this.intialPage});
  Widget intialPage;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:(context)=>ShopCubit()..HomeGetData()..CatGetData() ..getFavData()..GetProfileData(),
      child: BlocConsumer<ShopCubit,ShopStates>(
        listener: (context,states){},
        builder: (context,states){
          return  MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              appBarTheme: AppBarTheme(
                color: Colors.white,
                elevation: 0.0,
              ),
            ),
            home: intialPage,
          );
        },

      ),
    );
  }
}

