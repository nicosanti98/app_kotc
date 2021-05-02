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

      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(10, 40, 0, 0),
              alignment: Alignment.topLeft,
              child:FlatButton(
                  minWidth: 10,
                  onPressed:(){Navigator.of(context).pop();},
                  child: Icon(Icons.arrow_back)),

            ),
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