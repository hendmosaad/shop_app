import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layouts/ShopLayOut.dart';
import 'package:shop_app/shared/component/icons/icons.dart';
import 'package:shop_app/shared/component/widgets/project_items.dart';
import 'package:shop_app/shared/network/local/bloc/shop_cubit.dart';
import 'package:shop_app/shared/network/local/bloc/shop_states.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if(state is RegisterSuccessState){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>LayOutScreen()));
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
                      'Hello ',
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
                      'Register now to browse our new offers',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: Colors.grey),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    LoginOrRegister(
                        prefixIcon: text,
                        controller: nameController,
                        function: (value) {
                          if (value.toString().isEmpty) {
                            print('this field mustn\'t be empty');
                          }
                        },
                        label: 'name',
                        TextFormLabelColor: Colors.white),
                    SizedBox(
                      height: 20,
                    ),
                    LoginOrRegister(
                        prefixIcon: email,
                        controller: emailController,
                        function: (value) {
                          if (value.toString().isEmpty) {
                            print('this field mustn\'t be empty');
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
                            print('this field mustn\'t be empty');
                          }
                        },
                        label: 'password',
                        TextFormLabelColor: Colors.white),
                    SizedBox(
                      height: 30,
                    ),
                    LoginOrRegister(
                        prefixIcon: phone,
                        controller: phoneController,
                        function: (value) {
                          if (value.toString().isEmpty) {
                            print('this field mustn\'t be empty');
                          }
                        },
                        label: 'phone',
                        TextFormLabelColor: Colors.white),
                    SizedBox(
                      height: 30,
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: OurMaterialButton(
                          height: 40,
                          width: 300,
                          function: (){
                            if(formKey.currentState!.validate()){
                              ShopCubit.get(context).userRegisters(
                               email: emailController.text,
                               name: nameController.text,
                               phone: phoneController.text,
                               password: passwordController.text,
                               );

                            }
                          }, text: 'Register'),
                    ),
                    SizedBox(height: 20,),

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
