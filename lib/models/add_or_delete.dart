class ChangeFav{
  bool? status;
   ChangeFav.fromJson({required Map<String,dynamic>json}){
     this.status=json['status'] ;
   }
}
