import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/getFavorites.dart';
import 'package:shop_app/shared/network/local/bloc/shop_cubit.dart';
import 'package:shop_app/shared/network/local/bloc/shop_states.dart';

class Favorites extends StatelessWidget {
  const Favorites({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (Context,state){},
      builder: (Context,state){
        return Scaffold(
          body:ConditionalBuilder(
            builder:(context)=> ListView.separated(
              scrollDirection: Axis.vertical,
                itemBuilder:(context,index)=>FavoritesItem(context: context,index:index,getFavorites: ShopCubit.get(Context).getFavorites!) ,
                separatorBuilder: (context,index)=>Container(height: 1,width: double.infinity,color: Colors.grey,),
                itemCount: ShopCubit.get(context).getFavorites!.data!.data.length ),
            condition:ShopCubit.get(context).getFavorites != null || state is!  GetFavLoadingState  ,
            fallback: (context)=>Center(child: CircularProgressIndicator(),),
          ),
        );
      },
    );
  }}
FavoritesItem({required GetFavorites getFavorites,required context,required index})=>
    Row(
  children: [
    Expanded(
      flex: 1,
      child: Stack(
        alignment: AlignmentDirectional.bottomStart,
        children: [
          Image(
              height: 150,
              width: 150,
              fit: BoxFit.cover,
              image: NetworkImage(
                '${getFavorites.data!.data[index].product!.image}',
              )),
          if (getFavorites.data!.data[index].product!.discount != 0)
          Container(
              child: Text(
                'discount',
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
              color: Colors.red,
            )
        ],
           ),
    ),
    SizedBox(width: 15,),
    Expanded(
      flex: 3,
      child: Container(
        height:150,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '${getFavorites.data!.data[index].product!.description}',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Text('${getFavorites.data!.data[index].product!.price}',
                    style: TextStyle(color: Colors.blue)),
                SizedBox(
                  width: 5,
                ),
                Text('${getFavorites.data!.data[index].product!.old_price}',
                    style: TextStyle(
                        decoration: TextDecoration.lineThrough,
                        color: Colors.grey)),
                Spacer(),
                IconButton(onPressed: (){
                  ShopCubit.get(context).ChangeFavs(ShopCubit.get(context).getFavorites!.data!.data[index].product!.id);
                },
                  icon: ShopCubit.get(context).favorites[getFavorites.data!.data[index].product!.id]! ?
                  CircleAvatar(
                    backgroundColor: Colors.blueGrey[800],
                    radius: 16,
                    child: Icon(Icons.favorite_border_outlined,color: Colors.white,size: 15,),)
                      :CircleAvatar(
                    backgroundColor: Colors.grey,
                    radius: 16,
                    child: Icon(Icons.favorite_border_outlined,color: Colors.white,size: 15,),)
                  ,
                  padding: EdgeInsets.zero
                  ,)
              ],
            )
          ],
        ),
      ),
    ),

  ],
);