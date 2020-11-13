import 'package:bytebank/models/Transferencia.dart';
import 'package:flutter/material.dart';

import 'Formulario.dart';

class ItemTransferencia extends StatelessWidget {
  final Transferencia _transferencia;

  ItemTransferencia(this._transferencia);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      child: ListTile(
        leading: Icon(Icons.monetization_on),
        title: Text(_transferencia.valor.toString()),
        subtitle: Text(_transferencia.numeroConta.toString()),

    ));
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
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return FormularioTransferencia();
          })).then(
            (transferenciaRecebida) => _atualiza(transferenciaRecebida),
          );
        },
      ),
    );
  }

  void _atualiza(Transferencia transferenciaRecebida) {
    if (transferenciaRecebida != null) {
      setState(() {
        widget._transferencias.add(transferenciaRecebida);
      });
    }
  }
}

class ListaTransferencias extends StatefulWidget {
  //objetos que não mudam o valor deixa no stateful, caso do _transferencias, acessar por widget, se fosse um objeto para modificar moveriamos para o State(ListasTransferencaisState
  final List<Transferencia> _transferencias = List();

  @override
  State<StatefulWidget> createState() {
    return ListaTransferenciasState();
  }
}
