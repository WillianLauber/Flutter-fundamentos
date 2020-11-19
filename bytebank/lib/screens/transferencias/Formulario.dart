import 'package:bytebank/components/Editor.dart';
import 'package:bytebank/models/Transferencia.dart';
import 'package:flutter/material.dart';

const _tituloAppBar = 'Criando transferência';
const _nConta = 'Número da conta';
const _valor = 'valor';
const _tconfirmar = 'confirmar';

class FormularioTransferencia extends StatefulWidget {
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
              Editor(
                  controlador: _controladorCampoNumeroConta,
                  rotulo: _nConta,
                  dica: '0000'),
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
      final transferenciaCriada = Transferencia(numeroConta, valor);
      Navigator.pop(context, transferenciaCriada);
    }
  }
}
