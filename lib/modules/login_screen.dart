import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layouts/ShopLayOut.dart';
import 'package:shop_app/modules/register_screen.dart';
import 'package:shop_app/shared/component/icons/icons.dart';
import 'package:shop_app/shared/component/widgets/constatnts.dart';
import 'package:shop_app/shared/component/widgets/project_items.dart';
import 'package:shop_app/shared/network/local/bloc/shop_cubit.dart';
import 'package:shop_app/shared/network/local/bloc/shop_states.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/shared/network/local/shared_pref/shared_pref.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if(state is LoginSuccessState){
          if(state.userModel!.status==true) {
            CacheHelper.putData(key: 'token', value: state.userModel!.data!.token).
            then((value) {
              token=state.userModel!.data!.token;
              CacheHelper.putData(key: 'status', value: true).then((value) {
                status= state.userModel!.status;
              });
              Navigator.push(context,
               MaterialPageRoute(builder: (context) => LayOutScreen()));
            });

          }
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blueGrey[800],
            elevation: 0.0,
          ),
          backgroundColor: Colors.blueGrey[800],
          body: SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsetsDirectional.only(start: 20, end: 20, top: 50),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome back',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .copyWith(
                              color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      'login now to browse our new offers',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: Colors.grey),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    LoginOrRegister(
                        prefixIcon: email,
                        controller: emailController,
                        function: ( value) {
                          if (value.isEmpty) {
                      return   'this field mustn\'t beee empty';
                          }
                        },
                        label: 'email',
                        TextFormLabelColor: Colors.white),
                    SizedBox(
                      height: 30,
                    ),
                    LoginOrRegister(
                        suffixIcon: eye,
                        prefixIcon: password,
                        controller: passwordController,
                        function: (value) {
                          if (value.toString().isEmpty) {
                            return   'this field mustn\'t be empty';
                          }
                        },
                        label: 'password',
                        TextFormLabelColor: Colors.white),
                    SizedBox(
                      height: 30,
                    ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: ConditionalBuilder(
                      builder: (context)=>OurMaterialButton(
                          height: 40,
                          width: 300,
                          function: (){
                            if(formKey.currentState!.validate()){
                              ShopCubit.get(context).userLogin(email: emailController.text, password:passwordController.text);
                            }
                          }, text: 'login'),
                      condition:state is !LoginLoadingState ,
                      fallback: (context)=>Center(child: CircularProgressIndicator()),
                    ),
                  ),
                    SizedBox(height: 20,),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('don\'t have an account',style: TextStyle(color: Colors.white),),
                          SizedBox(width: 20,),
                         TextButton(onPressed: (){
                           Navigator.push(context, MaterialPageRoute(builder: (context)=>RegisterScreen()));

                         }, child:  Text('register',style: TextStyle(color: Colors.grey),)),

                        ],
                      ),
                    )

                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
