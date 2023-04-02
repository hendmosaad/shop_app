import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/add_or_delete.dart';
import 'package:shop_app/models/category_model.dart';
import 'package:shop_app/models/getFavorites.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/models/search_model.dart';
import 'package:shop_app/models/user_model.dart';
import 'package:shop_app/models/user_register.dart';
import 'package:shop_app/modules/categories.dart';
import 'package:shop_app/modules/favorites.dart';
import 'package:shop_app/modules/home.dart';
import 'package:shop_app/modules/settings.dart';
import 'package:shop_app/shared/component/widgets/constatnts.dart';
import 'package:shop_app/shared/network/local/bloc/shop_states.dart';
import 'package:shop_app/shared/network/remote/dio/dio_helper.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(initialState());

  static ShopCubit get(context) => BlocProvider.of(context);
  List<Widget> ShopScreens = [Home(), Categories(), Favorites(), Settings()];
  int currentIndex = 0;

  changeNavBar(int index) {
    CatGetData();
    GetProfileData();
    getFavData();
    currentIndex = index;
    emit(changrNavBar());
    print(userModel!.status);

  }

  int index = 0;

  finishNavigation(index) {
    this.index = index;
    print(index);
    emit(indexState());
  }

  UserModel? userModel;

  void userLogin({required String email, required String password}) {
    emit(LoginLoadingState());
    DioHelper.postData(url: 'login', data: {
      'email': email,
      'password': password,
    }).then((value) {
      print(value.data);
      userModel = UserModel.fromJson(json: value.data);
      emit(LoginSuccessState(userModel: userModel));
    }).catchError((onError) {
      print("!!!!${onError}");
      emit(LoginErrorState());
    });
  }
  UserRegister ? userRegister;
  void userRegisters({required String name,required String email, required String password,required String phone}) {
    emit(RegisterLoadingState());
    DioHelper.postData(url: 'register', data: {
      'name': email,
      'email': email,
      'password': password,
      'phone': phone,
    }).then((value) {
      print(value.data);
      userRegister = UserRegister.fromJson(json: value.data);
      token=userRegister!.data!.token;
      emit(RegisterSuccessState());
    }).catchError((onError) {
      print("!!!!${onError}");
      emit(RegisterErrorState());
    });
  }
  void userUpdates({required String name,required String email,
    required String password,required String phone}) {
    emit(UpdateLoadingState());
    DioHelper.putData(
       url: 'update-profile',
        data: {
      'name': email,
      'email': email,
      'password': password,
      'phone': phone,
    }).then((value) {
      print(value.data);
      profileModel = UserModel.fromJson(json: value.data);
      token=profileModel!.data!.token;
      emit(UpdateSuccessState());
    }).catchError((onError) {
      print("!!!!${onError}");
      emit(UpdateErrorState());
    });
  }

  Map<int?, bool?> favorites = {};

  HomeModel? homeModel;

  void HomeGetData() {
    emit(HomeLoadingState());
    DioHelper.getData(url: 'home', token: token).then((value) {

      homeModel = HomeModel.froJson(json: value.data);
      homeModel!.data!.products.forEach((element) {
        favorites.addAll({element.id: element.in_favorites});
      });
      emit(HomeSuccessState(homeModel: homeModel));
    }).catchError((onError) {
      print(onError);
      emit(HomeErrorState(error: onError.toString()));
    });
  }

  CategoeyModel? catModel;

  void CatGetData() {
    emit(CatLoadingState());
    DioHelper.getData(url: 'categories', token: token).then((value) {
      catModel = CategoeyModel.fromjsom(json: value.data);
      emit(CatSuccessState());
    }).catchError((onError) {
      print(onError);
      emit(CatErrorState());
    });
  }

  GetFavorites? getFavorites;

  void getFavData() {
    emit(GetFavLoadingState());
    DioHelper.getData(url: 'favorites', token: token).then((value) {
      getFavorites = GetFavorites.fromJson(json: value.data);
      emit(GetFavSuccessState());
    }).catchError((onError) {
      print(onError);
      emit(GetFavErrorState());
    });
  }

  ChangeFav? changeFav;

  void ChangeFavs(productId) {
    favorites[productId] = !favorites[productId]!;
    emit(FavLoadingState());

    DioHelper.postData(url: 'favorites', data: {'product_id': productId})
        .then((value) {
      changeFav = ChangeFav.fromJson(json: value.data);
      if (!changeFav!.status!) {
        favorites[productId] = !favorites[productId]!;
      } else {
        getFavData();
      }

      emit(FavSuccessState());
    }).catchError((onError) {
      print(onError);
      emit(FavErrorState());
    });
  }

  UserModel? profileModel;

  void GetProfileData(){
    emit(ProfileLoadingState());
    DioHelper.getData(url: 'profile',token:token )
        .then((value) {
      profileModel=UserModel.fromJson(json: value.data);
      print('${profileModel!.data!.image}');
      emit(ProfileSuccessState());
    }).catchError((onError){
      print(onError);
      emit(ProfileErrorState());
    });

  }
  SearchModel? searchModel;
 void searchProducts({required String text}){
   emit(SearchLoadingState());

   DioHelper.postData(url: 'products/search',
      data: {
      'text':text
      },).then((value) {
        print(value.data.runtimeType);
      searchModel=SearchModel.fromJson(json: value.data);
        print(searchModel!.data!.data.length);

        emit(SearchSuccessState());
    }).catchError((onError){
      print(onError);
      emit(SearchErrorState());
    });
 }
}
