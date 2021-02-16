import 'package:flutter/material.dart';
import 'package:hello_word/provider/AuthProvider.dart';
import 'package:hello_word/ui/welcome/loginPage.dart';
import 'package:hello_word/values/Strings.dart';

import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  String _userName, _userSurname, _userEmail, _userPassword, _userPhone;

  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);

    final _entryUserNameField = Container(
        child: TextFormField(
      onSaved: (value) => _userName = value,
      decoration: new InputDecoration(
          labelText: Strings.username,
          border: InputBorder.none,
          filled: true,
          hintText: Strings.username,
          hintStyle: TextStyle(color: Colors.grey),
          fillColor: Colors.grey[350]),
    ));

    final _entryUserSurnameField = Container(
        child: TextFormField(
      onSaved: (value) => _userSurname = value,
      decoration: new InputDecoration(
          labelText: Strings.userSurname,
          border: InputBorder.none,
          filled: true,
          hintText: Strings.userSurname,
          hintStyle: TextStyle(color: Colors.grey),
          fillColor: Colors.grey[350]),
    ));

    final _entryEmailField = Container(
        child: TextFormField(
      onSaved: (value) => _userEmail = value,
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
    ));

    final _entryPasswordField = Container(
        child: TextFormField(
      onSaved: (value) => _userPassword = value,
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
    ));

    final _entryGsmNoField = Container(
        child: TextFormField(
      onSaved: (value) => _userPhone = value,
      keyboardType: TextInputType.phone,
      decoration: new InputDecoration(
          labelText: Strings.gsmNo,
          border: InputBorder.none,
          filled: true,
          hintText: Strings.gsmNo,
          hintStyle: TextStyle(color: Colors.grey),
          fillColor: Colors.grey[350]),
    ));

    final _submitButton = Container(
        child: RaisedButton(
            onPressed: () {
              final form = _formKey.currentState;
              if (form.validate()) {
                form.save();
                registerRequest(auth);
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
                Strings.register,
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            )));

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context, true);
              }),
          title: Text(Strings.register),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              height: MediaQuery.of(context).size.height,
              child: auth.registeredInStatus == Status.Registering
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        _entryUserNameField,
                        SizedBox(height: 20),
                        _entryUserSurnameField,
                        SizedBox(height: 20),
                        _entryEmailField,
                        SizedBox(height: 20),
                        _entryPasswordField,
                        SizedBox(height: 20),
                        _entryGsmNoField,
                        SizedBox(height: 20),
                        _submitButton,
                      ],
                    ),
            ),
          ),
        ));
  }

  void registerRequest(AuthProvider auth) {
    final Future<Map<String, dynamic>> successfulMessage = auth.register(
        _userName, _userSurname, _userEmail, _userPassword, _userPhone);
    successfulMessage.then((response) {
      if (response['status']) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      }
    });
  }
}
