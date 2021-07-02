import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';

class Classifiche extends StatefulWidget{
  @override
  ClassificheState createState() => ClassificheState();


}

class ClassificheState extends State<Classifiche>{


  Future<String>getCalendar() async {
    Uri uri = Uri.parse("https://www.kingofthecage.it/API/KotcApp/getCalendar.php");
    var response = await http.get(uri);
    print(response.body);
    return (response.body);
  }

  Future<String> getCPG(String nome)async{

    Uri uri = Uri.parse("https://www.kingofthecage.it/API/KotcApp/getGarePerGirone.php?girone="+nome);
    var response = await http.get(uri);
    return (response.body);

  }

  Future<String>getGironi() async{
    Uri uri = Uri.parse("https://www.kingofthecage.it/API/KotcApp/getGironi.php");
    var response = await http.get(uri);

    return (response.body);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FutureBuilder(
        future: getCalendar(),
        builder: (context, AsyncSnapshot<String> snapshot){
          if(snapshot.hasData && snapshot.data != "null")  {
            var json = jsonDecode(snapshot.data);

            var jsondata = new List.from(json as List);
            print(jsondata);

            var ListPPG = groupBy(jsondata, (a) => a['girone']);
            print(ListPPG);

            var numeroGironi = ListPPG.length;
            List nomiGironi = new List(); 
            for(int i =0; i < numeroGironi; i++)
              {
                nomiGironi.add(ListPPG.keys.elementAt(i)); 
              }

            return RefreshIndicator(
                onRefresh: () {
                  setState(() {

                  });
                  return Future.delayed(Duration(seconds: 0));
                },
                child: Scaffold(
                    backgroundColor: Colors.white,
                    body: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
                              alignment: Alignment.topLeft,
                              child:FlatButton(
                                  minWidth: 10,
                                  onPressed:(){Navigator.of(context).pop();},
                                  child: Icon(Icons.arrow_back)),

                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
                              child: Container(
                                width: MediaQuery.of(context).size.width-70,
                                child:  AutoSizeText("Classifiche", maxLines:1,style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, letterSpacing: 1), textAlign: TextAlign.left,),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: Divider(
                              color: Color.fromARGB(255, 244, 156, 49)
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          height: MediaQuery.of(context).size.height-114,
                          width: MediaQuery.of(context).size.width,
                          child: ListView.builder(
                              itemCount: numeroGironi,
                              itemBuilder: (context, i){
                                return Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5, offset: Offset(0, 10))],
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white,
                                      ),
                                      child:Column(
                                        children: [
                                          AutoSizeText(nomiGironi[i]),
                                          Text(ListPPG[nomiGironi[i].toString()].toString()),
                                        ],
                                      ),
                                    ),

                                  ],
                                );
                              }),
                        )
                      ],
                    )

                ));
          }
          else
          {
            return Center(child: Scaffold(
              backgroundColor: Colors.white,
              body: Column(
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
                  Text("Le classifiche saranno disponibili a breve!", style: TextStyle(fontWeight: FontWeight.bold, color:Color.fromARGB(255, 244, 156, 49),fontSize: 20, letterSpacing: 1),textAlign: TextAlign.center,),
                ],

              ),
            ), );
          }

        });
  }

}
