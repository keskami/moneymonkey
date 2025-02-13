import 'package:flutter/material.dart';

class EventPopUp extends StatefulWidget {
  @override
  _EventPopUpState createState() => _EventPopUpState();
}

class _EventPopUpState extends State<EventPopUp> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      height: 100,
      width: 100,
      child: Text('This is the Event Pop Up widget'),
    ));
  }
}
