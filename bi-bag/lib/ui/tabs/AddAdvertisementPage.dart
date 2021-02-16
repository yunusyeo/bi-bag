import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:hello_word/items/CardViewMyAdvertisement.dart';
import 'package:hello_word/model/User.dart';
import 'package:hello_word/model/request/AddAdvertisementRequestModel.dart';
import 'package:hello_word/model/response/FetchFlights.dart';
import 'package:hello_word/provider/DataRequestProvider.dart';
import 'package:hello_word/provider/UserProvider.dart';
import 'package:hello_word/values/Strings.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'dart:async';
import 'package:provider/provider.dart';

class AddAdvertisementPage extends StatefulWidget {
  @override
  _AddAdvertisementPageState createState() => _AddAdvertisementPageState();
}

class _AddAdvertisementPageState extends State<AddAdvertisementPage> {
  final _formKey = GlobalKey<FormState>();
  ProgressDialog pr;
  final _flightCode = TextEditingController();
  final _luggageQuantity = TextEditingController();
  final _luggagePrice = TextEditingController();

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<UserProvider>(context).user;
    pr = new ProgressDialog(context);
    pr.style(
        message: Strings.progressText,
        borderRadius: 10.0,
        backgroundColor: Colors.white,
        progressWidget: CircularProgressIndicator(),
        elevation: 10.0,
        insetAnimCurve: Curves.easeIn,
        progress: 0.0,
        maxProgress: 100.0,
        progressTextStyle: TextStyle(
            color: Colors.grey, fontSize: 10, fontWeight: FontWeight.w400),
        messageTextStyle: TextStyle(
            color: Colors.grey, fontSize: 15, fontWeight: FontWeight.w600));

    DataRequestProvider dataRequestProvider =
        Provider.of<DataRequestProvider>(context);

    final flightCodeEntry = TextFormField(
      maxLength: 6,
      controller: _flightCode,
      decoration: new InputDecoration(
          border: InputBorder.none,
          filled: true,
          hintText: Strings.flightCode,
          hintStyle: TextStyle(color: Colors.grey),
          fillColor: Colors.grey[350]),
      validator: (value) {
        if (value.isEmpty) {
          return Strings.validationFlightCode;
        }
        return null;
      },
    );

    final luggageQuantityEntry = TextFormField(
      maxLength: 2,
      controller: _luggageQuantity,
      keyboardType: TextInputType.number,
      decoration: new InputDecoration(
          border: InputBorder.none,
          filled: true,
          hintText: Strings.luggageQuantityEntry,
          hintStyle: TextStyle(color: Colors.grey),
          fillColor: Colors.grey[350]),
      validator: (value) {
        if (value.isEmpty) {
          return Strings.validationLuggageQuantityEntry;
        }
        return null;
      },
    );

    final luggagePriceEntry = TextFormField(
      maxLength: 3,
      controller: _luggagePrice,
      keyboardType: TextInputType.number,
      decoration: new InputDecoration(
          border: InputBorder.none,
          filled: true,
          hintText: Strings.luggagePrice,
          hintStyle: TextStyle(color: Colors.grey),
          fillColor: Colors.grey[350]),
      validator: (value) {
        if (value.isEmpty) {
          return Strings.validationLuggagePrice;
        }
        return null;
      },
    );

    final postAdvertiseButton = RaisedButton(
      onPressed: () {
        if (_formKey.currentState.validate()) {
          FocusScope.of(context).unfocus();
          getFlightRequest(dataRequestProvider, _flightCode.text, user);
        }
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      padding: const EdgeInsets.all(15),
      child: Text(Strings.postAdvertiseButton),
      color: Colors.blueAccent,
      textColor: Colors.white,
    );

    return SingleChildScrollView(
        child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 10,
            margin: EdgeInsets.all(15),
            child: Form(
                key: _formKey,
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.all(15),
                            child: flightCodeEntry),
                        Padding(
                            padding: EdgeInsets.all(15),
                            child: luggageQuantityEntry),
                        Padding(
                            padding: EdgeInsets.all(15),
                            child: luggagePriceEntry),
                        Padding(
                            padding: EdgeInsets.all(15),
                            child: postAdvertiseButton),
                        Padding(
                            padding: EdgeInsets.all(15),
                            child: CardViewMyAdvertisement()),
                      ],
                    )))));
  }

  //Uçuş bilgileri
  void getFlightRequest(
      DataRequestProvider dataRequestProvider, String flightCode, User user) {
    pr.show();
    final Future<Map<String, dynamic>> successfulMessage =
        dataRequestProvider.getFlight(flightCode, user.token);
    successfulMessage.then((response) {
      if (response['status']) {
        Result result = response['result'];
        var addAdvertisementRequestModel = new AddAdvertisementRequestModel();
        addAdvertisementRequestModel.flightCode = flightCode;
        addAdvertisementRequestModel.flightCodeId = result.id;
        addAdvertisementRequestModel.untilDate = "2021-02-03";
        addAdvertisementRequestModel.ownerId = user.id;
        addAdvertisementRequestModel.unitAmount = int.parse(_luggagePrice.text);
        addAdvertisementRequestModel.unitPeace =
            int.parse(_luggageQuantity.text);
        addAdvertisementRequest(
            dataRequestProvider, addAdvertisementRequestModel, user.token);
      } else {
        //TODO uçak kalktıya, uçuş iptal edildi, uçuş bulunamadı,
        pr.hide();
      }
    });
  }

  //İlan ekleme
  void addAdvertisementRequest(DataRequestProvider dataRequestProvider,
      AddAdvertisementRequestModel addAdvertisementRequestModel, String token) {
    final Future<Map<String, dynamic>> successfulMessage = dataRequestProvider
        .addAdvertisement(addAdvertisementRequestModel, token);
    successfulMessage.then((response) {
      if (response['status']) {
        pr.show();
        Flushbar(
          flushbarPosition: FlushbarPosition.TOP,
          icon: Icon(
            Icons.check,
            color: Colors.blue,
          ),
          message: response['message'],
          duration: Duration(seconds: 3),
          isDismissible: false,
        )..show(context);
      } else {
        pr.show();
        Flushbar(
          flushbarPosition: FlushbarPosition.TOP,
          icon: Icon(
            Icons.error_outline,
            color: Colors.red,
          ),
          message: response['message'],
          duration: Duration(seconds: 3),
          isDismissible: false,
        )..show(context);
      }
    });
  }
}
