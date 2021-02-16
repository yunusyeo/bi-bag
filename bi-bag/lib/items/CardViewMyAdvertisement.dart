import 'package:flutter/material.dart';
import 'package:hello_word/model/response/MyAdvertisementListResponseModel.dart';
import 'package:hello_word/values/Strings.dart';

class CardViewMyAdvertisement extends StatefulWidget {
  //final MyResult result;
  //CardViewMyAdvertisement({Key key, @required this.result}) : super(key: key);

  @override
  _CardViewMyAdvertisementState createState() =>
      _CardViewMyAdvertisementState();
}

class _CardViewMyAdvertisementState extends State<CardViewMyAdvertisement> {
  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.card,
      borderRadius: BorderRadius.circular(10),
      elevation: 10,
      child: Container(
          padding: const EdgeInsets.all(15),
          child: Container(
              child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "LAS",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                  softWrap: true,
                ),
                Icon(Icons.arrow_forward_rounded,
                    color: Colors.green[300], size: 30),
                Text(
                  "SAW",
                  style: TextStyle(fontSize: 20),
                  softWrap: true,
                ),
              ],
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      Strings.flight,
                      style: TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "PC23454",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                      softWrap: true,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      Strings.quantity,
                      style: TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "10",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                      softWrap: true,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      Strings.price,
                      style: TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "5",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                      softWrap: true,
                    ),
                  ],
                ),
              ],
            )
          ]))),
    );
  }
}
