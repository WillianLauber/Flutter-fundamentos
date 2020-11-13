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
      home: Scaffold(
        body: ListaTransferencias(),
      ),
    );
  }
}

class Transferencia {
  final int numeroConta;
  final double valor;
  Transferencia(this.numeroConta, this.valor);

  @override
  String toString() {
    return 'Transferencia{numeroConta: $numeroConta, valor: $valor}';
  }
}

class FormularioTransferencia extends StatefulWidget {


  @override
  State<StatefulWidget> createState() {
    return TransferenciaState();
  }}

  class TransferenciaState extends State<FormularioTransferencia>{

    final TextEditingController _controladorCampoNumeroConta =
    TextEditingController();
    final TextEditingController _controladorCampoValor = TextEditingController();

    @override
    Widget build(BuildContext context) {
      return Scaffold(
          appBar: AppBar(title: Text('Criando transferência')),
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Editor(
                    controlador: _controladorCampoNumeroConta,
                    rotulo: 'Número da conta',
                    dica: '0000'),
                Editor(
                    controlador: _controladorCampoValor,
                    rotulo: 'valor',
                    dica: '100.93',
                    icone: Icons.monetization_on),
                RaisedButton(
                    child: Text("confirmar"),
                    onPressed: () => _criarTransferencia(context))
              ],
            ),
          ));
    }

    void _criarTransferencia(BuildContext context) {
      final int NumeroConta = int.tryParse(_controladorCampoNumeroConta.text);
      final double Valor = double.tryParse(_controladorCampoValor.text);
      if (Valor != null && NumeroConta != null) {
        final transferenciaCriada = Transferencia(NumeroConta, Valor);
        debugPrint('criando transferencia');
        Navigator.pop(context, transferenciaCriada);

        // Scaffold.of(context)
        //     .showSnackBar(SnackBar(content: Text(transferenciaCriada.toString())));

      }}
  }
class Editor extends StatelessWidget {
  final TextEditingController controlador;
  final String rotulo;
  final String dica;
  final IconData icone;

  Editor({this.controlador, this.rotulo, this.dica, this.icone});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        style: TextStyle(fontSize: 24.0),
        controller: controlador,
        decoration: InputDecoration(
            icon: icone != null ? Icon(icone) : null,
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
          final Future<Transferencia> future =
              Navigator.push(context, MaterialPageRoute(builder: (context) {
            return FormularioTransferencia();
          }));
          future.then((transferenciaRecebida) {
            debugPrint('chegou no then do future');
            debugPrint('$transferenciaRecebida');

            if(transferenciaRecebida != null) {
              debugPrint('transferencia não nula');
              setState(() {//bug comum, não atualizar o conteúdo quando não se usa o setState no stateful
                widget._transferencias.add(transferenciaRecebida);
              });
            }
          });
        },
      ),
    );
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
