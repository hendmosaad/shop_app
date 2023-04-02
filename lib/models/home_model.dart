class HomeModel{
  bool ?status;
  HomeData? data;
  HomeModel.froJson({required Map<String ,dynamic>json}){
   this. status=json['status'];
   this. data=HomeData.fromJson(json: json['data']);
  }
}
class HomeData{
  List<banersModel> banners=[];
  List <productsModel>products=[];
  HomeData.fromJson({required Map<String,dynamic>json}){
    json['banners'].forEach((e){
      banners.add(banersModel.fromJson(json: e));
    });
    json['products'].forEach((e){
      products.add(productsModel.fromJson(json: e));
    });
  }

}
class banersModel{
  int? id;
  String? image;
  banersModel.fromJson({required Map<String,dynamic>json}){
this.id =json['id'];
this.image =json['image'];
  }
}
class productsModel{
  int? id;
  String? description;
  dynamic? price;
  dynamic? old_price;
  dynamic? discount;
  String? image;
  bool? in_favorites;
  bool? in_cart;
  productsModel.fromJson({required Map<String,dynamic>json}){
    this.id =json['id'];
    this.price =json['price'];
    this.old_price =json['old_price'];
    this.discount =json['discount'];
    this.image =json['image'];
    this.description =json['description'];
    this.in_favorites=json['in_favorites'];
    this.in_cart=json['in_cart'];
  }
}