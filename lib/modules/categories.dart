import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/network/local/bloc/shop_cubit.dart';
import 'package:shop_app/shared/network/local/bloc/shop_states.dart';

class Categories extends StatelessWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state){
        return Scaffold(
        body:  ListView.separated(itemBuilder: (context,index)=>CatScreenItem(context,index),
            separatorBuilder: (context,index)=>SizedBox(height: 20,),
            itemCount:ShopCubit.get(context).catModel!.data!.data.length)
        );
      },
    );
  }}
CatScreenItem(context,index)=>Padding(
  padding: const EdgeInsets.all(15.0),
  child: Row (
    children: [
      Image(
          height: 100,
          width: 100,
          image: NetworkImage('${ShopCubit.get(context).catModel!.data!.data[index].image}')),
      SizedBox(width: 20,),
      Text('${ShopCubit.get(context).catModel!.data!.data[index].name}'),
      Spacer(),
      IconButton(onPressed: (){}, icon: Icon(Icons.arrow_forward,size: 25,))
    ],
  ),
);