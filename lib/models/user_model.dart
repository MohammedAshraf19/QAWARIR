class UserModel{
  String? name;
  String? uId;
  String? email;
  String? image;

  UserModel({
    this.uId,
    this.email,
    this.name,
    this.image,
  });

  UserModel.fromJson(Map<String,dynamic>json){
    email=json['email'];
    uId=json['uId'];
    name=json['name'];
    image =json['image'];
  }
  Map<String,dynamic>toMap(){
    return{
      'name':name,
      'email':email,
      'uId':uId,
      'image':image,
    };
  }
}