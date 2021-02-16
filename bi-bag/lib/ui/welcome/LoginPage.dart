import 'package:flutter/material.dart';
import 'package:hello_word/model/User.dart';
import 'package:hello_word/provider/AuthProvider.dart';
import 'package:hello_word/provider/UserProvider.dart';
import 'package:hello_word/ui/DashboardPage.dart';
import 'package:hello_word/values/Strings.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String _username, _password;

  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);

    final _entryEmailField = Container(
        child: TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration: new InputDecoration(
          labelText: Strings.email,
          border: InputBorder.none,
          filled: true,
          hintText: Strings.email,
          hintStyle: TextStyle(color: Colors.grey),
          fillColor: Colors.grey[350]),
      validator: (value) {
        if (value.isEmpty) {
          return Strings.validationEmail;
        }
        return null;
      },
      onSaved: (value) => _username = value,
    ));

    final _entryPasswordField = Container(
        child: TextFormField(
      obscureText: true,
      decoration: new InputDecoration(
          labelText: Strings.password,
          border: InputBorder.none,
          filled: true,
          hintText: Strings.password,
          hintStyle: TextStyle(color: Colors.grey),
          fillColor: Colors.grey[350]),
      validator: (value) {
        if (value.isEmpty) {
          return Strings.validationPassword;
        }
        return null;
      },
      onSaved: (value) => _password = value,
    ));

    final _submitButton = Container(
      child: RaisedButton(
        onPressed: () {
          final form = _formKey.currentState;
          if (form.validate()) {
            form.save();
            loginRequest(auth);
          }
        },
        padding: const EdgeInsets.all(0.0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(vertical: 13),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey.shade200,
                    offset: Offset(2, 4),
                    blurRadius: 5,
                    spreadRadius: 2)
              ],
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Color(0xfffbb448), Color(0xfff7892b)])),
          child: Text(
            Strings.login,
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
      ),
    );

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context, true);
              }),
          title: Text(Strings.login),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              height: MediaQuery.of(context).size.height,
              child: auth.loggedInStatus == Status.Authenticating
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _entryEmailField,
                        SizedBox(height: 20),
                        _entryPasswordField,
                        SizedBox(height: 20),
                        _submitButton,
                      ],
                    ),
            ),
          ),
        ));
  }

  void loginRequest(AuthProvider auth) {
    final Future<Map<String, dynamic>> successfulMessage =
        auth.login(_username, _password);

    successfulMessage.then((response) {
      if (response['status']) {
        User user = response['user'];
        Provider.of<UserProvider>(context, listen: false).setUser(user);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => DashboardPage()));
      } else {}
    });
  }
}
