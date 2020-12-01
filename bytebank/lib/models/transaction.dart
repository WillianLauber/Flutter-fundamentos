
import 'package:bytebank/models/contact.dart';

class Transaction {
  final double value;
  final Contact contact;
  Transaction(this.value, this.contact);



  @override
  String toString() {
    return 'Transferencia{numeroConta: $contact.accountNumber, valor: $value';

}}