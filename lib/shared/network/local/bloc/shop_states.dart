import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/models/user_model.dart';

abstract class ShopStates{}
 class initialState extends ShopStates{}
 class indexState extends ShopStates{}
 class LoginSuccessState extends ShopStates{
  UserModel? userModel;
LoginSuccessState({this.userModel});
 }
 class LoginErrorState extends ShopStates{}
 class LoginLoadingState extends ShopStates{}
 class changrNavBar extends ShopStates{}
class HomeSuccessState extends ShopStates{
 HomeModel? homeModel;
 HomeSuccessState({this.homeModel});
}
class HomeErrorState extends ShopStates{
 final String? error;
 HomeErrorState({this.error});
}
class HomeLoadingState extends ShopStates{}
class CatLoadingState extends ShopStates{}
class CatErrorState extends ShopStates{}
class CatSuccessState extends ShopStates{}
class GetFavLoadingState extends ShopStates{}
class GetFavErrorState extends ShopStates{}
class GetFavSuccessState extends ShopStates{}
class FavLoadingState extends ShopStates{}
class FavErrorState extends ShopStates{}
class FavSuccessState extends ShopStates{}
class ProfileLoadingState extends ShopStates{}
class ProfileErrorState extends ShopStates{}
class ProfileSuccessState extends ShopStates{}
class RegisterLoadingState extends ShopStates{}
class RegisterErrorState extends ShopStates{}
class RegisterSuccessState extends ShopStates{}
class UpdateLoadingState extends ShopStates{}
class UpdateErrorState extends ShopStates{}
class UpdateSuccessState extends ShopStates{}
class SearchLoadingState extends ShopStates{}
class SearchErrorState extends ShopStates{}
class SearchSuccessState extends ShopStates{}