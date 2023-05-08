class MyUser {
  static const String CollecationName = 'user';
  String id;
  String fName;
  String email;
  List<dynamic> listimageurl;

  MyUser({required this.id,
    required this.fName,
    required this.email,
    required this.listimageurl,
  });

  MyUser.fromJson(Map<String, dynamic> json)
      : this(
    // imageurl: json['imageurl']
    id: json['id'] as String,
    fName: json['fName'] as String,
    email: json['email'] as String,
    listimageurl: json['listimageurl'],

  );

  Map<String, dynamic> toJson() {
    return {
      // 'imageurl': imageurl,
      'id': id,
      'fName': fName,
      'email': email,
      'listimageurl': listimageurl,
    };
  }
}
