class GetFavorites{
  bool ?status;
  Data ?data;
  GetFavorites.fromJson({required Map<String ,dynamic>json}){
    this.status=json['status'];
    this.data=Data.fromJson(json: json['data']);
  }
}
class Data{
  List<ProductData>data=[];
Data.fromJson({required Map<String ,dynamic>json}){
  json['data'].forEach((element){
    data.add(ProductData.fromJson(json: element));
  });
}
}
class ProductData{
Product? product;
ProductData.fromJson({required Map<String ,dynamic>json}){
  this.product=Product.fromJson(json:json['product']);
}
}
class Product{
  int? id;
  dynamic price;
  dynamic old_price;
  dynamic discount;
  String ?image;
  String ?name;
  String ?description;

Product.fromJson({required Map<String,dynamic>json})
{
  this.id=json['id'];
  this.price=json['price'];
  this.old_price=json['old_price'];
  this.discount=json['discount'];
  this.image=json['image'];
  this.name=json['name'];
  this.description=json['description'];
 }

}