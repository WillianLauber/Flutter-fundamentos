
import 'package:bytebank/models/contact.dart';

class Transaction {
  final double valor;
  final Contact contact;
  Transaction(this.valor, this.contact);



  @override
  String toString() {
    return 'Transferencia{numeroConta: $contact.accountNumber, valor: $valor}';
  }
}