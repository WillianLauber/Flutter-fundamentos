import 'package:bytebank/models/contact.dart';
import 'package:bytebank/models/transaction.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
  test("Should return the value when a transaction is created", (){
    final transaction = Transaction("1", 200, Contact(1, "1", 200));
    expect(transaction.value, 200);
  });
  test("Should show error message when create transaction with value less than zero", (){
    expect(() => Transaction("2", 200, Contact(null, null, null)), throwsAssertionError);
  });
}