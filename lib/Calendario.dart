import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Calendario extends StatefulWidget {

  getCalendario() {
    return this;
  }


  @override
  CalendarioState createState() => CalendarioState();
}

class CalendarioState extends State<Calendario> {
  Future<String>getSponsor() async {
    Uri uri = Uri.parse("https://www.kingofthecage.it/API/KotcApp/getSponsor.php");
    var response = await http.get(uri);
    return (response.body);
  }



  @override
  void initState()
  {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      String res = await getSponsor();
      var jsonres = jsonDecode(res);
      jsonres = List.from(jsonres as List);
      Random random = new Random();
      int value = random.nextInt(jsonres.length);
      var selected = jsonres[value];
      await showDialog<String>(
        context: context,
        builder: (BuildContext context) => SelectAlertDialogType(selected),
      );
    });

  }
  Future<String>getCalendar() async {
    Uri uri = Uri.parse("https://www.kingofthecage.it/API/KotcApp/getCalendar.php");
    var response = await http.get(uri);
    print(response.body);
    return (response.body);
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getCalendar(),
        builder: (context, AsyncSnapshot<String> snapshot){
          if(snapshot.hasData && snapshot.data != "null") {
            var json = jsonDecode(snapshot.data);
            print(json);
            var jsondata = new List.from(json as List);
            print(json);
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
                              child:  AutoSizeText("Calendario partite", maxLines:1,style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, letterSpacing: 1), textAlign: TextAlign.left,),
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
                            itemCount: jsondata.length,
                            itemBuilder: (context, i){
                              return Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5, offset: Offset(0, 10))],
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                    ),
                                    child:ListTile(
                                      leading: AutoSizeText(jsondata.elementAt(i)['data'].toString().split(" ")[0]+"\n"+jsondata.elementAt(i)['data'].toString().split(" ")[1], maxLines: 3,),
                                      title: AutoSizeText(jsondata.elementAt(i)['a']+" - "+jsondata.elementAt(i)['b'], style: TextStyle(fontWeight: FontWeight.bold),),
                                      subtitle: AutoSizeText("Categoria: "+jsondata.elementAt(i)['sesso'].toString().toUpperCase()+"\n"
                                          +jsondata.elementAt(i)['girone']+"\n"+
                                          "Gara #"+jsondata.elementAt(i)["idGara"]),
                                      trailing: AutoSizeText(jsondata.elementAt(i)['puntiA']+" - "+jsondata.elementAt(i)['puntiB']),
                                    ),
                                  ),
                                  SizedBox(height: 10,)
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
                    Text("Il calendario sarà disponibile a breve!", style: TextStyle(fontWeight: FontWeight.bold, color:Color.fromARGB(255, 244, 156, 49),fontSize: 20, letterSpacing: 1),textAlign: TextAlign.center,),
                  ],

                ),
              ), );
            }

        });



    // TODO: implement build
    throw UnimplementedError();
  }
  SelectAlertDialogType(dynamic item)
  {
    if(Platform.isAndroid)
    {
      return AlertDialog(

        content: Container(
          height: MediaQuery.of(context).size.height/2,
          child:Column(
              children: [
                Container(
                  child: Text("Special thanks to: ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                ),
                SizedBox(height: 20,),
                Container(
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(
                          width: 1,
                          color: Theme.of(context).primaryColor
                      ),

                    ),
                    child: Image.network(item['immagine']),
                  ),
                ),
                SizedBox(height: 50,),
                Container(
                  alignment: Alignment.topLeft,
                  child: Text(item['nome'], textAlign: TextAlign.left,  style: TextStyle(fontSize: 16)),
                )

              ]),
        ),
        actions: <Widget>[
          new FlatButton(
            child: new Text("Avanti"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    }
    else
    {
      return CupertinoAlertDialog(

        content: Container(
          height: MediaQuery.of(context).size.height/2,
          child:Column(
              children: [
                Container(
                  child: Text("Special thanks to: ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                ),
                SizedBox(height: 20,),
                Container(
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(
                          width: 1,
                          color: Theme.of(context).primaryColor
                      ),

                    ),
                    child: Image.network(item['immagine']),
                  ),
                ),
                SizedBox(height: 50,),
                Container(
                  alignment: Alignment.topLeft,
                  child: Text(item['nome'], textAlign: TextAlign.left, style: TextStyle(fontSize: 16),),
                )

              ]),
        ),
        actions:  <Widget>[
          new FlatButton(
            child: new Text("Avanti"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    }
  }
}