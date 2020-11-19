import 'package:bytebank/screens/transferencias/Lista.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(BytebankApp());
  //runApp(  MyApp());
}

class BytebankApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            primaryColor: Colors.blue[200],
            accentColor: Colors.lightBlueAccent,
            buttonTheme: ButtonThemeData(
                buttonColor: Colors.blueAccent,
                textTheme: ButtonTextTheme.primary)),
        home: Scaffold(
            appBar: AppBar(
              title: Text("Dashboard"),
            ),
            body: Column(children: <Widget>[
            Image.asset('images/bytebank_logo.png'),
            Container(
                color: Colors.green,
                width: 320,
                height: 140,
                child: Column(
                    children: <Widget>[
                      Icon(Icons.people),
                      Text('Contacts'),
                    ]

                ))
                ])) //ListaTransferencias(),
    );
  }
}
