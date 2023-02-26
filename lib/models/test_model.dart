class TestModel{
  String? name;
  String? date;
  String? image;
  String? status;

  TestModel({
    this.date,
    this.name,
    this.image,
    this.status,
  });

  TestModel.fromJson(Map<String,dynamic>json){
    date=json['date'];
    name=json['name'];
    image =json['image'];
    status =json['status'];
  }
  Map<String,dynamic>toMap(){
    return{
      'name':name,
      'date':date,
      'image':image,
      'status':status,
    };
  }
}