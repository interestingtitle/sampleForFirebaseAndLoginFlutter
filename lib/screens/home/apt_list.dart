import 'package:brew_crew/services/database.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:brew_crew/models/apt.dart';
class AptList extends StatefulWidget {
  @override
  _AptListState createState() => _AptListState();
}

class _AptListState extends State<AptList> {
  @override
  Widget build(BuildContext context) {
    
    final apts = Provider.of<List<Apt>>(context);
    apts.forEach((apt) {
      print(apt.name);
      print(apt.champ);
      print(apt.level);
     });

    return Container(
      
    );
  }
}