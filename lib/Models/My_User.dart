class MyUser {
  static const String CollecationName = 'user';
  String id;
  String fName;
  String email;

  MyUser({required this.id,
    required this.fName,
    required this.email});

  MyUser.fromJson(Map<String, dynamic> json)
      : this(
    id: json['id'] as String,
    fName: json['fName'] as String,
    email: json['email'] as String,
  );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fName': fName,
      'email': email,
    };
  }
}
