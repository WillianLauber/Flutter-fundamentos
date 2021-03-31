import 'package:bytebank/components/response_dialog.dart';
import 'package:bytebank/components/transaction_auth_dialog.dart';
import 'package:bytebank/main.dart';
import 'package:bytebank/models/contact.dart';
import 'package:bytebank/models/transaction.dart';
import 'package:bytebank/screens/contacts/contacts_list.dart';
import 'package:bytebank/screens/transferencias/transactions_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../matchers/matchers.dart';
import '../mocks/mocks.dart';
import 'actions.dart';

main(){
  MockContactDao mockContactDao;
  MockWebClient mockTransactionWebClient;

  setUp(() async {
    mockContactDao = MockContactDao();
    mockTransactionWebClient = MockWebClient();
  });

  testWidgets('Should transfer to a contact', (tester) async {
  await tester.pumpWidget(BytebankApp(
    webClient: mockTransactionWebClient,
    contactDao: mockContactDao,
  ));

  final dashboard = find.byType(DashBoard);
  expect(dashboard, findsOneWidget);

  final alex = Contact(0, 'Alex', 1000);
  when(mockContactDao.findAll()).thenAnswer((invocation) async => [alex]);

  await clickOnTransferFeatureItem(tester);
  await tester.pumpAndSettle();

  final contactsList = find.byType(ContactsList);
  expect(contactsList, findsOneWidget);

  verify(mockContactDao.findAll()).called(1);

  final contactItem = find.byWidgetPredicate((widget) {
    if (widget is ContactItem) {
      return widget.contact.name == 'Alex' &&
          widget.contact.accountNumber == 1000;
    }
    return false;
  });
  expect(contactItem, findsOneWidget);
  await tester.tap(contactItem);
  await tester.pumpAndSettle();

  final transactionForm = find.byType(TransactionForm);
  expect(transactionForm, findsOneWidget);

  final contactName = find.text('Alex');
  expect(contactName, findsOneWidget);
  final contactAccountNumber = find.text('1000');
  expect(contactAccountNumber, findsOneWidget);

  final textFieldValue = find.byWidgetPredicate((widget){
    return textFieldMatcher(widget, 'Value');
  });
  expect(textFieldValue, findsOneWidget);
  await tester.enterText(textFieldValue, '200');

  final transferButton = find.widgetWithText(RaisedButton, 'Transfer');
  expect(transferButton, findsOneWidget);
  await tester.tap(transferButton);
  await tester.pumpAndSettle();

  final transactionAuthDialog = find.byType(TransactionAuthDialog);
  expect(transactionAuthDialog, findsOneWidget);

  final textFieldPassword = find.byKey(transactionAuthDialogTextFieldPassword);
  expect(textFieldPassword, findsOneWidget);
  await tester.enterText(textFieldPassword, '1000');

  final cancelButton = find.widgetWithText(TextButton, 'Cancel');
  expect(cancelButton, findsOneWidget);
  final confirmButton = find.widgetWithText(TextButton, 'Confirm');
  expect(confirmButton, findsOneWidget);

  when(mockTransactionWebClient.save(Transaction(null, 200, alex), '1000'))
      .thenAnswer((_) async => Transaction(null, 200, alex));

  await tester.tap(confirmButton);
  await tester.pumpAndSettle();

  final successDialog = find.byType(SuccessDialog);
  expect(successDialog, findsOneWidget);

  final okButton = find.widgetWithText(FlatButton, 'Ok');
  expect(okButton, findsOneWidget);
  await tester.tap(okButton);
  await tester.pumpAndSettle();

  final contactsListBack = find.byType(ContactsList);
  expect(contactsListBack, findsOneWidget);
});
}
