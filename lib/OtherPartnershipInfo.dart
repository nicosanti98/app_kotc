
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';
import 'package:http/http.dart';
import 'package:share/share.dart';

class OtherPartnershipInfo extends StatefulWidget {


  getOtherPartnershipInfo()
  {
    return this;
  }

  OtherPartnershipInfoState createState() => OtherPartnershipInfoState();

}

class OtherPartnershipInfoState extends State<OtherPartnershipInfo> {
  bool _isLoading = true;
  PDFDocument document;

  @override
  void initState() {
    super.initState();
    loadDocument();
  }
  loadDocument() async {
    document = await PDFDocument.fromURL('https://www.kingofthecage.it/risorse/pdf/brochure.pdf');

    setState(() => _isLoading = false);
  }

  _onShareData(BuildContext context) async {

    final RenderBox box = context.findRenderObject();
    {

      await Share.share('https://www.kingofthecage.it/risorse/pdf/brochure.pdf',
          subject:"Brochure",
          sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: Column(
          children:[ Container(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 60, 0, 0),
                  child: Row(
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        child:FlatButton(
                            minWidth: 10,
                            onPressed:(){Navigator.of(context).pop();},
                            child: Icon(Icons.arrow_back)),

                      ),
                      Text("Brochure Sponsor", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, letterSpacing: 1), textAlign: TextAlign.left,),
                      Container(
                        alignment: Alignment.topRight,
                        child:
                        FlatButton(
                            onPressed:()=>_onShareData(context),
                            child: Icon(Platform.isAndroid?Icons.share:Icons.ios_share)),
                      )
                    ],
                  ),
                ),

                Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Divider(
                      color: Color.fromARGB(255, 244, 156, 49)
                  ),
                ),

            _isLoading
                ? Center(child: CircularProgressIndicator())
                : Container(
                    height: MediaQuery.of(context).size.height/1.3,
                    child: PDFViewer(
                      showPicker: false,
                      document: document,),
                  )
              ],
            ),
          ),
    ]
        )
    );
  }
}
