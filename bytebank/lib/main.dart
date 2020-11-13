import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


void main() {
  runApp(
    BytebankApp()
  );
  //runApp(  MyApp());
}
class  BytebankApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Scaffold(
        body: FormularioTransferencia(),
    ),
    );
  }
}
class Transferencia{
  final double valor;
  final int numeroConta;

  Transferencia(this.valor, this.numeroConta);

  @override
  String toString() {
    return 'Transferencia{valor: $valor, numeroConta: $numeroConta}';
  }
}

class FormularioTransferencia extends StatelessWidget {
  final TextEditingController _controladorCampoNumeroConta = TextEditingController();
  final TextEditingController _controladorCampoValor = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title:Text('Criando transferência')),
    body: Column(children: <Widget>[
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextField(style: TextStyle(fontSize: 24.0),
            controller: _controladorCampoNumeroConta,
            decoration: InputDecoration(labelText: 'Número da conta', hintText:'0000'),
          keyboardType: TextInputType.number,
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextField(style: TextStyle(fontSize: 24.0),
          controller: _controladorCampoValor,
          decoration: InputDecoration(icon: Icon(Icons.monetization_on), labelText: 'valor', hintText:'0000'),
          keyboardType: TextInputType.number,
        ),
      ),

      RaisedButton(child: Text( "confirmar"), onPressed: (){
        final int NumeroConta = int.tryParse(_controladorCampoNumeroConta.text);
        final double Valor = double.tryParse(_controladorCampoValor.text);
        if(Valor != null && NumeroConta != null){
          final transferenciaCriada = Transferencia(Valor, NumeroConta);
          
          Scaffold.of(context).showSnackBar(SnackBar( content: Text(transferenciaCriada.toString())));
        }})
    ])
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

class ListaTransferencias extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text('Transferências'),)  ,

      body: Column(
          children: <Widget>[
            ItemTransferencia(Transferencia(100.0, 1000)),
            ItemTransferencia(Transferencia(200.0, 2000)),
            ItemTransferencia(Transferencia(300.0, 3000)),
          ]
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
      ),
    );

  }
}

