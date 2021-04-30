import 'dart:ui';

import 'package:flutter/material.dart';

class NonDisponibile extends StatelessWidget{

  getNonDisponibile()
  {
    return this;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Non disponibile"),
        backgroundColor: Color.fromARGB(255, 244, 156, 49),
        leading: FlatButton(
          child: Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height/5,
            ),
            Container(
              height: MediaQuery.of(context).size.height/5,
              child: Image(image: AssetImage("res/logoBN.png"),),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height/100,
            ),
            Text("Questo contenuto sarà presto disponibile!", style: TextStyle(fontWeight: FontWeight.bold, color:Color.fromARGB(255, 244, 156, 49),fontSize: 20, letterSpacing: 1),textAlign: TextAlign.center,),
          ],
        ),
      ),

    );
  }

}