import 'package:hello_word/model/User.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  void saveUser(User user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("id", user.id);
    prefs.setString("name", user.name);
    prefs.setString("surname", user.surname);
    prefs.setString("email", user.email);
    prefs.setString("phone", user.phone);
    prefs.setString("token", user.token);
  }

  Future<User> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String id = prefs.getString("id");
    String name = prefs.getString("name");
    String surname = prefs.getString("surname");
    String email = prefs.getString("email");
    String phone = prefs.getString("phone");
    String token = prefs.getString("token");

    return User(
        id: id,
        name: name,
        surname: surname,
        email: email,
        phone: phone,
        token: token);
  }

  void removeUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove("id");
    prefs.remove("name");
    prefs.remove("surname");
    prefs.remove("email");
    prefs.remove("phone");
    prefs.remove("token");
  }

  Future<String> getToken(args) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");
    return token;
  }
}
