import 'dart:collection';
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
            print("****");
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
                              itemBuilder: (context, i) {
                                var classifiche = new List();
                                var Squadre = new List<Map<dynamic, dynamic>>();

                                var Classifiche  = new List<Map<dynamic,dynamic>>();

                                for(int i = 0; i < nomiGironi.length; i++)
                                  {
                                    Squadre = [];
                                    //Aggiungi squadre alla lista
                                    for(int j = 0; j < ListPPG[nomiGironi[i].toString()].length; j++)
                                      {


                                        bool found = false;
                                        int z = 0;

                                        while(found == false && z < Squadre.length)
                                          {
                                            if(Squadre[z]['Squadra']== ListPPG[nomiGironi[i].toString()][j]['a'])
                                              {
                                                found = true;
                                              }
                                            else
                                              {
                                                z++;
                                              }
                                          }
                                          if(z == Squadre.length)
                                            {
                                              Squadre.add({'Squadra':ListPPG[nomiGironi[i].toString()][j]['a'], 'Punti': 0, 'PF': 0, 'PS':0});
                                            }

                                          found = false;
                                          z = 0;

                                        while(found == false && z < Squadre.length)
                                        {
                                          if(Squadre[z]['Squadra']== ListPPG[nomiGironi[i].toString()][j]['b'])
                                          {
                                            found = true;
                                          }
                                          else
                                          {
                                            z++;
                                          }
                                        }
                                        if(z == Squadre.length)
                                        {
                                          Squadre.add({'Squadra':ListPPG[nomiGironi[i].toString()][j]['b'], 'Punti': 0, 'PF': 0, 'PS':0});
                                        }










                                      }






                                    for(int j = 0; j < ListPPG[nomiGironi[i].toString()].length; j++)
                                      {
                                        if(int.parse(ListPPG[nomiGironi[i].toString()][j]['puntiA']) > int.parse(ListPPG[nomiGironi[i].toString()][j]['puntiB']))
                                          {
                                            for(int n = 0 ; n < Squadre.length; n++)
                                              {
                                                if(Squadre[n]['Squadra'] == ListPPG[nomiGironi[i].toString()][j]['a'])
                                                  {
                                                    Squadre[n]['Punti'] += 2;
                                                    Squadre[n]['PF'] += int.parse(ListPPG[nomiGironi[i].toString()][j]['puntiA']);
                                                    Squadre[n]['PS'] += int.parse(ListPPG[nomiGironi[i].toString()][j]['puntiB']);
                                                  }
                                                if(Squadre[n]['Squadra'] == ListPPG[nomiGironi[i].toString()][j]['b'])
                                                  {
                                                    Squadre[n]['PF'] += int.parse(ListPPG[nomiGironi[i].toString()][j]['puntiB']);
                                                    Squadre[n]['PS'] += int.parse(ListPPG[nomiGironi[i].toString()][j]['puntiA']);
                                                  }
                                              }
                                          }
                                        else
                                          {
                                            if(int.parse(ListPPG[nomiGironi[i].toString()][j]['puntiA']) != int.parse(ListPPG[nomiGironi[i].toString()][j]['puntiB']))
                                              {
                                                for(int n = 0 ; n < Squadre.length; n++)
                                                {
                                                  if(Squadre[n]['Squadra'] == ListPPG[nomiGironi[i].toString()][j]['b'])
                                                  {
                                                    Squadre[n]['Punti'] += 2;
                                                    Squadre[n]['PF'] += int.parse(ListPPG[nomiGironi[i].toString()][j]['puntiB']);
                                                    Squadre[n]['PS'] += int.parse(ListPPG[nomiGironi[i].toString()][j]['puntiA']);
                                                  }
                                                  if(Squadre[n]['Squadra'] == ListPPG[nomiGironi[i].toString()][j]['a'])
                                                  {
                                                    Squadre[n]['PF'] += int.parse(ListPPG[nomiGironi[i].toString()][j]['puntiA']);
                                                    Squadre[n]['PS'] += int.parse(ListPPG[nomiGironi[i].toString()][j]['puntiB']);
                                                  }
                                                }
                                              }


                                          }

                                      }



                                    for(int k = 0; k < Squadre.length; k++)
                                      {
                                        for(int l = 0;  l < Squadre.length; l++)
                                          {
                                            if(Squadre[k]['Punti'] <Squadre[l]['Punti'])
                                              {
                                                var tmp = Squadre[l];
                                                Squadre[l] = Squadre[k];
                                                Squadre[k] = tmp;
                                              }
                                            else
                                              {
                                                if(Squadre[k]['Punti'] == Squadre[l]['Punti'])
                                                  {
                                                    var dpA, dpB;
                                                    dpA = Squadre[k]['PF'] - Squadre[k]['PS'];
                                                    dpB = Squadre[l]['PF'] - Squadre[l]['PS'];
                                                    if(dpA < dpB)
                                                      {
                                                        var tmp = Squadre[l];
                                                        Squadre[l] = Squadre[k];
                                                        Squadre[k] = tmp;
                                                      }
                                                  }
                                              }
                                          }
                                      }

                                    print("***SQUADRE GIRONE:"+nomiGironi[i]+"****");
                                    print(Squadre);
                                    print(nomiGironi[i]);
                                    Squadre = Squadre.reversed.toList();
                                  Classifiche.add({"Girone": nomiGironi[i], "Classifica": Squadre});

                                  }
                                Classifiche.reversed.toList();
                                print(Classifiche);



                                //Riscorro tutto per ogni giron
                                return Container(
                                  padding: EdgeInsets.all(40),
                                  child: Column(
                                    children: [
                                      Container(
                                        child: Text(nomiGironi[i], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                                      ),
                                      SizedBox(height: 20,),
                                      Container(
                                        child: ListView.builder(
                                          itemCount: Classifiche[i]['Classifica'].length,
                                            itemBuilder: (context1, j){
                                              return Column(
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5, offset: Offset(0, 10))],
                                                      borderRadius: BorderRadius.circular(10),
                                                      color: Colors.white,
                                                    ),
                                                    child:ListTile(
                                                      leading: Text((j+1).toString()+"°"),
                                                      title: AutoSizeText(Classifiche[i]['Classifica'][j]['Squadra']),
                                                      subtitle: AutoSizeText("P: "+Classifiche[i]['Classifica'][j]['Punti'].toString()+"\n"+
                                              "PF: "+Classifiche[i]['Classifica'][j]['PF'].toString()+"\n"+
                                              "PS: "+Classifiche[i]['Classifica'][j]['PS'].toString()),


                                                    ),
                                                  ),
                                                  SizedBox(height: 10,)
                                                ],
                                              );

                                            }),
                                        height: MediaQuery.of(context).size.height/2,



                                      ),
                                    ],
                                  )
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
