import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _GoogleSignInState createState() => _GoogleSignInState();
}

class _GoogleSignInState extends State<MyApp> {

  bool isLoggedIn=false;

  GoogleSignIn googleSignIn=GoogleSignIn(
      scopes: [
        "profile",
        "email"
      ]
  );
  LogIn() async {
    try{
      await googleSignIn.signIn();
      setState(() {
        isLoggedIn=true;
      });
    }catch(err){
      print(err);
    }
  }

  LogOut() async {
    googleSignIn.signOut();
    setState(() {
      isLoggedIn=false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: isLoggedIn ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.network(
                googleSignIn.currentUser.photoUrl,
                height: 50.0 ,
                width: 50.0,
              ),
              Text(googleSignIn.currentUser.displayName),
              Text(googleSignIn.currentUser.email),
              OutlineButton(
                child: Text("Logout"),
                onPressed: (){
                  LogOut();
                },
              )
            ],
          )
             : OutlineButton(
                child: Text("Login With Google"),
                onPressed: (){
                  LogIn();
                },
              )

        ),
      ),
    );
  }
}
