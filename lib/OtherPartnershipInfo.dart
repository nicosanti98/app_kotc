
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
        appBar: AppBar(
          actions: [
            FlatButton(
                onPressed:()=>_onShareData(context),
                child: Icon(Platform.isAndroid?Icons.share:Icons.ios_share))
          ],
          title: Text("Brochure Sponsor"),
          backgroundColor: Color.fromARGB(255, 244, 156, 49),
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
                  child: Text("Vuoi diventare nostro partner?", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold,letterSpacing: 1), textAlign: TextAlign.left,),
                ),
                Divider(
                  color: Color.fromARGB(255, 244, 156, 49),

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
        )
    );
  }
}
