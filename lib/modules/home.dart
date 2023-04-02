import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/category_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/shared/network/local/bloc/shop_cubit.dart';
import 'package:shop_app/shared/network/local/bloc/shop_states.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){
      },
      builder: (context,state){
        return SafeArea(
          child: Scaffold(
            body: ConditionalBuilder(
              fallback:(context) =>Center(child: CircularProgressIndicator())  ,
              condition:ShopCubit.get(context).homeModel !=null  &&ShopCubit.get(context).catModel !=null ,
              builder:(context) => homeItem(ShopCubit.get(context).homeModel!,ShopCubit.get(context).catModel!,context),
            ),
          ),
        );
      },
    );
  }
  
  Widget CatItem(CategoeyModel catModel,int index)=> Stack(
    alignment: AlignmentDirectional.bottomStart,
    children: [
      Image(image: NetworkImage('${catModel.data!.data[index].image}'),
        height: 100,
        width: 100,
        fit: BoxFit.cover,
      ),
      Container(
          width: 100,
          color: Colors.black.withOpacity(.5),
          child: Text('${catModel.data!.data[index].name}',style: TextStyle(color: Colors.white),))
    ],
  );
 Widget homeItem(HomeModel homeModel,CategoeyModel catModel,context)=>
      SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           CarouselSlider.builder(
               itemCount: homeModel.data!.banners.length,

               itemBuilder: (context,index,x)=>bannerItem(homeModel, index), options:CarouselOptions(
             autoPlay: true,
             height: 200,
             viewportFraction: 1.0,
             aspectRatio: 1.0,
             autoPlayCurve: Curves.linearToEaseOut,
             autoPlayInterval: Duration(milliseconds: 500),
           )),
            SizedBox(height:10,),
            Padding(
             padding: const EdgeInsetsDirectional.symmetric(horizontal: 20.0),
             child: Text('categories',style: TextStyle(color: Colors.black,fontSize: 22),),
           ),
            Container(
             height: 100,
             child: ListView.separated(
               shrinkWrap: true,
               scrollDirection: Axis.horizontal,
                 itemBuilder: (context,index)=>CatItem(
                     catModel,index),
                 separatorBuilder: (context,index)=>SizedBox(width: 5,),
                 itemCount: catModel.data!.data.length),
           ),
            SizedBox(height:30,),
            Padding(
              padding: const EdgeInsetsDirectional.symmetric(horizontal: 20.0),
              child: Text('Products',style: TextStyle(color: Colors.black,fontSize: 22),),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                color: Colors.grey,
                child: GridView.count(

                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: List.generate(homeModel.data!.products.length , (index) => productItem(homeModel, index,context)),

                      crossAxisCount: 2,
                      childAspectRatio: 1/1.58,
                      mainAxisSpacing:.5,
                       crossAxisSpacing:2 ,

                  ),

                ),
              ),

          ],
        ),
      );
 Widget bannerItem(HomeModel homeModel,int index)=>
      Image(image: NetworkImage(
        '${homeModel.data!.banners[index].image}'
      ));

  Widget productItem(HomeModel homeModel, index,context) {
    print('!!!${homeModel.data!.products.length}');
    return Column(
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
              height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                image: NetworkImage(
              '${homeModel.data!.products[index].image}',
            )),
            if (homeModel.data!.products[index].discount != 0)
              Container(
                child: Text(
                  'discount',
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
                color: Colors.red,
              )
          ],
        ),
        Container(
          padding: EdgeInsets.all(8.0),
          color: Colors.white,
          child: Column(
            children: [
              Text(
                '${homeModel.data!.products[index].description}',
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Text('${homeModel.data!.products[index].price}',
                      style: TextStyle(color: Colors.blue)),
                  SizedBox(
                    width: 5,
                  ),
                  Text('${homeModel.data!.products[index].old_price}',
                      style: TextStyle(
                          decoration: TextDecoration.lineThrough,
                          color: Colors.grey)),
                  Spacer(),
                  IconButton(onPressed: (){
                    ShopCubit.get(context).ChangeFavs(ShopCubit.get(context).homeModel!.data!.products[index].id);
                  },
                    icon: ShopCubit.get(context).favorites[homeModel.data!.products[index].id!]! ?
                    CircleAvatar(
                      backgroundColor:  Colors.blueGrey[800],
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
        )
      ],
    );
  }
}


