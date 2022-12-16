// class name model
class UserModel {
  // List of class Data
  List<Data>? data;

  // transform from json to dart
  // UserModel will be used fromJson function
  // to convert json to dart Object in json will be Map
  // get data <String, dynamic> key, value
  //
  UserModel.fromJson(Map<String, dynamic> json) {
    data = [];

    json['data'].forEach((element) {
      data!.add(Data.fromJson(element));
    });
  }
}

class Data {
  int? id;
  String? firstName;
  String? lastName;
  String? avatar;
  String? email;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    avatar = json['avatar'];
    email = json['email'];
  }
}
