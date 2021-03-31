import 'package:bytebank/http/webClients/transaction_webClient.dart';
import 'package:bytebank/screens/contacts/contacts_list.dart';
import 'package:bytebank/screens/transferencias/transactions_list.dart';
import 'package:bytebank/widgets/app_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'database/dao/contacts.dart';


void main() {
  runApp(BytebankApp(contactDao: ContactDao(), webClient: TransactionWebClient(),));
  // findAll().then((transactions) => print('New transactions: $transactions'));
  // save(Transaction(200.00, Contact(0, 'Roberto Molina', 2000))).then((transaction) => print(transaction));
  //runApp(  MyApp());
}

class BytebankApp extends StatelessWidget {
  final ContactDao contactDao;
  final TransactionWebClient webClient;
  BytebankApp({@required this.contactDao, @required this.webClient});
  @override
  Widget build(BuildContext context) {
    return AppDependencies(
      contactDao: contactDao,
      webClient: webClient,
      child: MaterialApp(
          theme: ThemeData(
              primaryColor: Colors.lightBlue[600],
              accentColor: Colors.lightBlueAccent,
              buttonTheme: ButtonThemeData(
                  buttonColor: Colors.blueAccent,
                  textTheme: ButtonTextTheme.primary)),
          home: DashBoard() //ListaTransferencias(),

          ),
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
      body: LayoutBuilder(

              builder: (context, constraints) => SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(
            minHeight: constraints.maxHeight
        ),
        child:Column(
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
                      FeatureItem("Transfer", Icons.monetization_on, onClick: () {
                        return ContactsList();
                      }),
                      FeatureItem("Transaction feed", Icons.description,
                          onClick: () {
                        return TransactionList();
                      }),

                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FeatureItem extends StatelessWidget {
   String nome;
   IconData icone;
   Function onClick;

  FeatureItem(this.nome, this.icone, {@required this.onClick()});

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
              height: 150,
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
