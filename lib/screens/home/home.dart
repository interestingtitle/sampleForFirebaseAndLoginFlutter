import 'package:brew_crew/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:brew_crew/services/database.dart';
import 'package:brew_crew/screens/home/apt_list.dart';
import 'package:brew_crew/models/apt.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Apt>>.value(
          value: DatabaseService().apts,
          child: Container(
        child: Scaffold(
          backgroundColor: Colors.brown[50],
          appBar: AppBar(
            title: Text("Baris's app"),
            backgroundColor: Colors.brown[400],
            elevation: 0.0,
            actions: <Widget>[
              FlatButton.icon(
                onPressed: () async{
                  await _auth.signOut();
                } , 
                icon: Icon(Icons.person), 
                label: Text("Logout")
                )
            ],
          ),
          body: AptList(),
          ),
      ),
    );
  }
}