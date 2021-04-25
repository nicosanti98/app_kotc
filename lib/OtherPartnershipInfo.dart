import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OtherPartnershipInfo extends StatelessWidget {

  getOtherPartnershipInfo()
  {
    return this;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Info Partnership"),
        backgroundColor: Colors.orange,
        leading: FlatButton(
            child: Icon(Icons.arrow_back),
            onPressed: (){
              Navigator.of(context).pop();
            },
          ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                child: Text("Vuoi diventare nostro partner?", style: TextStyle(fontSize: 22, letterSpacing: 1), textAlign: TextAlign.left,),
              ),
              Divider(
                  color: Colors.orange,
                ),
            ],
          ),
        ),
      )
    );
  }

}
