import 'package:bytebank/main.dart';
import 'package:bytebank/models/contact.dart';
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
  MockWebClient mockWebClient;

  setUp(() async {
    mockContactDao = MockContactDao();
    mockWebClient = MockWebClient();
  });

  testWidgets("Should transfer to a contact", (tester) async{

    await tester.pumpWidget(BytebankApp(
      contactDao: mockContactDao,
      webClient: mockWebClient,
    ));

    final dashboard = find.byType(DashBoard);
    expect(dashboard, findsOneWidget);

    // when(mockContactDao.findAll()).thenAnswer((invocation) async{
    //   debugPrint('name invocation ${invocation.memberName}');
    //     return [Contact(0, 'Alex', 10020)];
    // }
    // );

    // await clickOnTransferFeatureItem(tester);
    //
    // await tester.pumpAndSettle();
    // //
    // final contactsList = find.byType(ContactsList);
    // expect(contactsList, findsOneWidget);
    //
    // verify(mockContactDao.findAll()).called(1);
    // final contactItem = find.byWidgetPredicate((widget)  {
    //   if(widget is ContactItem){
    //     return widget.contact.name == "Alex" && widget.contact.accountNumber == 1000;
    //   }
    //   return false;
    // });
    // expect(contactItem, findsOneWidget);
    // await tester.tap(contactItem);
    // await tester.pumpAndSettle();
    //
    // final transactionForm = find.byType(TransactionForm);
    // expect(transactionForm, findsOneWidget);
    //
    // final contactName = find.text('Alex');
    // expect(contactName, findsOneWidget);
    //
    // final accountNumber = find.text('1000');
    // expect(accountNumber, findsOneWidget);
    //
    // final textFieldValue = find.byWidgetPredicate((widget) {
    //   return textFieldMatcher(widget, 'Value');
    // });
    // expect(textFieldValue, findsOneWidget);
    // await tester.enterText(textFieldValue, '200');
    //
    // final transferButton = find.widgetWithText(RaisedButton, 'Transfer');
    // expect(transferButton, findsOneWidget);
    // await tester.tap(transferButton);
    // await tester.pumpAndSettle();

    // final transactionAuthDialog = find.byType(TransactionAuthDialog);
  // expect(transactionAuthDialog, findsOneWidget);
  });
}
