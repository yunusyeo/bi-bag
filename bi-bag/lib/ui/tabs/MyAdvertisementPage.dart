import 'package:flutter/material.dart';
import 'package:hello_word/items/CardViewMyAdvertisement.dart';
import 'package:hello_word/model/User.dart';
import 'package:hello_word/model/response/MyAdvertisementListResponseModel.dart';
import 'package:hello_word/provider/DataRequestProvider.dart';
import 'package:hello_word/provider/UserProvider.dart';
import 'package:hello_word/values/Strings.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';

class MyAdvertisementPage extends StatefulWidget {
  @override
  _MyAdvertisementPage createState() => new _MyAdvertisementPage();
}

class _MyAdvertisementPage extends State<MyAdvertisementPage> {
  ProgressDialog pr;
  List<MyResult> results;
  User user;

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

    final Future<Map<String, dynamic>> successfulMessage =
        dataRequestProvider.getMyAdvertisement(user.id, user.token);
    successfulMessage.then((response) {
      if (response['status']) {
        return response['result'];
      }
    });

    return FutureBuilder(
        future: successfulMessage,
        builder: (context, snapshot) {
          results = snapshot.data[2];
          return new ListView.builder(
            itemCount: results == null ? 0 : results.length,
            itemBuilder: (BuildContext context, int index) {
              return new Card(
                  //child: new CardViewMyAdvertisement(result: results[index]),
                  );
            },
          );
        });
  }
}
