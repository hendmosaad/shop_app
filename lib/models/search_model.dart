class SearchModel{
bool? status;
Data? data;
SearchModel.fromJson({required Map<String,dynamic>json}){
  this.status=json['status'];
  this.data= json['data']==null?null:Data.fromJson(json: json['data']);
}

}
class Data{

  List <ProductData> data=[];
  Data.fromJson({required Map<String,dynamic>json}){
    json['data'].forEach((e){
      data.add(ProductData.fromJson(json: e));
    });
  }
}
class ProductData{
  int? id;
 dynamic? price;
 String? image;
 String? name;
 String? description;
 bool ? in_favorites;
 bool? in_cart;
 ProductData.fromJson({required Map<String,dynamic>json}){
   this.id=json['id'];
   this.price=json['price'];
   this.image=json['image'];
   this.name=json['name'];
   this.description=json['description'];
   this.in_favorites=json['in_favorites'];
   this.in_cart=json['in_cart'];
 }
}