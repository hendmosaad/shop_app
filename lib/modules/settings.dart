import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/login_screen.dart';
import 'package:shop_app/shared/component/widgets/project_items.dart';
import 'package:shop_app/shared/network/local/bloc/shop_cubit.dart';
import 'package:shop_app/shared/network/local/bloc/shop_states.dart';
import 'package:shop_app/shared/network/local/shared_pref/shared_pref.dart';

class Settings extends StatelessWidget {
  Settings({Key? key}) : super(key: key);
TextEditingController nameController=TextEditingController();
TextEditingController emailController=TextEditingController();
TextEditingController phoneController=TextEditingController();
TextEditingController passwordController=TextEditingController();
var formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){

      },
      builder: (context,state){
        var Model=ShopCubit.get(context).profileModel;

            nameController.text=Model!.data!.name! ;
            emailController.text=Model!.data!.email!;
            phoneController.text=Model!.data!.phone!;


        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  if(state is UpdateLoadingState)
                  LinearProgressIndicator(),
                  SizedBox(height: 50,),
                  SettingsField(label: 'name',TextFormLabelColor: Colors.black45,controller: nameController, function: (value) {

                  }, prefixIcon: Icon(Icons.person)),
                  SizedBox(height: 30,),
                  SettingsField(label: 'email',TextFormLabelColor: Colors.black45,controller:emailController , function: (value) {  }, prefixIcon: Icon(Icons.email)),
                  SizedBox(height: 30,),
                  SettingsField(label: 'phone',TextFormLabelColor: Colors.black45,controller:phoneController , function: (value) {  }, prefixIcon: Icon(Icons.phone)),
                  SizedBox(height: 30,),
                  SettingsField(label: 'password',TextFormLabelColor: Colors.black45,controller:passwordController , function: (value) {  }, prefixIcon: Icon(Icons.key)),
                  SizedBox(height: 30,),
                  OurMaterialButton(
                    function: () {
                    if(formKey.currentState!.validate())
                      {
                        CacheHelper.removeData(key: 'token').then((value){
                          Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context)=>LoginScreen()), (route) => false);
                        });
                      }

                  } ,

                    text: 'Log Out',
                    height: 40,

                  ),
                  SizedBox(height: 30,),
                  OurMaterialButton(
                    function: () {
                    if(formKey.currentState!.validate()){
                      ShopCubit.get(context).userUpdates(
                          name:nameController.text, email: emailController.text,
                          password: passwordController.text, phone: phoneController.text);
                    }
                  } ,

                    text: 'Update',
                    height: 40,

                  ),


                ],
              ),
            ),
          ),
        );
      },
    );
  }
}