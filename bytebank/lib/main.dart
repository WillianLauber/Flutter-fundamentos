import 'package:bytebank/screens/transferencias/Lista.dart';
import 'package:bytebank/screens/transferencias/contacts_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'database/app_database.dart';
import 'models/contact.dart';

void main() {
  runApp(BytebankApp());

  save(Contact(0, 'Afran', 2203));
  findAll().then((contacts) => debugPrint(contacts.toString()));
  //runApp(  MyApp());
}

class BytebankApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            primaryColor: Colors.lightBlue[600],
            accentColor: Colors.lightBlueAccent,
            buttonTheme: ButtonThemeData(
                buttonColor: Colors.blueAccent,
                textTheme: ButtonTextTheme.primary)),
        home: DashBoard() //ListaTransferencias(),

    );

  }
}

class DashBoard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme
            .of(context)
            .primaryColor,
        title: Text("Dashboard"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('images/bytebank_logo.png'),
          ),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Material(
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ContactsList()));
                    },
                    child: Container(
                        padding: EdgeInsets.all(8.0),
                        color: Theme
                            .of(context)
                            .primaryColor,
                        width: 150,
                        height: 100,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Icon(Icons.people, color: Colors.white,
                                  size: 32.0),
                              Text('Contacts',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24.0,
                                  )),
                            ])),
                  )))
        ],
      ),
    );
  }
}
