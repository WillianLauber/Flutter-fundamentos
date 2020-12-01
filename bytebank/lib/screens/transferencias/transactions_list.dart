import 'package:bytebank/components/centered_message.dart';
import 'package:bytebank/components/progress.dart';
import 'package:bytebank/http/webclient.dart';
import 'package:bytebank/models/transaction.dart';
import 'package:flutter/material.dart';

class ItemTransferencia extends StatelessWidget {
  final Transaction _transferencia;

  ItemTransferencia(this._transferencia);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
        child: ListTile(
            leading: Icon(Icons.monetization_on),
            title: Text(_transferencia.value.toString()),
            subtitle: Text(
              _transferencia.contact.accountNumber.toString(),
              style: TextStyle(
                fontSize: 16.0,
              ),
            )));
  }
}

class ListaTransferenciasState extends State<ListaTransferencias> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Transactions'),
        ),
        body: FutureBuilder<List<Transaction>>(
            initialData: List(),
            future:
                Future.delayed(Duration(seconds: 1)).then((value) => findAll()),
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
                  if(snapshot.hasData) {
                    final List<Transaction> transactions = snapshot.data;
                    if (transactions.isNotEmpty) {
                      return ListView.builder(
                        itemBuilder: (context, indice) {
                          final transferencia = widget._transferencias[indice];
                          print(transferencia);
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
                  }return CenteredMessage(
                    'No transactions found',
                    icon: Icons.warning,
                  );
                  break;
              }
              return Text('Unknown error');
            }));
  }

  void _atualiza(Transaction transferenciaRecebida) {
    if (transferenciaRecebida != null) {
      setState(() {
        widget._transferencias.add(transferenciaRecebida);
      });
    }
  }
}

class ListaTransferencias extends StatefulWidget {
  //objetos que não mudam o valor deixa no stateful, caso do _transferencias, acessar por widget, se fosse um objeto para modificar moveriamos para o State(ListasTransferencaisState
  final List<Transaction> _transferencias = List();

  @override
  State<StatefulWidget> createState() {
    return ListaTransferenciasState();
  }
}
