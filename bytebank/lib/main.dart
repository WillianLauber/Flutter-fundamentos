import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

final TextEditingController _controladorCampoNumeroConta =
    TextEditingController();
final TextEditingController _controladorCampoValor = TextEditingController();

void main() {
  runApp(BytebankApp());
  //runApp(  MyApp());
}

class BytebankApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ListaTransferencias(),
      ),
    );
  }
}

class Transferencia {
  final double valor;
  final int numeroConta;

  Transferencia(this.valor, this.numeroConta);

  @override
  String toString() {
    return 'Transferencia{valor: $valor, numeroConta: $numeroConta}';
  }
}

class FormularioTransferencia extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Criando transferência')),
        body: Column(
          children: <Widget>[
            Editor(
                controlador: _controladorCampoNumeroConta,
                rotulo: 'Número da conta',
                dica: '0000'),
            Editor(
                controlador: _controladorCampoValor,
                rotulo: 'valor',
                dica: '100.93',
                icone: Icon(Icons.monetization_on)),
            RaisedButton(
                child: Text("confirmar"),
                onPressed: () => _criarTransferencia(context))
          ],
        ));
  }
}

void _criarTransferencia(BuildContext context) {
  final int NumeroConta = int.tryParse(_controladorCampoNumeroConta.text);
  final double Valor = double.tryParse(_controladorCampoValor.text);
  if (Valor != null && NumeroConta != null) {
    final transferenciaCriada = Transferencia(Valor, NumeroConta);
    debugPrint('criando transferencia');
    Navigator.pop(context, transferenciaCriada);

    Scaffold.of(context)
        .showSnackBar(SnackBar(content: Text(transferenciaCriada.toString())));

  }
}

class Editor extends StatelessWidget {
  final TextEditingController controlador;
  final String rotulo;
  final String dica;
  final Icon icone;

  Editor({this.controlador, this.rotulo, this.dica, this.icone});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        style: TextStyle(fontSize: 24.0),
        controller: this.controlador,
        decoration: InputDecoration(
            icon: icone != null ? icone : null,
            labelText: rotulo,
            hintText: dica),
        keyboardType: TextInputType.number,
      ),
    );
  }
}

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
      ),
    );
  }
}

class ListaTransferencias extends StatelessWidget {
  final List<Transferencia> _transferencias = List();
  @override
  Widget build(BuildContext context) {

    _transferencias.add(Transferencia(100.0, 1000));
    return Scaffold(
      appBar: AppBar(
        title: Text('Transferências'),
      ),
      body: ListView.builder(
        itemCount: _transferencias.length,
        itemBuilder: (context, indice){
          final transferencia = _transferencias[indice];
       return ItemTransferencia(transferencia);

        }
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          final Future<Transferencia> future =
              Navigator.push(context, MaterialPageRoute(builder: (context) {
            return FormularioTransferencia();
          }));
          future.then((transferenciaRecebida) {
            _transferencias.add(transferenciaRecebida);
            debugPrint('chegou no then do future');
            debugPrint('$transferenciaRecebida');
          });
        },
      ),
    );
  }
}
