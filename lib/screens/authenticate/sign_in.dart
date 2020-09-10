import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  //text field state
  String email = "";
  String password = "";
  String error = "";

  @override
  Widget build(BuildContext context) {
    if(loading == true){
      return Loading();
    }
    else{
      return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text( "Sign in to baris's app" ),
        actions: <Widget>[
          FlatButton.icon(onPressed: () {
            widget.toggleView();
          }, 
          icon: Icon(Icons.person), 
          label: Text("Register")
          )
        ],
        ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              TextFormField(
                decoration: InputDecoration(
                  hintText: "Email",
                ),
                validator: (val) {
                  if(val.isEmpty)
                  {
                    return "Enter an email";
                  }
                  else{
                    return null;
                  }
                },
                onChanged: (val) {
                  setState(() {
                    email = val;
                  });
              },),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: InputDecoration(
                  hintText: "Password",
                ),
                validator: (val) {
                  if(val.length <6)
                  {
                    return "Password must be longer than 6 character";
                  }
                  else{
                    return null;
                  }
                },
                obscureText: true,
                onChanged: (val) {
                  setState(() {
                    password = val;
                  });
                },
                ),
              SizedBox(height: 20.0),
              RaisedButton(
                color: Colors.pink[400],
                child: Text(
                  "Sign In",
                  style: TextStyle(
                    color: Colors.white,
                  )
                  ),
                onPressed: () async{
                  if(_formKey.currentState.validate()){
                    setState(() {
                      loading = true;
                    });
                    dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                    if(result == null){
                      setState(() {
                        loading = false;
                        error = "please write a registered email and correct password";
                      });
                    }
                  }
                },
              ),
              SizedBox(height: 20.0),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              )
            ],
            ),
        )
          
        ),
    );
    }
    
  }
}

/* RaisedButton(
          child: Text("Sign in anon"),
          onPressed: () async{
            dynamic result = await asd.signInAnon();
            if(result == null){
              print("error sign in");
            }
            else{
              print("signed in ");
              print(result.uid);
            }
          },
          ), */