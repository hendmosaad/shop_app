class UserRegister{
  bool? status;
  String? messege;
  Data ? data;
  UserRegister.fromJson({required Map<dynamic,dynamic>json}){
    this.status=json['status'];
    this.messege=json['smessegetatus'];
    this.data= json['data']==null?null:Data.fromJson(json: json['data']);

  }
}
class Data{
  String? name;
  String? email;
  String  image ="https://student.valuxapps.com/storage/assets/defaults/user.jpg";
  String? token;
  String? phone;

  Data.fromJson({required Map<dynamic,dynamic>json}){
    this.name=json['name'];
    this.email=json['email'];
    this.image=json['image'];
    this.token=json['token'];
    this.phone=json['phone'];

  }
}