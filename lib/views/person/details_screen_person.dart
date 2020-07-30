import 'package:flutter/material.dart';
import 'package:mediatrack_flutter/models/person/person.dart';

class DetailsScreenPerson extends StatefulWidget {
  DetailsScreenPerson({this.person});
  final Person person;
  @override
  _DetailsScreenPersonState createState() => _DetailsScreenPersonState();
}

class _DetailsScreenPersonState extends State<DetailsScreenPerson> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container();
  }
}
