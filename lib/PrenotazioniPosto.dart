import 'dart:convert';
import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:http/http.dart' as http;

class PrenotazioniPosto extends StatefulWidget{
  @override
  PrenotazioniPostoState createState() =>PrenotazioniPostoState();



}

List<TextEditingController> _nome = [TextEditingController(), TextEditingController()];
List<TextEditingController> _cognome = [TextEditingController(), TextEditingController()];
List<TextEditingController> _mail = [TextEditingController(), TextEditingController()];
List<TextEditingController> _cellulare = [TextEditingController(), TextEditingController()];

class PrenotazioniPostoState extends State<PrenotazioniPosto>{

  @override
  void initState()
  {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await showDialog<String>(
        context: context,
        builder: (BuildContext context) => SelectAlertDialogType("Informazioni", "A causa delle disposizioni ministeriali riguardanti il contenimento della pandemia di "
          "COVID-19, per accedere all'evento come spettatore è necessario prenotare un posto a sedere. "
          "Al fine di tracciare i presenti in caso di positività, usate questa sezione dell'app per accedere"),
      );
    });
    refresh();

  }

  int scelta = 0;
  int _currentValue = 2;
  int oraInizio = 18;
  int oraFine = 19;
  DateTime selectedDate = DateTime.utc(2021,07,15);
  var jsonMassimoPosti;
  var listPrenotazioni;
  var _data = TextEditingController();

  Future<String>getPrenotazioni(String datainizio, String datafine) async {
    Uri uri = Uri.parse("https://www.kingofthecage.it/API/KotcApp/getPostiPrenotati.php?dataInizio="+datainizio+"&dataFine="+datafine);
    print(uri);
    var response = await http.get(uri);
    print(response.body);
    return (response.body);
  }

  Future<String>_getMaximum(String data) async
  {
    Uri uri = Uri.parse("https://www.kingofthecage.it/API/KotcApp/getMassimoPosti.php?data='"+data+"'");
    var response = await http.get(uri);

    return (response.body);
  }

  Future<void> refresh() async{
    _data.text = selectedDate.day.toString()+"-"+selectedDate.month.toString()+"-"+selectedDate.year.toString();
    var max = await _getMaximum(selectedDate.year.toString()+"-"+selectedDate.month.toString()+"-"+selectedDate.day.toString());
    var res = await getPrenotazioni(selectedDate.year.toString()+"-"+selectedDate.month.toString()+"-"+selectedDate.day.toString()+" "+oraInizio.toString()+":00:00",
        selectedDate.year.toString()+"-"+selectedDate.month.toString()+"-"+selectedDate.day.toString()+" "+oraFine.toString()+":00:00");
    print(res);
    if(max == "null")
    {
      jsonMassimoPosti = null;
      if(res == "null")
      {
        listPrenotazioni = null;
      }
      else
      {
        var jsonPrenotazioni = jsonDecode(res);
        listPrenotazioni = new List.from(jsonPrenotazioni as List);
        print(listPrenotazioni.length);
      }

    }
    else
    {
      if(res != "null")
      {
        var jsonPrenotazioni = jsonDecode(res);
        listPrenotazioni = new List.from(jsonPrenotazioni as List);
        print(listPrenotazioni.length);

        jsonMassimoPosti = jsonDecode(max);
        print(jsonMassimoPosti[0]['numero']);

      }
      else
      {
        listPrenotazioni = null;
        jsonMassimoPosti = jsonDecode(max);
      }

    }
    setState(() {

      this.jsonMassimoPosti = jsonMassimoPosti;
      this.listPrenotazioni = listPrenotazioni;


    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime pickedDate = await showDatePicker(

        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.utc(2021, 7, 15),
        lastDate: DateTime.utc(2021, 7, 18));
    setState(() {
      if(pickedDate != null)
        {
          this.selectedDate = pickedDate;
        }

    });

    refresh();





  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [

          SliverList(
            delegate: SliverChildListDelegate(
              [
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
                        child:  AutoSizeText("Prenota il tuo posto a sedere", maxLines:1,style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, letterSpacing: 1), textAlign: TextAlign.left,),
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
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: Column(
                    children: [


                      AutoSizeText((int.parse(jsonMassimoPosti==null?"0":jsonMassimoPosti[0]['numero'])-int.parse(listPrenotazioni==null?"0":listPrenotazioni.length.toString())).toString(), minFontSize: 30,
                        style: TextStyle(color: (int.parse(jsonMassimoPosti==null?"0":jsonMassimoPosti[0]['numero'])-int.parse(listPrenotazioni==null?"0":listPrenotazioni.length.toString())).toString() == "0"?Colors.red:Colors.green, fontWeight: FontWeight.bold), ),
                      SizedBox(height: 10),
                      AutoSizeText("posti disponibili per data e ora selezionate."),
                      Row(
                        children: [
                          AutoSizeText("Per quante persone vuoi prenotare?", maxLines: 5),
                          SizedBox(width: 20),

                          NumberPicker.integer(
                              scrollDirection: Axis.horizontal,
                              haptics: true,
                              initialValue: _currentValue, minValue: 1, maxValue: 5, onChanged: (value) async {
                            setState((){});
                            _currentValue = value;

                            for(int i = 0; i < _currentValue; i++)
                            {
                              _nome.add(TextEditingController());
                              _cognome.add(TextEditingController());
                              _mail.add(TextEditingController());
                              _cellulare.add(TextEditingController());
                            }
                          }
                          ),


                        ],
                      ) ,
                    ],
                  )
                  ),

                Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 10,0),
                ),

                Padding(
                  padding: EdgeInsets.fromLTRB(10,0,10,10),
                    child: Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width/1.5,
                            child: AutoSizeText("Data e ora:", maxLines: 10),
                          ),


                        ]
                  ) ,
                ),

                Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 0, 10),
                  child: Container(
                    child: Column(children:
                      [
                        Row(
                          children: [
                            FlatButton(
                              child: Icon(Icons.calendar_today),
                              onPressed: ()async{
                                await _selectDate(context);

                                print(selectedDate);
                                refresh();





                              },
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width/2,
                              child: TextField(
                                readOnly: true,
                                cursorColor: Colors.transparent,
                                textAlign: TextAlign.left,
                                controller: _data,
                                onTap: (){
                                  _selectDate(context);
                                },
                                decoration: InputDecoration(
                                  hoverColor: Colors.transparent,
                                    filled: true,

                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide: BorderSide.none
                                    ),
                                    focusColor: Colors.white,
                                    hintText: "Data selezionata"
                                ),
                              ),
                            )

                          ],
                        ),

                        Row(
                          children: [
                            Radio(
                              value: 0,
                              groupValue: scelta,
                              onChanged: (value){
                                setState(() {
                                  scelta = value;
                                  if(scelta == 0)
                                    {
                                      oraInizio = 18;
                                      oraFine = 19;
                                      refresh();
                                    }
                                });
                              },
                            ),
                            AutoSizeText("dalle 18:00 alle 19:00"),
                          ],
                        ),
                        Row(
                          children: [
                            Radio(
                              value: 1,
                              groupValue: scelta,
                              onChanged: (value){
                                setState(() {
                                  scelta = value;
                                  if(scelta == 1)
                                  {
                                    oraInizio = 19;
                                    oraFine = 20;
                                    refresh();
                                  }
                                });
                              },
                            ),
                            AutoSizeText("dalle 19:00 alle 20:00"),
                          ],
                        ),
                        Row(
                          children: [
                            Radio(
                              value: 2,
                              groupValue: scelta,
                              onChanged: (value){
                                setState(() {
                                  scelta = value;
                                  if(scelta == 2)
                                  {
                                    oraInizio = 20;
                                    oraFine = 21;
                                    refresh();
                                  }
                                });
                              },
                            ),
                            AutoSizeText("dalle 20:00 alle 21:00"),
                          ],
                        ),
                        Row(
                          children: [
                            Radio(
                              value: 3,
                              groupValue: scelta,
                              onChanged: (value){
                                setState(() {
                                  scelta = value;
                                  if(scelta == 3)
                                  {
                                    oraInizio = 21;
                                    oraFine = 22;
                                    refresh();
                                  }

                                });
                              },
                            ),
                            AutoSizeText("dalle 21:00 alle 22:00"),
                          ],
                        ),
                        Row(
                          children: [
                            Radio(
                              value: 4,
                              groupValue: scelta,
                              onChanged: (value){
                                setState(() {
                                  scelta = value;
                                  if(scelta == 4)
                                  {
                                    oraInizio = 22;
                                    oraFine = 23;
                                    refresh();
                                  }
                                });
                              },
                            ),
                            AutoSizeText("dalle 22:00 al termine"),
                          ],
                        ),

                      ]
                    ),
                  ),
                )

              ]
            ),

          ),

          SliverPadding(
              padding: EdgeInsets.all(10),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate((BuildContext context,int i)
                {

                  return Column(
                    children: [

                      SelectTextFiledType("Nome", _nome[i] , 1),
                      SizedBox(height: 5,),
                      SelectTextFiledType("Cognome", _cognome[i], 1),
                      SizedBox(height: 5,),
                      SelectTextFiledType("E-Mail", _mail[i], 1),
                      SizedBox(height: 5,),
                      SelectTextFiledType("Cellulare", _cellulare[i], 1),
                      SizedBox(height:30,),
                    ],
                  );


                },
                  childCount: _currentValue,
                ),
              ),
          ),
          
          SliverPadding(
              padding: EdgeInsets.all(10), 
              sliver: SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Align(
                      alignment: Alignment.center,
                      child: FlatButton(
                        color: Colors.orangeAccent,
                        child: Row(
                          children: [
                            AutoSizeText("Conferma prenotazioni", maxLines: 1,),
                            SizedBox(width: 30,),
                            Icon(Icons.send)
                          ],
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                        ),
                        onPressed: ()async {
                          List<bool> esitinome = new List(_currentValue);
                          List<bool> esiticognome = new List(_currentValue);
                          List<bool> esitimail = new List(_currentValue);
                          List<bool> esiticellulare = new List(_currentValue);
                          for(int i = 0; i < _currentValue; i++)
                            {
                              if (_nome[i].text.toString() == "")
                                {
                                  esitinome[i] = false;
                                }
                              else
                                {
                                  esitinome[i] = true;
                                }
                            }
                          for(int i = 0; i < _currentValue; i++)
                          {
                            if (_cognome[i].text.toString() == "")
                            {
                              esiticognome[i] = false;
                            }
                            else
                            {
                              esiticognome[i] = true;
                            }
                          }
                          for(int i = 0; i < _currentValue; i++)
                          {
                            if (_mail[i].text.toString() == "")
                            {
                              esitimail[i] = false;
                            }
                            else
                            {
                              esitimail[i] = true;
                            }
                          }
                          for(int i = 0; i < _currentValue; i++)
                          {
                            if (_cellulare[i].text.toString() == "")
                            {
                              esiticellulare[i] = false;
                            }
                            else
                            {
                              esiticellulare[i] = true;
                            }
                          }
                          int j = 0;
                          int i = 0;
                          for(i = 0; i < _currentValue; i++)
                            {
                              if(esitinome[i] == true)
                                {
                                  if(esiticognome[i] == true)
                                    {
                                      if(esitimail[i] == true)
                                        {
                                          if (esiticellulare[i] == true)
                                            {
                                              j++;
                                            }
                                        }
                                    }
                                }
                            }

                          if(j != i)
                            {
                              WidgetsBinding.instance.addPostFrameCallback((_) async {
                                await showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) => SelectAlertDialogType("Errore","Devi completare tutti i campi per procedere!"),
                                );
                              });
                            }
                          else
                            {
                              //CONTROLLO CHE DATI DA INSERIRE SIANO MINORI O UGUALI DEI POSTI RIMASTI LIBERI
                              if (int.parse(jsonMassimoPosti==null?"0":jsonMassimoPosti[0]['numero'])-int.parse(listPrenotazioni==null?"0":listPrenotazioni.length.toString()) >= _currentValue)
                                {
                                  print(int.parse(jsonMassimoPosti==null?"0":jsonMassimoPosti[0]['numero'])-int.parse(listPrenotazioni==null?"0":listPrenotazioni.length.toString()));
                                  for(int i = 0; i < _currentValue; i++)
                                    {
                                      String res = await book(_nome[i].text.toString(), _cognome[i].text.toString(), _mail[i].text.toString(), _cellulare[i].text.toString(), selectedDate);
                                      print(res);
                                      if(res.toString() == "404")
                                        {
                                          WidgetsBinding.instance.addPostFrameCallback((_) async {
                                            await showDialog<String>(
                                              context: context,
                                              builder: (BuildContext context) => SelectAlertDialogType("Errore","Prenotazione di "+_nome[i].text.toString()+" "+_cognome[i].text.toString()+ " per il giorno: "+selectedDate.day.toString()+"-"+selectedDate.month.toString()+"-"+selectedDate.year.toString()+" "+oraInizio.toString()+":00 - "+oraFine.toString()+":00"+" già presente nel sistema")
                                            );
                                          });
                                        }
                                      else
                                        {
                                          WidgetsBinding.instance.addPostFrameCallback((_) async {
                                            await showDialog<String>(
                                                context: context,
                                                builder: (BuildContext context) => SelectAlertDialogType("Prenotazione avvenuta","Prenotazione di "+_nome[i].text.toString()+" "+_cognome[i].text.toString()+ " per il giorno: "+selectedDate.day.toString()+"-"+selectedDate.month.toString()+"-"+selectedDate.year.toString()+" "+oraInizio.toString()+":00 - "+oraFine.toString()+":00"+" avvenuta con successo!"
                                                    "\nRiceverai a breve una mail (controlla nello SPAM se non la trovi) che dovrai mostrare all'ingresso dell'evento")
                                            );
                                          });
                                        }
                                    }

                                }
                              else
                                {
                                  WidgetsBinding.instance.addPostFrameCallback((_) async {
                                    await showDialog<String>(
                                      context: context,
                                      builder: (BuildContext context) => SelectAlertDialogType("Errore","Non sono disponibili sufficienti posti, "),
                                    );
                                  });
                                }
                            }

                        },
                      )
                    )


                  ]
                )
              )
          )









        ],
      )

    );

  }



  Future<String>book(String nome, String cognome, String mail, String cellulare,
      DateTime data, ) async {
    Uri uri = Uri.parse(("https://www.kingofthecage.it/API/KotcApp/InsertPrenotazione.php?nome="+nome+"&cognome="+cognome+"&datainizio="+data.year.toString()+"-"+data.month.toString()+"-"+data.day.toString()+" "+oraInizio.toString()+":00:00"+
    "&datafine="+data.year.toString()+"-"+data.month.toString()+"-"+data.day.toString()+" "+oraFine.toString()+":00:00""&mail="+mail+"&cellulare="+cellulare).replaceAll(" ", "%20").replaceAll("'","%27").replaceAll('"', ""));
    print(uri.toString());
    var response = await http.get(uri);
    print(response.body);
    return (response.body);
  }





  SelectTextFiledType(String title, TextEditingController controller, int lines)
  {
    if(Platform.isAndroid)
    {
      return Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white.withOpacity(0.5)),

        child: TextField(
          textInputAction: TextInputAction.next,
          maxLines: lines,
          controller: controller,
          cursorColor: Color.fromARGB(255, 244, 156, 49),
          decoration: InputDecoration(
              filled: true,

              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none
              ),
              focusColor: Colors.white,
              hintText: title
          ),
        ),
      );
    }
    else
    {
      return CupertinoTextField(
        textInputAction: TextInputAction.next,
        controller: controller,
        maxLines: lines,
        placeholder: title,
        decoration: BoxDecoration(
        ),
      );
    }
  }
  SelectAlertDialogType(String Title, String Content)
  {
    if(Platform.isAndroid)
    {
      return AlertDialog(
        title: new Text(Title),
        content: new Text(Content),
        actions: <Widget>[
          new FlatButton(
            child: new Text("OK"),
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
        title: new Text(Title),
        content: new Text(Content),
        actions:  <Widget>[
          new FlatButton(
            child: new Text("OK"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    }
  }

}
