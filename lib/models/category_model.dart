class CategoeyModel{
  bool? status;
  CategoryData? data;
  CategoeyModel.fromjsom({required Map<String,dynamic>json}){
    this.status =json['status'];
    this.data=CategoryData.fromJson(json:json['data']);

  }
}
class CategoryData{
  int?current_page;
  List<Data> data=[];
  CategoryData.fromJson({required Map<String,dynamic>json}){
    this.current_page=json['current_page'];
   json['data'].forEach((e){
    data.add( Data.fromJson(json:e));
});
  }
}
class Data {
  int? id;
  String? name;
  String? image;
  Data.fromJson({required Map<String,dynamic>json}){
    this.id=json['id'];
    this.name=json['name'];
    this.image=json['image'];
  }


}