import 'package:bytebank/components/centered_message.dart';
import 'package:bytebank/components/progress.dart';
import 'package:bytebank/http/webClients/transaction_webClient.dart';
import 'package:bytebank/models/transaction.dart';
import 'package:flutter/material.dart';

class ItemTransferencia extends StatefulWidget {
  final Transaction _transferencia;
  ItemTransferencia(this._transferencia);

  @override
  _ItemTransferenciaState createState() => _ItemTransferenciaState();
}

class _ItemTransferenciaState extends State<ItemTransferencia> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
        child: ListTile(
            leading: Icon(Icons.monetization_on),
            title: Text(widget._transferencia.value.toString()),
            subtitle: Text(
              widget._transferencia.contact.accountNumber.toString(),
              style: TextStyle(
                fontSize: 16.0,
              ),
            )));
  }
}

class TransactionList extends StatelessWidget {

  final TransactionWebClient _webClient = TransactionWebClient();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Transactions'),
        ),
        body: FutureBuilder<List<Transaction>>(
            future: _webClient.findAll(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  break;
                case ConnectionState.waiting:
                  return Progress();
                  break;
                case ConnectionState.active:
                  break;
                case ConnectionState.done:
                  if (snapshot.hasData) {
                    final List<Transaction> transactions = snapshot.data;
                    if (transactions.isNotEmpty) {
                      return ListView.builder(
                        itemBuilder: (context, indice) {
                          final Transaction transferencia = transactions[indice];
                          return Card(
                            child: ListTile(
                              leading: Icon(Icons.monetization_on),
                              title: Text(
                                transferencia.value.toString(),
                                style: TextStyle(
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                transferencia.contact.accountNumber.toString(),
                                style: TextStyle(
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
                          );
                        },
                        itemCount: transactions.length,
                      );
                    }
                  }
                  return CenteredMessage(
                    'No transactions found',
                    icon: Icons.warning,
                  );
                  break;
              }
              return Text('Unknown error');
            }));
  }
}
