

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import 'News.dart';

String name1;
String description1;
LatLng position1;
String image1;
String url1;

class PartnerDetail extends StatefulWidget{



  PartnerDetail(String name, String description, LatLng position, String image, String url)
  {
    url1 = url==null?"":url;
    name1 = name==null?"null":name;
    description1 = description==null?"null":description;
    position1 = position;
    image1 = image;

  }

  PartnerDetailState createState()=> PartnerDetailState();

}

class PartnerDetailState extends State<PartnerDetail> {
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    GoogleMapController mapController;
    void _onMapCreated(GoogleMapController controller) {
      mapController = controller;
    }
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomPaint(
           painter: OpenPainter(context),
            willChange: false,
            child: Container(
              alignment: Alignment.center,
              child: ListView(
                  padding: EdgeInsets.fromLTRB(20, 40, 20, 0),

                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      child:FlatButton(
                        minWidth: 10,
                          onPressed:(){Navigator.of(context).pop();},
                          child: Icon(Icons.arrow_back)),

                    ),

                    Container(

                        decoration: BoxDecoration(
                          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5, offset: Offset(0, 10))],
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,),

                      width: MediaQuery.of(context).size.width-50,
                      alignment: Alignment.center,
                      child: Column(
                        children:[
                          Container(
                            width: MediaQuery.of(context).size.width/2,
                            child: Image.network(image1),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FlatButton(
                                child: Text("Sito Web"),
                                onPressed: ()async {
                                  var url = url1;
                                  if (await canLaunch(url))
                                    await launch(url);
                                  else
                                    // can't launch url, there is some error
                                    throw "Could not launch $url";
                                },
                              ),
                              FlatButton(
                                child: Text("Indicazioni"),
                                onPressed: ()async{
                                  var url = "https://www.google.com/maps/search/?api=1&query="+position1.latitude.toString()+","+position1.longitude.toString();

                                  if (await canLaunch(url))
                                    await launch(url);
                                  else
                                    // can't launch url, there is some error
                                    throw "Could not launch $url";
                                },
                              )
                            ],
                          )
                        ]
                      )
                    ),
                    SizedBox(height: 20),
                    Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width-50,
                        decoration: BoxDecoration(
                          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5, offset: Offset(0, 10))],
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(10),
                              alignment: Alignment.topLeft,
                              child: AutoSizeText(name1, maxLines:2,textAlign: TextAlign.left, style: TextStyle(fontSize: 20, letterSpacing: 1.5, fontWeight: FontWeight.bold),),
                            ),
                            Padding(padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: Divider(
                              color:  Color.fromARGB(255, 244, 156, 49),
                            ),),


                            Container(
                              padding: EdgeInsets.all(10),
                              child:Text(description1, style: TextStyle(fontSize: 16, letterSpacing: 1),),
                            )
                            ,
                            Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              height: MediaQuery
                                  .of(context)
                                  .size
                                  .height / 3,
                              child: GoogleMap(
                                  tiltGesturesEnabled: true,
                                  zoomControlsEnabled: true,
                                  scrollGesturesEnabled: true,
                                  markers: {
                                    Marker(
                                        markerId: MarkerId("KOTC"),
                                        position: position1,
                                        infoWindow: InfoWindow(
                                          title: name1,
                                        )
                                    )
                                  },
                                  onMapCreated: _onMapCreated,
                                  initialCameraPosition: CameraPosition(
                                      target: position1,
                                      zoom: 16
                                  )
                              ),
                            ),
                          ],
                        )
                    ),



                  ]
              ),
            )
      )

    );
  }
}

class OpenPainter extends CustomPainter{
  var context;
  OpenPainter(BuildContext context)
  {
    this.context = context;
  }
  @override
  void paint(Canvas canvas, Size size) {
    var paint1 = Paint()
      ..color = Color.fromARGB(255, 244, 156, 49)
      ..style = PaintingStyle.fill;
    //a rectangle
    canvas.drawRect(Offset(0, -100) & Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height/1.5), paint1);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;

}