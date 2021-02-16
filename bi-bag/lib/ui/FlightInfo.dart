import 'package:flutter/material.dart';

class Destination extends StatefulWidget {
  static String arrival = "--";
  static String destination = "--";
  static String arrivalIata = "--";
  static String destinationIata = "--";
  static String date = "--";

  @override
  _DestinationState createState() => _DestinationState();
}

class _DestinationState extends State<Destination> {
  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 20),
        height: MediaQuery.of(context).size.height * 0.25,
        width: MediaQuery.of(context).size.width * 0.85,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(14))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: 10,
                ),
                _iconDestination(),
                SizedBox(
                  width: 10,
                ),
                _arrivalAndDestination(),
                SizedBox(
                  width: 45,
                ),
                _arrivalAndDestinationDate()
              ],
            ),
          ],
        ));
  }

  Widget _arrivalAndDestinationDate() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          "${Destination.arrivalIata}",
          style: TextStyle(
            fontSize: 25,
          ),
          softWrap: true,
        ),
        SizedBox(
          height: 20,
        ),
        Text("${Destination.date}",
            style: TextStyle(fontSize: 14),
            textAlign: TextAlign.left,
            softWrap: true),
        SizedBox(
          height: 20,
        ),
        Text(
          "${Destination.destinationIata}",
          style: TextStyle(fontSize: 25),
          softWrap: true,
        ),
      ],
    );
  }

  Widget _arrivalAndDestination() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        RichText(
            text: TextSpan(children: <TextSpan>[
          TextSpan(
              text: "Varış Noktası:",
              style: TextStyle(color: Color(0xFFFb7b7c5), fontSize: 14)),
        ])),
        Text(
          "${Destination.arrival}",
          style: TextStyle(color: Colors.black, fontSize: 17),
        ),
        SizedBox(
          height: 65,
        ),
        RichText(
            text: TextSpan(children: <TextSpan>[
          TextSpan(
              text: "Kalkış Noktası:",
              style: TextStyle(color: Color(0xFFFb7b7c5), fontSize: 14)),
        ])),
        Text(
          "${Destination.destination}",
          style: TextStyle(color: Colors.black, fontSize: 17),
        ),
      ],
    );
  }

  Widget _iconDestination() {
    return Container(
      child: Column(
        children: <Widget>[
          Icon(Icons.airplanemode_active, color: Colors.blue[400], size: 30),
          Icon(Icons.fiber_manual_record, color: Colors.blue[400], size: 12),
          Icon(Icons.fiber_manual_record, color: Colors.blue[400], size: 12),
          Icon(Icons.fiber_manual_record, color: Colors.blue[400], size: 12),
          Icon(Icons.fiber_manual_record, color: Colors.orange[600], size: 12),
          Icon(Icons.fiber_manual_record, color: Colors.orange[600], size: 12),
          Icon(Icons.fiber_manual_record, color: Colors.orange[600], size: 12),
          Icon(Icons.location_on, color: Colors.orange[600], size: 30),
        ],
      ),
    );
  }
}
