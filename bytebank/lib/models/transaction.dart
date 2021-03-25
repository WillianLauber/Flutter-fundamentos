
import 'package:bytebank/models/contact.dart';

class Transaction {
  final double value;
  final Contact contact;
  Transaction(this.value, this.contact);

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