
import 'package:bytebank/models/contact.dart';

class Transaction {
  String id;
  double value;
  final Contact contact;
  Transaction(this.id, this.value, this.contact): assert(value > 0);

  Map<String, dynamic> toJson() =>{
    'id': id,
    'value': value,
    'contact': contact.toJson(),
  };

  Transaction.fromJson(Map<String, dynamic> json) :
        id = json['id'],
        value  = json['value'],
        contact = Contact.fromJson(json['contact']);


  @override
  String toString() {
    return 'Transferencia{numeroConta: $contact.accountNumber, valor: $value';

}

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Transaction &&
          runtimeType == other.runtimeType &&
          value == other.value &&
          contact == other.contact;

  @override
  int get hashCode => value.hashCode ^ contact.hashCode;
}