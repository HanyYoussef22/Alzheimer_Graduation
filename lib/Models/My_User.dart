class MyUser {
  static const String CollecationName = 'user';
  String id;
  String fName;
  String email;
  String? image;
  String? phone;
  String? birthDate;
  String? registerDate;
  List<dynamic> listimageurl;

  MyUser({
    required this.id,
    required this.fName,
    required this.email,
    this.phone,
    this.image,
    this.registerDate,
    this.birthDate,
    required this.listimageurl,

  });

  MyUser.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'],
          fName: json['fName'],
          email: json['email'],
          phone: json['phone'],
          image: json['image'],
          birthDate: json['birthDate'],
          registerDate: json['registerDate'],

          listimageurl: json['listimageurl'],

  );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fName': fName,
      'email': email,
      'image': image,
      'phone': phone,
      'registerDate': registerDate,
      'birthDate': birthDate,
      'listimageurl': listimageurl,

    };
  }
}
