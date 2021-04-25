import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {

  getLogin()
  {
    return this;
  }
  @override
  LoginState createState () => LoginState();
}

class LoginState extends State<Login>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height/3,
                padding: EdgeInsets.fromLTRB(0, MediaQuery.of(context).size.height/6, 0, 20),
                child: Image(image: AssetImage("res/notlogged.png")),
              ),

            ],
          ),
        ),
      ),
    );
  }

}
