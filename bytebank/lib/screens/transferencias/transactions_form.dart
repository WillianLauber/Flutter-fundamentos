import 'package:bytebank/components/editor.dart';
import 'package:bytebank/models/contact.dart';
import 'package:bytebank/models/transaction.dart';
import 'package:flutter/material.dart';

const _tituloAppBar = 'Criando transferência';
const _nConta = 'Número da conta';
const _valor = 'valor';
const _tconfirmar = 'confirmar';

class FormularioTransferencia extends StatefulWidget {

  final Contact contact;
  FormularioTransferencia(this.contact);

  @override
  State<StatefulWidget> createState() {
    return TransferenciaState();
  }
}

class TransferenciaState extends State<FormularioTransferencia> {

  final TextEditingController _controladorCampoNumeroConta =
      TextEditingController();
  final TextEditingController _controladorCampoValor = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(_tituloAppBar)),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Text(
                widget.contact.name,
                style: TextStyle(
                  fontSize: 24.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  widget.contact.accountNumber.toString(),
                  style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: TextField(
                  controller: _controladorCampoValor,
                  style: TextStyle(fontSize: 24.0),
                  decoration: InputDecoration(labelText: 'Value'),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                ),
              ),
              Editor(
                  controlador: _controladorCampoValor,
                  rotulo: _valor,
                  dica: '100.93',
                  icone: Icons.monetization_on),
              RaisedButton(
                  child: Text(_tconfirmar),
                  onPressed: () => _criarTransferencia(context))
            ],
          ),
        ));
  }

  void _criarTransferencia(BuildContext context) {
    final int numeroConta = int.tryParse(_controladorCampoNumeroConta.text);
    final double valor = double.tryParse(_controladorCampoValor.text);
    if (valor != null && numeroConta != null) {
      final transferenciaCriada = Transaction(valor, widget.contact);
      Navigator.pop(context, transferenciaCriada);
    }
  }
}
