import 'package:bytebank/http/webclient.dart';
import 'package:bytebank/models/contact.dart';
import 'package:bytebank/models/transaction.dart';
import 'package:bytebank/screens/contacts/contacts_list.dart';
import 'package:bytebank/screens/transferencias/transactions_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'database/dao/contacts.dart';


final ContactDao _dao = ContactDao();

void main() {
  runApp(BytebankApp());
  // findAll().then((transactions) => print('New transactions: $transactions'));
  // save(Transaction(200.00, Contact(0, 'Roberto Molina', 2000))).then((transaction) => print(transaction));
  _dao.findAll().then((contacts) => debugPrint(contacts.toString()));
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
        backgroundColor: Theme.of(context).primaryColor,
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
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _FeatureItem("Transfer", Icons.monetization_on, onClick: () {
                  return ContactsList();
                }),
                _FeatureItem("Transaction feed", Icons.monetization_on, onClick: () {
                  return ListaTransferencias();
                }),
                _FeatureItem("Transaction feed", Icons.monetization_on, onClick: () {
                  return ContactsList();
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FeatureItem extends StatelessWidget {
  final String nome;
  final IconData icone;
  final Function onClick;

  _FeatureItem(this.nome, this.icone, {@required this.onClick()});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Material(
            child: InkWell(
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => onClick()));
          },
          child: Container(
              padding: EdgeInsets.all(8.0),
              color: Theme.of(context).primaryColor,
              width: 150,
              height: 100,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Icon(icone, color: Colors.white, size: 32.0),
                    Text(nome,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24.0,
                        )),
                  ])),
        )));
  }
}
