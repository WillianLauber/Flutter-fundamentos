import 'package:bytebank/models/transaction.dart';
import 'package:flutter/material.dart';

import 'transactions_form.dart';

class ItemTransferencia extends StatelessWidget {
  final Transaction _transferencia;

  ItemTransferencia(this._transferencia);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
        child: ListTile(
        leading: Icon(Icons.monetization_on),
    title: Text(_transferencia.valor.toString()),
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
    //sempre executado quando muda de tela, faz atualização...

    //uso do widget comentado na classe ListaTransferencias
    return Scaffold(
      appBar: AppBar(
        title: Text('Transferências'),
      ),
      body: ListView.builder(
          itemCount: widget._transferencias.length,
          itemBuilder: (context, indice) {
            final transferencia = widget._transferencias[indice];
            return ItemTransferencia(transferencia);
          }),

    );
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
