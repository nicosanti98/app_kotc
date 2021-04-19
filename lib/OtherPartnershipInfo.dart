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
    );
  }

}
