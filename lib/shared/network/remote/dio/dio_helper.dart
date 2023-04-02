import 'package:dio/dio.dart';
import 'package:shop_app/shared/component/widgets/constatnts.dart';

class DioHelper{
  static Dio ? dio;
  static init(){
    dio=Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,

      )
    );
  }

static Future<Response> getData({
    required String url,
   Map<String,dynamic>?queryParameters,
   String?token,
     })async{
  dio!.options.headers={
    'Content-Type':'application/json',
     'lang':'en',
     'Authorization':'${token}'??'',
  };
   return await dio!.get(url,queryParameters: queryParameters);
}
  static Future<Response> postData({
    required String url,
    Map<String,dynamic>?queryParameters,
    required Map<String,dynamic>?data
  })async{
    dio!.options.headers={
      'Content-Type':'application/json',
      'lang':'en',
      'Authorization':'${token}'??'',
    };
    return  dio!.post(url,queryParameters: queryParameters,data: data);
  }
  static Future<Response> putData({
    required String url,
    Map<String,dynamic>?queryParameters,
    required Map<String,dynamic>?data
  })async{
    dio!.options.headers={
      'Content-Type':'application/json',
      'lang':'ar',
      'Authorization':'${token}'??'',
    };
    return  dio!.put(url,queryParameters: queryParameters,data: data);
  }
}
