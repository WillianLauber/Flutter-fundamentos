
import 'package:bytebank/models/contact.dart';

class Transaction {
  double value;
  final Contact contact;
  Transaction(this.value, this.contact): assert(value > 0);

  Map<String, dynamic> toJson() =>{
    'value': value,
    'contact': contact.toJson(),
  };

  Transaction.fromJson(Map<String, dynamic> json) :
        value  = json['value'],
        contact = Contact.fromJson(json['contact']);


  @override
  String toString() {
    return 'Transferencia{numeroConta: $contact.accountNumber, valor: $value';

}}