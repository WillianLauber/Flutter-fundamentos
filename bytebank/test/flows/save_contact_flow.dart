import 'package:bytebank/main.dart';
import 'package:bytebank/models/contact.dart';
import 'package:bytebank/screens/contacts/contact_form.dart';
import 'package:bytebank/screens/contacts/contacts_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../matchers/matchers.dart';
import '../mocks/mocks.dart';
import 'actions.dart';

void main() {
  testWidgets("Should save a contact", (tester) async {
    final mockContactDao = MockContactDao();
    await tester.pumpWidget(BytebankApp(
      contactDao: mockContactDao,
    ));

    final dashboard = find.byType(DashBoard);
    expect(dashboard, findsOneWidget);

    await clickOnTransferFeatureItem(tester);

    await tester.pumpAndSettle();

    final contactsList = find.byType(ContactsList);
    expect(contactsList, findsOneWidget);

    verify(mockContactDao.findAll()).called(1);

    final fabNovoContato = find.widgetWithIcon(FloatingActionButton, Icons.add);
    expect(fabNovoContato, findsOneWidget);
    await tester.tap(fabNovoContato);


    await tester.pumpAndSettle();

    final contactForm = find.byType(ContactForm);
    expect(contactForm, findsOneWidget);

    final nameTextField = find.byWidgetPredicate((widget) {
      return textFieldMatcher(widget, 'Full name');
    });
    expect(nameTextField, findsOneWidget);

    await tester.enterText(nameTextField, 'alex');
    final accountNumberTextField = find.byWidgetPredicate((widget) {
      return textFieldMatcher(widget,  'Account number');
    });
    expect(nameTextField, findsOneWidget);

    await tester.enterText(nameTextField, '2000');

    final createButton = find.widgetWithText(RaisedButton, "Create");
    expect(createButton, findsOneWidget);
    tester.tap(createButton);
    tester.pumpAndSettle();

    verify(mockContactDao.save(Contact(0, 'alex', 2000)));
    final contactsListback = find.byType(ContactsList);
    expect(contactsListback, findsOneWidget);

    verify(mockContactDao.findAll());
  });
}
