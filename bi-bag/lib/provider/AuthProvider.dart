import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hello_word/ServiceURLs/ServiceUrls.dart';
import 'package:hello_word/model/User.dart';
import 'package:hello_word/model/request/LoginRequestModel.dart';
import 'package:hello_word/model/request/RegisterRequestModel.dart';
import 'package:hello_word/model/response/LoginResponseModel.dart';
import 'package:hello_word/util/UserPreferences.dart';
import 'package:hello_word/values/Strings.dart';
import 'dart:async';
import 'package:http/http.dart';

enum Status {
  NotLoggedIn,
  NotRegistered,
  LoggedIn,
  Registered,
  Authenticating,
  Registering,
  LoggedOut
}

class AuthProvider with ChangeNotifier {
  Status _loggedInStatus = Status.NotLoggedIn;
  Status _registeredInStatus = Status.NotRegistered;

  Status get loggedInStatus => _loggedInStatus;
  Status get registeredInStatus => _registeredInStatus;

  Future<Map<String, dynamic>> login(String email, String password) async {
    var result;
    var loginRequestModel = new LoginRequestModel();
    loginRequestModel.username = email;
    loginRequestModel.password = password;
    var requestBody = json.encode(loginRequestModel);

    _loggedInStatus = Status.Authenticating;
    notifyListeners();

    try {
      Response response = await post(Uri.encodeFull(ServiceUrls.loginUrl),
          headers: {"Content-Type": "application/json"}, body: requestBody);
      if (response.statusCode == 200) {
        User user = new User();
        final Map<String, dynamic> responseData = json.decode(response.body);
        var userData = responseData['Result'];
        Result resultData = Result.fromJson(userData);
        user.id = resultData.id;
        user.name = resultData.firstName;
        user.surname = resultData.lastName;
        user.email = resultData.username;
        user.token = resultData.token;
        user.phone = resultData.phone;
        UserPreferences().saveUser(user);

        _loggedInStatus = Status.LoggedIn;
        notifyListeners();

        result = {
          'status': true,
          'message': Strings.loginSuccess,
          'user': user
        };
      } else {
        _loggedInStatus = Status.NotLoggedIn;
        notifyListeners();

        result = {
          'status': false,
          'message': Strings.loginError,
        };
      }
    } catch (e) {
      _loggedInStatus = Status.NotLoggedIn;
      notifyListeners();

      result = {
        'status': false,
        'message': e.toString(),
      };
    }
    return result;
  }

  Future<Map<String, dynamic>> register(String name, String surname,
      String email, String password, String phone) async {
    var result;
    var registerRequestModel = new RegisterRequestModel();
    registerRequestModel.firstName = name;
    registerRequestModel.lastName = surname;
    registerRequestModel.email = email;
    registerRequestModel.password = password;
    registerRequestModel.phone = phone;
    var requestBody = json.encode(registerRequestModel);

    _registeredInStatus = Status.Registering;
    notifyListeners();

    try {
      Response response = await post(Uri.encodeFull(ServiceUrls.registerUrl),
          headers: {"Content-Type": "application/json"}, body: requestBody);
      if (response.statusCode == 200) {
        _registeredInStatus = Status.Registered;
        notifyListeners();
        result = {
          'status': true,
          'message': Strings.registerSuccess,
        };
      } else {
        _registeredInStatus = Status.NotRegistered;
        notifyListeners();
        result = {
          'status': false,
          'message': Strings.registerError,
        };
      }
    } catch (e) {
      _registeredInStatus = Status.NotRegistered;
      notifyListeners();
      result = {
        'status': false,
        'message': e.toString(),
      };
    }
    return result;
  }
}
