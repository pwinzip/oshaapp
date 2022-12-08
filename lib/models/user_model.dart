class UserModel {
  String email;
  String firstname;
  String lastname;
  String prefix;
  String profileImgUrl;
  String tel;
  String type;

  UserModel(
      {required this.email,
      required this.firstname,
      required this.lastname,
      required this.prefix,
      required this.profileImgUrl,
      required this.tel,
      required this.type});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        email: json["email"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        prefix: json["prefix"],
        profileImgUrl: json["profile_imgUrl"],
        tel: json["tel"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "firstname": firstname,
        "lastname": lastname,
        "prefix": prefix,
        "profile_imgUrl": profileImgUrl,
        "tel": tel,
        "type": type,
      };
}
