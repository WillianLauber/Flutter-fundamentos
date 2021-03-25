import 'package:bytebank/http/webClients/transaction_webClient.dart';
import 'package:bytebank/models/contact.dart';
import 'package:bytebank/models/transaction.dart';
import 'package:flutter/material.dart';

const _tituloAppBar = 'Criando transferência';
const _tconfirmar = 'confirmar';

class TransactionForm extends StatefulWidget {
  final Contact contact;

  TransactionForm(this.contact);

  @override
  State<StatefulWidget> createState() {
    return TransactionState();
  }
}

class TransactionState extends State<TransactionForm> {
  final TransactionWebClient _webClient = TransactionWebClient();
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
              // Editor(
              //     controlador: _controladorCampoValor,
              //     rotulo: _valor,
              //     dica: '100.93',
              //     icone: Icons.monetization_on),
              Padding(
              padding: const EdgeInsets.only(top: 16.0),
    child: SizedBox(
    width: double.maxFinite,
    child: RaisedButton(
    child: Text('Transfer'), onPressed: () {
      final double value = double.tryParse(_controladorCampoValor.text);
      final transactionCreated = Transaction(value, widget.contact);
      _webClient.save(transactionCreated).then((transaction) {
        if (transaction != null) {
          Navigator.pop(context);
        }
      });
    })),

              )
            ],
          ),
        ));
  }

  void _criarTransferencia(BuildContext context) {
    final double valor = double.tryParse(_controladorCampoValor.text);

    debugPrint('transação, valor: ' + valor.toString());
    if (valor != null) {
      final transferenciaCriada = Transaction(valor, widget.contact);
      _webClient.save(transferenciaCriada).then((transactionReceived) {
        if (transactionReceived != null) Navigator.pop(context);
      });
    }
  }
}
