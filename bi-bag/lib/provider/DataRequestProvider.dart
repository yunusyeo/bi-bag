import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hello_word/model/request/AddAdvertisementRequestModel.dart';
import 'package:hello_word/model/response/FetchFlights.dart';
import 'package:hello_word/model/response/MyAdvertisementListResponseModel.dart';
import 'package:hello_word/serviceURLs/ServiceUrls.dart';
import 'package:hello_word/values/Strings.dart';
import 'package:http/http.dart';

enum Status {
  Loading,
  Success,
  Error,
}

class DataRequestProvider with ChangeNotifier {
  Status _getStatus = Status.Error;

  Status get getStatus => _getStatus;

  Future<Map<String, dynamic>> getFlight(
      String flightCode, String token) async {
    var result;
    _getStatus = Status.Loading;
    notifyListeners();
    try {
      Response response = await get(
          Uri.encodeFull(ServiceUrls.getFlightUrl + flightCode),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          });
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        var outputData = responseData['Result'];
        Result resultData = Result.fromJson(outputData);
        _getStatus = Status.Success;
        notifyListeners();

        result = {'status': true, 'message': "", 'result': resultData};
      } else {
        _getStatus = Status.Error;
        notifyListeners();

        result = {
          'status': false,
          'message': "",
        };
      }
    } catch (e) {
      _getStatus = Status.Error;
      notifyListeners();

      result = {
        'status': false,
        'message': e.toString(),
      };
    }
    return result;
  }

  Future<Map<String, dynamic>> addAdvertisement(
      AddAdvertisementRequestModel addAdvertisementRequestModel,
      String token) async {
    var result;
    var requestBody = json.encode(addAdvertisementRequestModel);
    _getStatus = Status.Loading;
    notifyListeners();
    try {
      Response response =
          await post(Uri.encodeFull(ServiceUrls.addAdvertisementUrl),
              headers: {
                "Content-Type": "application/json",
                "Authorization": "Bearer $token",
              },
              body: requestBody);
      if (response.statusCode == 200 || response.statusCode == 201) {
        _getStatus = Status.Success;
        notifyListeners();

        result = {'status': true, 'message': Strings.addAdvertisementSuccess};
      } else {
        _getStatus = Status.Error;
        notifyListeners();

        result = {
          'status': false,
          'message': Strings.addAdvertisementError,
        };
      }
    } catch (e) {
      _getStatus = Status.Error;
      notifyListeners();

      result = {
        'status': false,
        'message': e.toString(),
      };
    }
    return result;
  }

  Future<Map<String, dynamic>> getMyAdvertisement(
      String userId, String token) async {
    var result;
    _getStatus = Status.Loading;
    notifyListeners();
    try {
      Response response = await get(
          Uri.encodeFull(ServiceUrls.myAdvertisemenListtUrl + userId),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          });
      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        List<MyResult> resultData =
            MyAdvertisementListResponseModel.fromJson(responseData).result;

        _getStatus = Status.Success;
        notifyListeners();

        result = {'status': true, 'message': "", 'data': resultData};
      } else {
        _getStatus = Status.Error;
        notifyListeners();

        result = {
          'status': false,
          'message': "",
        };
      }
    } catch (e) {
      _getStatus = Status.Error;
      notifyListeners();

      result = {
        'status': false,
        'message': e.toString(),
      };
    }
    return result;
  }
}
