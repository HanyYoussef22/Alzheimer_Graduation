class UserModel {
  String? name;
  String? email;
  String? uId;
  String? image;
  String? phone;

  UserModel({
    required this.uId,
    required this.email,
    required this.name,
    required this.image,
    required this.phone,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    uId = json['uId'];
    image = json['image'];
    phone = json['phone'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'uId': uId,
      'image': image,
      'phone': phone,
    };
  }
}
