
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: FlatButton(
          child: Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.of(context).pop();
          },
        ),
      ),
      bottomSheet: Container(
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
      body: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              child:Scrollbar(
                controller: _scrollController,
                isAlwaysShown: false,
                child: SingleChildScrollView(
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Container(
                        child: Image.network(image1, width: MediaQuery.of(context).size.width/2,),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.orange)
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Text(name1, maxLines:3, overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.orange, ),),
                            Text(description1),
                          ],

                        ),
                      )

                    ],
                  ),
                )
                ,
              )

            ),


          ]
      ),

    );
  }
}