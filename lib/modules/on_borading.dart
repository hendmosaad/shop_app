import 'dart:ffi';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/ui_model.dart';
import 'package:shop_app/modules/login_screen.dart';
import 'package:shop_app/shared/component/widgets/project_items.dart';
import 'package:shop_app/shared/network/local/bloc/shop_cubit.dart';
import 'package:shop_app/shared/network/local/bloc/shop_states.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/shared/network/local/shared_pref/shared_pref.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatelessWidget {
  OnBoardingScreen({Key? key}) : super(key: key);
  List<onBordingModel> onBoardingList = [
    onBordingModel(
        image: 'assets/images/OIP.jpg', title: 'browse the products'),
    onBordingModel(
        image: 'assets/images/dropshipping.jpg',
        title: 'make your favorite list'),
    onBordingModel(
        image: 'assets/images/real-estate.png', title: 'order what you want'),
  ];

  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            actions: [
              TextButton(
                  onPressed: () {
                    CacheHelper.putData(key: 'isLast', value: true)
                        .then((value) {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                        (route) => false,
                      );
                    });
                  },
                  child: Text(
                    'Skip',
                    style: TextStyle(color: Colors.blueGrey[800]),
                  ))
            ],
          ),
          body: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    itemBuilder: (context, index) {
                      ShopCubit.get(context).index=index;
                      return  OnBordingItem(obBoardingItem: onBoardingList[index]);
                    }
                       ,
                    itemCount: 3,
                    controller: pageController,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.only(start: 20, end: 20),
                  child: Row(
                    children: [
                      SmoothPageIndicator(
                          controller: pageController,
                          count: 3,
                          axisDirection: Axis.horizontal,
                          effect: SlideEffect(
                              spacing: 8.0,
                              radius: 4.0,
                              dotWidth: 25.0,
                              dotHeight: 10.0,
                              paintStyle: PaintingStyle.stroke,
                              strokeWidth: 1.5,
                              dotColor: Colors.grey,
                              activeDotColor: Colors.blueGrey[800]!),



                      ),
                      Spacer(),
                      FloatingActionButton(
                        backgroundColor: Colors.blueGrey[800],
                          onPressed: (){

                            pageController.nextPage(duration: Duration(microseconds: 200), curve: Curves.easeInOutCubicEmphasized,).then((value) {
                              if(ShopCubit.get(context).index==onBoardingList.length-1){
                                CacheHelper.putData(key: 'isLast', value: true)
                                    .then((value) {
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(builder: (context) => LoginScreen()),
                                        (route) => false,
                                  );
                                });
                              }
                            });
                          },
                        child: Icon(Icons.arrow_forward,color: Colors.white,),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
