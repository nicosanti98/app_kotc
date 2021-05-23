import 'dart:io';

import 'package:app_kotc/HomePage.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class Iscrizione extends StatefulWidget{

  @override
  StateIscrizione createState()=> StateIscrizione();

}


class StateIscrizione extends State<Iscrizione>{
  bool filled = true;
  bool trattamento = false;
  int _sesso = -1 ;
  final CarouselController _controller = CarouselController();
  final nomeSquadra = TextEditingController();
  final nome1 = TextEditingController();
  final nome2 = TextEditingController();
  final nome3 = TextEditingController();
  final nome4 = TextEditingController();
  final cognome1 = TextEditingController();
  final cognome2 = TextEditingController();
  final cognome3 = TextEditingController();
  final cognome4 = TextEditingController();
  final luogonascita1 = TextEditingController();
  final luogonascita2 = TextEditingController();
  final luogonascita3 = TextEditingController();
  final luogonascita4 = TextEditingController();
  final cf1 = TextEditingController();
  final cf2 = TextEditingController();
  final cf3 = TextEditingController();
  final cf4 = TextEditingController();

  final mail1 = TextEditingController();
  final mail2 = TextEditingController();
  final mail3 = TextEditingController();
  final mail4 = TextEditingController();
  final cellulare1 = TextEditingController();
  final cellulare2 = TextEditingController();
  final cellulare3 = TextEditingController();
  final cellulare4 = TextEditingController();

  final via = TextEditingController();
  final citta = TextEditingController();
  final cap = TextEditingController();
  final provincia = TextEditingController();

  SelectTextFiledType(String title, TextEditingController controller)
  {
    if(Platform.isAndroid)
      {
        return TextField(
          controller: controller,
          decoration: InputDecoration(
              border: UnderlineInputBorder(),
            labelText: title
          ),
        );
      }
    else
      {
        return CupertinoTextField(
          controller: controller,
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
  SelectYesNoDialogType(String Title, String Content) {

    if(Platform.isAndroid)
    {
      return AlertDialog(
        title: new Text(Title),
        content: new Text(Content),
        actions: <Widget>[
          new FlatButton(
            child: new Text("Si"),
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop(true);
            },
          ),
          new FlatButton(
              onPressed: (){
                Navigator.of(context, rootNavigator: true).pop(false);
              }, child: new Text("No"))
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
            child: new Text("Si"),
            onPressed: () {
              Navigator.of(context).pop(true);
            },
          ),
          new FlatButton(
              onPressed: (){
                Navigator.of(context).pop(false);
              }, child: new Text("No"))
        ],
      );
    }

  }

  returnModules()
  {
    return <Widget>[
      Container(
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height/10,
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            Container(
              width: (MediaQuery.of(context).size.width-40)/2,
              child: Column(
                children: [
                  Radio(
                    value: 0,
                    groupValue: _sesso,
                    onChanged: (value){
                      setState(() {
                        _sesso = value;
                      });
                    },
                  ),
                  AutoSizeText("KOTC Maschile", maxLines: 1,)
                ],
              ),
            ),
            Container(
                width: (MediaQuery.of(context).size.width-40)/2,
                child: Column(
                  children: [
                    Radio(
                      value: 1,
                      groupValue: _sesso,
                      onChanged: (value){
                        _sesso = value;
                        setState(() {

                        });
                      },
                    ),
                    AutoSizeText("KOTC Femminile", maxLines: 1,)
                  ],
                )
            ),



          ],
        )
        ,
      ),

      SelectTextFiledType("Inserisci il nome della tua squadra", nomeSquadra),


      Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width-40,
            child: AutoSizeText("Giocatore 1", maxLines: 1, style: TextStyle(fontSize: 20,), textAlign: TextAlign.left,),
          ),
          Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  Container(
                      width: (MediaQuery.of(context).size.width-60)/2,
                      child:SelectTextFiledType("Nome", nome1),
                  ),
                  SizedBox(width: 20,),
                  Container(
                      width: (MediaQuery.of(context).size.width-60)/2,
                      child: SelectTextFiledType("Cognome", cognome1),
                  ),
                ],
              )

          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: [
                Container(
                  width: (MediaQuery.of(context).size.width-60)/2,
                  child: FlatButton(
                      onPressed: () => _selectDate(context, 0),
                      child:Row(
                        children: [
                          Icon(Icons.calendar_today),
                          SizedBox(width: 5,),
                          AutoSizeText(DateTime.now().difference(currentDate[0]).inDays < 1?"Data Nascita": currentDate[0].day.toString()+"/"+currentDate[0].month.toString()+"/"+currentDate[0].year.toString(), maxLines: 1,)
                        ],
                      )
                  ),
                  alignment: Alignment.bottomCenter,
                ),
                SizedBox(width: 20,),
                Container(
                    width: (MediaQuery.of(context).size.width-60)/2,
                    child: SelectTextFiledType("Luogo Nascita", luogonascita1),
                ),
              ],
            ),
          ),
          SelectTextFiledType("Codice Fiscale", cf1),
          Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  Container(
                      width: (MediaQuery.of(context).size.width-60)/2,
                      child: SelectTextFiledType("Mail", mail1),
                  ),
                  SizedBox(width: 20,),
                  Container(
                      width: (MediaQuery.of(context).size.width-60)/2,
                      child:SelectTextFiledType("Cellulare", cellulare1),
                  ),
                ],
              )

          ),
          Divider(
            color: Colors.orange,
          ),
          AutoSizeText("*Nota: I campi in basso sono necessari per l'emissione della fattura", maxLines: 1,),
          SelectTextFiledType("Indirizzo", via),
          Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  Container(
                      width: (MediaQuery.of(context).size.width-80)/3,
                      child: SelectTextFiledType("Città", citta),
                  ),
                  SizedBox(width: 20,),
                  Container(
                      width: (MediaQuery.of(context).size.width-80)/3,
                      child: SelectTextFiledType("Provincia", provincia),
                  ),
                  SizedBox(width: 20,),
                  Container(
                      width: (MediaQuery.of(context).size.width-80)/3,
                      child: SelectTextFiledType("CAP", cap),
                  ),
                ],
              )

          ),
        ],
      ),
      Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width-40,
            child: AutoSizeText("Giocatore 2", maxLines: 1, style: TextStyle(fontSize: 20,), textAlign: TextAlign.left,),
          ),
          Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  Container(
                      width: (MediaQuery.of(context).size.width-60)/2,
                      child: SelectTextFiledType("Nome", nome2),
                  ),
                  SizedBox(width: 20,),
                  Container(
                      width: (MediaQuery.of(context).size.width-60)/2,
                      child: SelectTextFiledType("Cognome", cognome2),
                  ),
                ],
              )

          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: [
                Container(
                  width: (MediaQuery.of(context).size.width-60)/2,
                  child: FlatButton(
                      onPressed: () => _selectDate(context, 1),
                      child:Row(
                        children: [
                          Icon(Icons.calendar_today),
                          SizedBox(width: 5,),
                          AutoSizeText(DateTime.now().difference(currentDate[1]).inDays < 1?"Data Nascita": currentDate[1].day.toString()+"/"+currentDate[1].month.toString()+"/"+currentDate[1].year.toString(), maxLines: 1,)
                        ],
                      )
                  ),
                  alignment: Alignment.bottomCenter,
                ),
                SizedBox(width: 20,),
                Container(
                    width: (MediaQuery.of(context).size.width-60)/2,
                    child: SelectTextFiledType("Luogo Nascita", luogonascita2),
                ),
              ],
            ),
          ),
          SelectTextFiledType("Codice Fiscale", cf2),
          Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  Container(
                      width: (MediaQuery.of(context).size.width-60)/2,
                      child: SelectTextFiledType("Mail", mail2),
                  ),
                  SizedBox(width: 20,),
                  Container(
                      width: (MediaQuery.of(context).size.width-60)/2,
                      child: SelectTextFiledType("Cellulare", cellulare2),
                  ),
                ],
              )

          ),

        ],
      ), Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width-40,
            child: AutoSizeText("Giocatore 3", maxLines: 1, style: TextStyle(fontSize: 20,), textAlign: TextAlign.left,),
          ),
          Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  Container(
                      width: (MediaQuery.of(context).size.width-60)/2,
                      child: SelectTextFiledType("Nome", nome3),
                  ),
                  SizedBox(width: 20,),
                  Container(
                      width: (MediaQuery.of(context).size.width-60)/2,
                      child: SelectTextFiledType("Cognome", cognome3),
                  ),
                ],
              )

          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: [
                Container(
                  width: (MediaQuery.of(context).size.width-60)/2,
                  child: FlatButton(
                      onPressed: () => _selectDate(context, 2),
                      child:Row(
                        children: [
                          Icon(Icons.calendar_today),
                          SizedBox(width: 5,),
                          AutoSizeText(DateTime.now().difference(currentDate[2]).inDays < 1?"Data Nascita": currentDate[2].day.toString()+"/"+currentDate[2].month.toString()+"/"+currentDate[2].year.toString(), maxLines: 1,)
                        ],
                      )
                  ),
                  alignment: Alignment.bottomCenter,
                ),
                SizedBox(width: 20,),
                Container(
                    width: (MediaQuery.of(context).size.width-60)/2,
                    child: SelectTextFiledType("Luogo Nascita", luogonascita3),
                ),
              ],
            ),
          ),
          SelectTextFiledType("Codice Fiscale", cf3),
          Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  Container(
                      width: (MediaQuery.of(context).size.width-60)/2,
                      child: SelectTextFiledType("Mail", mail3),
                  ),
                  SizedBox(width: 20,),
                  Container(
                      width: (MediaQuery.of(context).size.width-60)/2,
                      child: SelectTextFiledType("Cellulare", cellulare3),
                  ),
                ],
              )

          ),

        ],
      ),
      Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width-40,
            child: AutoSizeText("Giocatore 4", maxLines: 1, style: TextStyle(fontSize: 20,), textAlign: TextAlign.left,),
          ),
          Container(width: MediaQuery.of(context).size.width-40,
            child: AutoSizeText("*Nota: Non riempire questi campi nel caso in cui la tua squadra sia composta da 3 giocatori", maxLines: 2, style: TextStyle(fontSize: 10,), textAlign: TextAlign.left,),),
          Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  Container(
                      width: (MediaQuery.of(context).size.width-60)/2,
                      child: SelectTextFiledType("Nome", nome4),
                  ),
                  SizedBox(width: 20,),
                  Container(
                      width: (MediaQuery.of(context).size.width-60)/2,
                      child: SelectTextFiledType("Cognome", cognome4),
                  ),
                ],
              )

          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: [
                Container(
                  width: (MediaQuery.of(context).size.width-60)/2,
                  child: FlatButton(
                      onPressed: () => _selectDate(context, 3),
                      child:Row(
                        children: [
                          Icon(Icons.calendar_today),
                          SizedBox(width: 5,),
                          AutoSizeText(DateTime.now().difference(currentDate[3]).inDays < 1?"Data Nascita": currentDate[3].day.toString()+"/"+currentDate[3].month.toString()+"/"+currentDate[3].year.toString(), maxLines: 1,)
                        ],
                      )
                  ),
                  alignment: Alignment.bottomCenter,
                ),
                SizedBox(width: 20,),
                Container(
                    width: (MediaQuery.of(context).size.width-60)/2,
                    child: SelectTextFiledType("Luogo Nascita", luogonascita4),
                ),
              ],
            ),
          ),
          SelectTextFiledType("Codice Fiscale", cf4),
          Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  Container(
                      width: (MediaQuery.of(context).size.width-60)/2,
                      child: SelectTextFiledType("Mail", mail4),
                  ),
                  SizedBox(width: 20,),
                  Container(
                      width: (MediaQuery.of(context).size.width-60)/2,
                      child: SelectTextFiledType("Cellulare", cellulare4),
                  ),
                ],
              )

          ),

        ],
      ),

      Column(
        children:[
          AutoSizeText("Trattamento dati personali", maxLines: 1, style: TextStyle(fontSize: 20,), textAlign: TextAlign.left,),
          Container(
            height: MediaQuery.of(context).size.height/2,
            child: ListView(
              children: [

                Text("Informativa resa ai sensi degli articoli 13-14 del GDPR 2016/679 (General Data Protection Regulation)\n\n"
                    "Gentile Signore/a,\n"
                    "ai sensi dell’art. 13 del Regolamento UE 2016/679 ed in relazione alle informazioni di cui si entrerà in possesso, ai fini della"
                    " tutela delle persone e altri soggetti in materia di trattamento di dati personali, si informa quanto segue:"
                    "\n\n1. Finalità del Trattamento\n"
                    "I dati da Lei forniti verranno utilizzati solo ed esclusivamente nell'ambito del torneo King of the Cage, "
                    "nello specifico verranno memorizzati ed utilizzati per la gestione delle iscrizioni e per l'emissione della fattura per la quota di iscrizione. "
                    "\n\n2. Titolare del Trattamento\n"
                    "Il titolare del trattamento dei dati personali è la ditta SANTINI NICOLO, nella persona di Nicolò Santini, "
                    "Via Enrico Fermi 39, Senigallia (AN)."
                    "\n\n3. Diritti dell’interessato\n"
                    "In ogni momento, Lei potrà esercitare, ai sensi degli articoli dal 15 al 22 del Regolamento UE n. 2016/679, il diritto di:"
  "\na) chiedere la conferma dell’esistenza o meno di propri dati personali;"
  "\nb) ottenere le indicazioni circa le finalità del trattamento, le categorie dei dati personali, i destinatari o le categorie di"
  " destinatari a cui i dati personali sono stati o saranno comunicati e, quando possibile, il periodo di conservazione;"
  "\nc) ottenere la rettifica e la cancellazione dei dati;"
    "\nd) ottenere la limitazione del trattamento;"
    "\ne) ottenere la portabilità dei dati, ossia riceverli da un titolare del trattamento, in un formato strutturato, di uso comune e"
    " leggibile da dispositivo automatico, e trasmetterli ad un altro titolare del trattamento senza impedimenti;"
    "\nf) opporsi al trattamento in qualsiasi momento ed anche nel caso di trattamento per finalità di marketing diretto;"
    "\ng) opporsi ad un processo decisionale automatizzato relativo alle persone siche, compresa la profilazione."
    "\nh) chiedere al titolare del trattamento l’accesso ai dati personali e la rettifica o la cancellazione degli stessi o la limitazione"
  " del trattamento che lo riguardano o di opporsi al loro trattamento, oltre al diritto alla portabilità dei dati;"
  "\ni) revocare il consenso in qualsiasi momento senza pregiudicare la liceità del trattamento basata sul consenso prestato"
  " prima della revoca;"
  "\nj) proporre reclamo a un’autorità di controllo."),
              ]



            ),
          ),SizedBox(height: 40,),
          Row(
            children: [
              Checkbox(
                  value: trattamento,
                  onChanged: (bool value){
                    setState(() {
                      trattamento = value;
                      print(trattamento);
                    });
                  }),

              AutoSizeText("Accetto il trattamento dei dati personali", maxLines: 1,)
              
            ],
          )
          


        ]
      ),
      Center(
        child:Container(
  alignment: Alignment.center,
  child: Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      RaisedButton(
        color: Color.fromARGB(255, 244, 156, 49),disabledColor: Color.fromARGB(255, 244, 156, 49),
        child: Icon(Icons.send, color: Colors.black,),
        onPressed: ()async {
          var res = ['false', 'false', 'false', 'false'];
          bool showdialogres = await showDialog(
              context: context,
              builder: (context){
                return SelectYesNoDialogType("Attenzione!", "Confermi che i dati inseriti sono corretti? Procedere all'iscrizione?");
              });

          if(showdialogres)
            {

              res[0] = await subscirbe(nome1.text, cognome1.text, luogonascita1.text, cf1.text, mail1.text, cellulare1.text, via.text, citta.text, provincia.text, cap.text, currentDate[0], nomeSquadra.text);
              res[1] = await subscirbe(nome2.text, cognome2.text, luogonascita2.text, cf2.text, mail2.text, cellulare2.text, "","","","", currentDate[1], nomeSquadra.text);
              res[2] = await subscirbe(nome3.text, cognome3.text, luogonascita3.text, cf3.text, mail3.text, cellulare3.text, "","","","", currentDate[2], nomeSquadra.text);
              res[3] = await subscirbe(nome4.text, cognome4.text, luogonascita4.text, cf4.text, mail4.text, cellulare4.text, "","","","", currentDate[3], nomeSquadra.text);

              if(res[0] == 'true' && res[1] == 'true' && res[2] == 'true' && res[3] == 'true')
              {
                WidgetsBinding.instance.addPostFrameCallback((_) async {
                  await showDialog<String>(
                    context: context,
                    builder: (BuildContext context) =>
                        SelectAlertDialogType("Successo",
                            "Hai iscritto la tua squadra con successo, verrà inviata una mail a tutti gli atleti come conferma dell'iscrizione. Se non dovessi trovarla, controlla sulla cartella SPAM"),

                  );
                  sendMail(mail1.text, "KOTC: Avvenuta iscrizione "+nome1.text.toUpperCase()+" "+cognome1.text.toUpperCase(), "Hai iscritto correttamente la squadra: "+nomeSquadra.text.toUpperCase()+" al King of the Cage 2021. I tuoi compagni sono: "+nome2.text.toUpperCase()+" "+cognome2.text.toUpperCase()+", "+nome3.text.toUpperCase()+" "+cognome3.text.toUpperCase()+", "+nome4.text.toUpperCase()+" "+cognome4.text.toUpperCase()+".\nI dati inseriti verranno controllati dallo staff del KOTC e verranno validati manualmente. Nel caso di problemi verrete prontamente contattati.\n\nRicordiamo che causa COVID-19, vista la necessità di maggior spazio, quest'anno il KOTC si svolgerà in Piazzale della Libertà, Senigallia(AN), anzichè nella consueta location di Piazza del Duca, dal 15 al 18 Luglio 2021. ");
                  sendMail(mail2.text, "KOTC: Avvenuta iscrizione! "+nome2.text.toUpperCase()+" "+cognome2.text.toUpperCase(), "Hai iscritto correttamente la squadra: "+nomeSquadra.text.toUpperCase()+" al King of the Cage 2021. I tuoi compagni sono: "+nome1.text.toUpperCase()+" "+cognome1.text.toUpperCase()+", "+nome3.text.toUpperCase()+" "+cognome3.text.toUpperCase()+", "+nome4.text.toUpperCase()+" "+cognome4.text.toUpperCase()+".\nI dati inseriti verranno controllati dallo staff del KOTC e verranno validati manualmente. Nel caso di problemi verrete prontamente contattati.\n\nRicordiamo che causa COVID-19, vista la necessità di maggior spazio, quest'anno il KOTC si svolgerà in Piazzale della Libertà, Senigallia(AN), anzichè nella consueta location di Piazza del Duca, dal 15 al 18 Luglio 2021. ");
                  sendMail(mail3.text, "KOTC: Avvenuta iscrizione! "+nome3.text.toUpperCase()+" "+cognome3.text.toUpperCase(), "Hai iscritto correttamente la squadra: "+nomeSquadra.text.toUpperCase()+" al King of the Cage 2021. I tuoi compagni sono: "+nome2.text.toUpperCase()+" "+cognome2.text.toUpperCase()+", "+nome1.text.toUpperCase()+" "+cognome1.text.toUpperCase()+", "+nome4.text.toUpperCase()+" "+cognome4.text.toUpperCase()+".\nI dati inseriti verranno controllati dallo staff del KOTC e verranno validati manualmente. Nel caso di problemi verrete prontamente contattati.\n\nRicordiamo che causa COVID-19, vista la necessità di maggior spazio, quest'anno il KOTC si svolgerà in Piazzale della Libertà, Senigallia(AN), anzichè nella consueta location di Piazza del Duca, dal 15 al 18 Luglio 2021. ");
                  sendMail(mail4.text, "KOTC: Avvenuta iscrizione! "+nome4.text.toUpperCase()+" "+cognome4.text.toUpperCase(), "Hai iscritto correttamente la squadra: "+nomeSquadra.text.toUpperCase()+" al King of the Cage 2021. I tuoi compagni sono: "+nome2.text.toUpperCase()+" "+cognome2.text.toUpperCase()+", "+nome3.text.toUpperCase()+" "+cognome3.text.toUpperCase()+", "+nome1.text.toUpperCase()+" "+cognome1.text.toUpperCase()+".\nI dati inseriti verranno controllati dallo staff del KOTC e verranno validati manualmente. Nel caso di problemi verrete prontamente contattati.\n\nRicordiamo che causa COVID-19, vista la necessità di maggior spazio, quest'anno il KOTC si svolgerà in Piazzale della Libertà, Senigallia(AN), anzichè nella consueta location di Piazza del Duca, dal 15 al 18 Luglio 2021. ");
                  Navigator.push(context,
                      MaterialPageRoute(
                      builder: (context) => HomePage()));
                });
              }
              else
                {
                  WidgetsBinding.instance.addPostFrameCallback((_) async {
                    await showDialog<String>(
                      context: context,
                      builder: (BuildContext context) =>
                          SelectAlertDialogType("Ops!",
                              "Qualcosa è andato storto, riprovare."),
                    );
                  });
                }
            }



        },
      ), SizedBox(width: 20,),AutoSizeText("Completa Iscrizione", maxLines: 1),

    ],
  ),
  )


      )


    ];
  }
  Future<String>subscirbe(String nome, String cognome, String luogonascita, String cf, String mail, String cellulare, String indirizzo, String citta, String prov,
      String cap, DateTime datanascita, String squadra ) async {
    Uri uri = Uri.parse(("https://www.kingofthecage.it/API/KotcApp/InsertPlayersInDb.php?nome="+nome+"&cognome="+cognome+"&data="+datanascita.toString()+"&cf="+cf+
    "&mail="+mail+"&cellulare="+cellulare+"&squadra="+squadra+"&luogo="+luogonascita+"&via="+indirizzo+"&citta="+citta+"&cap="+cap+"&prov="+prov).replaceAll(" ", "%20").replaceAll("'","%27"));
    var response = await http.get(uri);
    print(("https://www.kingofthecage.it/API/KotcApp/InsertPlayersInDb.php?nome="+nome+"&cognome="+cognome+"&data="+datanascita.toString()+"&cf="+cf+
        "&mail="+mail+"&cellulare="+cellulare+"&squadra="+squadra+"&luogo="+luogonascita+"&via="+indirizzo+"&citta="+citta+"&cap="+cap+"&prov="+prov).replaceAll(" ", "%20").replaceAll("'","%27"));
    print(response.body);
    return (response.body);
  }
  Future<String> sendMail(String to, String subject, String body)async {
    Uri uri = Uri.parse(("https://www.kingofthecage.it/API/KotcApp/SendMail.php?destinatario="+to+"&body="+body+"&oggetto="+subject).replaceAll(" ", "%20").replaceAll("'","%27"));
    var response = await http.get(uri);
    return (response.body);
  }
  List<DateTime> currentDate = [DateTime.now(), DateTime.now(), DateTime.now(), DateTime.now()];
  Future<void> _selectDate(BuildContext context, int i) async {
    final DateTime pickedDate = await showDatePicker(

        context: context,
        initialDate: currentDate.elementAt(i),
        firstDate: DateTime(1960),
        lastDate: DateTime(DateTime.now().year+1));
    if (pickedDate != null && pickedDate != currentDate.elementAt(i))
      setState(() {
        currentDate[i]= pickedDate;
      });
  }
  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body:Column(
          children: [

              Padding(
              padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
              child: Row(
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    child:FlatButton(
                        minWidth: 10,
                        onPressed:(){Navigator.of(context).pop();},
                        child: Icon(Icons.arrow_back)),

                  ),
                  Container(
                    width: MediaQuery.of(context).size.width-70,
                    child:  AutoSizeText("Iscriviti Ora", maxLines:1,style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, letterSpacing: 1), textAlign: TextAlign.left,),
                  ),

                ],
              ),
            ),

            Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Divider(
            color:  Color.fromARGB(255, 244, 156, 49),
            ),
            ),


            //Iscrizione
            Padding(padding: EdgeInsets.all(20),
            child: Center(

              child:
                  Container(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          CarouselSlider(
                            items: returnModules(),
                            options: CarouselOptions(enlargeCenterPage: true, viewportFraction: 1.0, height: MediaQuery.of(context).size.height/1.5, disableCenter: true, enableInfiniteScroll: false, initialPage: 0),
                            carouselController: _controller,
                          ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    alignment: Alignment.center,
                                    child: FlatButton(
                                      onPressed: () => _controller.previousPage(),
                                      child: Icon(Platform.isAndroid?Icons.arrow_back:Icons.arrow_back_ios_outlined ),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    child: FlatButton(
                                      onPressed: () => _controller.nextPage(),
                                      child: Icon(Platform.isAndroid?Icons.arrow_forward:Icons.arrow_forward_ios_outlined ),
                                    ),
                                  ),



                                ],
                              )
                        ],
                      )
                  ),

            ),)



      ])
    );
  }

}