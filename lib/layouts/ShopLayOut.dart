import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/search_screen.dart';
import 'package:shop_app/shared/network/local/bloc/shop_cubit.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/shared/network/local/bloc/shop_states.dart';
class LayOutScreen extends StatelessWidget {
  const LayOutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state){
        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(onPressed: (){
                Navigator.push(context,MaterialPageRoute(builder: (context)=>SearchScreen()));
              }, icon: Icon(Icons.search,color: Colors.black45,))
            ],
          ),
          body: ShopCubit.get(context).ShopScreens[ShopCubit.get(context).currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: Colors.blueGrey[500],
            unselectedItemColor: Colors.grey,
            currentIndex: ShopCubit.get(context).currentIndex,
            onTap: (index){
              ShopCubit.get(context).changeNavBar(index);
            },
            items: [
              BottomNavigationBarItem(icon:Icon(Icons.home),label: 'Home'),
              BottomNavigationBarItem(icon:Icon(Icons.category),label: 'category'),
              BottomNavigationBarItem(icon:Icon(Icons.favorite_border),label: 'Favorites'),
              BottomNavigationBarItem(icon:Icon(Icons.settings),label: 'settings'),
            ],
          ),
        );
      },
    );
  }
}