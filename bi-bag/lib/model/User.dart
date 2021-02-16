class User {
  String id;
  String name;
  String surname;
  String email;
  String token;
  String phone;

  User({this.id, this.surname, this.name, this.email, this.token, this.phone});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    surname = json['surname'];
    email = json['email'];
    token = json['token'];
    phone = json['phone'];
  }
}
