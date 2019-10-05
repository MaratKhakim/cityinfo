class User {
  String uid;
  String phoneNumber;
  String name;
  String surname;

  User({this.uid, this.phoneNumber, this.name, this.surname});

  User.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    phoneNumber = json['phoneNumber'];
    name = json['name'];
    surname = json['surname'];
  }

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'phoneNumber': phoneNumber,
        'name': name,
        'surname': surname,
      };
}
