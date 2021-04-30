
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'News.dart';

String name1;
String description1;
LatLng position1;
String image1;

class PartnerDetail extends StatefulWidget{



  PartnerDetail(String name, String description, LatLng position, String image)
  {
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
            child: Column(
          children: [
            Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 0)),
            Container(
              width: MediaQuery.of(context).size.width/2,
              alignment: Alignment.center,
              child: Image.network(image1),
            ),
            SizedBox(height: 20),
            Container(
            height: MediaQuery.of(context).size.height/2,
            width: MediaQuery.of(context).size.width-50,
            decoration: BoxDecoration(
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5, offset: Offset(0, 10))],
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Column(
              children: [
                Text(name1),
                Text(description1),
                Container(
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
                          zoom: 18
                      )
                  ),
                ),
              ],
            )
            ),



          ]
      ),
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
    canvas.drawRect(Offset(0, -100) & Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height/2), paint1);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;

}