import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:shop_app/models/search_model.dart';
import 'package:shop_app/shared/network/local/bloc/shop_cubit.dart';
import 'package:shop_app/shared/network/local/bloc/shop_states.dart';
class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);
TextEditingController searchController=TextEditingController();
var formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
        listener: (context,states){},
        builder: (context,states){
          return  Scaffold(
            body: Form(
              key: formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.only(top: 40,start: 20,end: 20,bottom: 20),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey[200],
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey[300]! ,
                                blurRadius: 30,
                                spreadRadius: 1.0,
                                inset: false

                            ),

                          ]
                      ),
                      child:   TextFormField(
                        onFieldSubmitted: (text){
                          ShopCubit.get(context).searchProducts(text: text);
                        },
                        controller: searchController,
                        validator: (value){
                          if(value!.isEmpty)
                          {
                            return 'this field mustn\'t be empty';
                          }
                        },
                        decoration: InputDecoration(
                            border:OutlineInputBorder(
                                gapPadding: 4.0
                            ),
                            prefixIcon: Icon(Icons.search),
                            labelText: 'search',

                            labelStyle: TextStyle(color: Colors.black45)),
                      ),
                    ),

                  ),
                  Expanded(
                    child: ConditionalBuilder(
                        condition:states !is SearchLoadingState && ShopCubit.get(context).searchModel != null ,
                        builder: (context)=>ListView.separated(
                          itemBuilder:(context,index)=>productItem(ShopCubit.get(context).searchModel!,context,index) ,
                          itemCount:ShopCubit.get(context).searchModel!.data!.data!.length ,
                          separatorBuilder: (context,index)=>Container(height: 1,
                            width: double.infinity,color: Colors.grey,),
                        ),
                        fallback:(context)=>Center(child: CircularProgressIndicator(),)),
                  )


                ],
              ),
            ),
          );

        }
    );
  }
  Widget productItem( SearchModel searchModel, index,context) {
    print('!!!${searchModel.data!.data.length}');
    return Column(
      children: [
        Container(
          height: 200,
          child: Image(
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
              image: NetworkImage(
                '${searchModel.data!.data[index].image}',
              )),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(8.0),
            color: Colors.white,
            child: Column(
              children: [
                Text(
                  '${searchModel.data!.data[index].description}',
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Text('${searchModel.data!.data[index].price}',
                        style: TextStyle(color: Colors.blue)),
                    SizedBox(
                      width: 5,
                    ),

                    Spacer(),
                    IconButton(onPressed: (){
                      ShopCubit.get(context).ChangeFavs(ShopCubit.get(context).searchModel!.data!.data[index].id);
                    },
                      icon: ShopCubit.get(context).favorites[searchModel.data!.data[index]!.id!]! ?
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
          ),
        )
      ],
    );
  }
}
