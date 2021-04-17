import 'dart:convert';
import 'dart:math';

import 'package:app_kotc/OtherPartnershipInfo.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';


class Partnership extends StatefulWidget {

      getPartnership() {
        return this;
      }


  @override
  PartnershipState createState() => PartnershipState();
}




  class PartnershipState extends State<Partnership> {


    Future<bool> check() async {
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.mobile) {
        return true;
      } else if (connectivityResult == ConnectivityResult.wifi) {
        return true;
      }
      return false;
    }


    Future<String>getSponsor() async {
      var response = await http.get("https://www.kingofthecage.it/API/KotcApp/getSponsor.php");
      return (response.body);
    }

    List shuffle(List items) {
      var random = new Random();

      // Go through all elements.
      for (var i = items.length - 1; i > 0; i--) {

        // Pick a pseudorandom number according to the list length
        var n = random.nextInt(i + 1);

        var temp = items[i];
        items[i] = items[n];
        items[n] = temp;
      }

      return items;
    }

    adjustRandomList(List<dynamic> list)
    {
      var editedList = new List<dynamic>();
      list = shuffle(list);
      int i = 0;
      Random rnd = new Random();
      while(list.isNotEmpty)
        {
          int num = rnd.nextInt(100);
          if (int.parse(list.elementAt(i)['priorita'])==3)
            {
              if(num > 98)
                {
                  editedList.add(list.elementAt(i));
                  list.removeAt(i);
                  i = 0;

                }
              else
                {
                  if(i < list.length-1)
                    {
                      i++;
                    }
                  else
                    {
                      i =0 ;
                    }
                }
            }
          else if(int.parse(list.elementAt(i)['priorita'])==2)
            {
              if(num > 93)
                {
                  editedList.add(list.elementAt(i));
                  list.removeAt(i);
                  i = 0;
                }
              else
                {
                  if(i < list.length-1)
                  {
                    i++;
                  }
                  else
                  {
                    i =0 ;
                  }
                }

            }
          else if(int.parse(list.elementAt(i)['priorita'])==1)
            {
              if (num > 0)
                {
                  editedList.add(list.elementAt(i));
                  list.removeAt(i);
                  i = 0;
                }
              else
                {
                  i = 0;
                }
            }
        }

        for(int i = editedList.length; i < 20; i++)
          {
            var elem = {"id":"null","immagine":"null", "link":"null","priorita":"null", "descrizione": "null"};
            editedList.add(elem);
          }
        print(editedList);
      return editedList;
    }


    @override
    Widget build(BuildContext context) {
      return FutureBuilder(
        future: getSponsor(),
          builder: (context, AsyncSnapshot<String>snapshot){
          if(snapshot.hasData)
            {

              var jsondata = jsonDecode(snapshot.data);
              var adjusted = adjustRandomList(jsondata);
              return Scaffold(
                floatingActionButton: FloatingActionButton(
                  backgroundColor: Colors.black45,
                  tooltip: "Diventa nostro Partner",
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(
                            builder: (context) => OtherPartnershipInfo()));
                  },
                  child: Icon(Icons.more_horiz, color: Colors.white,),
                ),
                body: ListView(

                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width/2,
                            child: FlatButton(
                              child: Image.network(adjusted[0]['immagine'], fit: BoxFit.fill,),
                              onPressed: ()async {
                                var url = adjusted[0]['link'].toString();
                                if (await canLaunch(url))
                                  await launch(url);
                                else
                                  // can't launch url, there is some error
                                  throw "Could not launch $url";
                              },
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width/2,
                            child: FlatButton(
                              child: Image.network(adjusted[1]['immagine'], fit: BoxFit.fill,),
                              onPressed: ()async {
                                var url = adjusted[1]['link'].toString();
                                if (await canLaunch(url))
                                  await launch(url);
                                else
                                  // can't launch url, there is some error
                                  throw "Could not launch $url";
                              },
                            ) ,
                          )


                        ],
                      )
                    ),

                    Container(
                      child:Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width/3,
                                child: FlatButton(
                                  child: Image.network(adjusted[2]['immagine'], fit: BoxFit.scaleDown,),
                                  onPressed: ()async {
                                    var url = adjusted[2]['link'].toString();
                                    if (await canLaunch(url))
                                      await launch(url);
                                    else
                                      // can't launch url, there is some error
                                      throw "Could not launch $url";
                                  },
                                ) ,

                            ),
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                width: (MediaQuery.of(context).size.width)/3,
                                child: FlatButton(
                                  child: Image.network(adjusted[3]['immagine'], fit: BoxFit.scaleDown,),
                                  onPressed: ()async {
                                    var url = adjusted[3]['link'].toString();
                                    if (await canLaunch(url))
                                      await launch(url);
                                    else
                                      // can't launch url, there is some error
                                      throw "Could not launch $url";
                                  },
                                ) ,
                              ),

                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                width: (MediaQuery.of(context).size.width)/3,
                                child: FlatButton(
                                  child: Image.network(adjusted[4]['immagine'], fit: BoxFit.scaleDown,),
                                  onPressed: ()async {
                                    var url = adjusted[4]['link'].toString();
                                    if (await canLaunch(url))
                                      await launch(url);
                                    else
                                      // can't launch url, there is some error
                                      throw "Could not launch $url";
                                  },
                                ) ,
                              ),

                            ],
                          )
                    ]),
            ),
                    Container(
                      child:Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width/3,
                                  child: FlatButton(
                                    child: Image.network(adjusted[5]['immagine'], fit: BoxFit.scaleDown,),
                                    onPressed: ()async {
                                      var url = adjusted[5]['link'].toString();
                                      if (await canLaunch(url))
                                        await launch(url);
                                      else
                                        // can't launch url, there is some error
                                        throw "Could not launch $url";
                                    },
                                  ) ,
                                ),


                              ],
                            ),
                            Column(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width/3,
                                  child: FlatButton(
                                    child: Image.network(adjusted[6]['immagine'], fit: BoxFit.scaleDown,),
                                    onPressed: ()async {
                                      var url = adjusted[6]['link'].toString();
                                      if (await canLaunch(url))
                                        await launch(url);
                                      else
                                        // can't launch url, there is some error
                                        throw "Could not launch $url";
                                    },
                                  ) ,
                                )

                              ],
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width/3,
                                  child: FlatButton(
                                    child: Image.network(adjusted[7]['immagine'], fit: BoxFit.scaleDown,),
                                    onPressed: ()async {
                                      var url = adjusted[7]['link'].toString();
                                      if (await canLaunch(url))
                                        await launch(url);
                                      else
                                        // can't launch url, there is some error
                                        throw "Could not launch $url";
                                    },
                                  ) ,
                                ),


                              ],
                            ),

                          ]),
                    ),

                  ],
                ),
              );
            }
          else
            {
              return Center(child: CircularProgressIndicator());
            }
        },

      );
    }
  }

