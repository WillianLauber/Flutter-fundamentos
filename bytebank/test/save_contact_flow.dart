import 'package:bytebank/main.dart';
import 'package:bytebank/screens/contacts/contact_form.dart';
import 'package:bytebank/screens/contacts/contacts_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'matchers.dart';
import 'mocks.dart';

void main() {
  testWidgets("Should save a contact", (tester) async {
    final mockContactDao = MockContactDao();
    await tester.pumpWidget(BytebankApp(
      contactDao: mockContactDao,
    ));

    final dashboard = find.byType(DashBoard);
    expect(dashboard, findsOneWidget);

    final transferFeatureItem = find.byWidgetPredicate(
        (widget) => featureMatcher(widget, 'Transfer', Icons.monetization_on));

    expect(transferFeatureItem, findsOneWidget);
    //
    await tester.tap(transferFeatureItem);
    await tester.pumpAndSettle();
    await tester.pump();
    final contactsList = find.byType(ContactsList);
    expect(contactsList, findsOneWidget);

    final fabNovoContato = find.widgetWithIcon(FloatingActionButton, Icons.add);
    expect(fabNovoContato, findsOneWidget);
    await tester.tap(fabNovoContato);
    await tester.pumpAndSettle();
    final contactForm = find.byType(ContactForm);
    expect(contactForm, findsOneWidget);
    final nameTextField = find.byWidgetPredicate((widget) {
      if (widget is TextField) {
        return widget.decoration.labelText == "Full name";
      }
      return false;
    });
    expect(nameTextField, findsOneWidget);
    await tester.enterText(nameTextField, 'alex');
    final accountNumberTextField = find.byWidgetPredicate((widget) {
      if (widget is TextField) {
        return widget.decoration.labelText == 'Account number';
      }
      return false;
    });
    expect(nameTextField, findsOneWidget);
    await tester.enterText(nameTextField, '2000');

    final createButton = find.widgetWithText(RaisedButton, "Create");
    tester.tap(createButton);
    tester.pumpAndSettle();
    final contactsListback = find.byType(ContactsList);
    expect(contactsListback, findsOneWidget);
  });
}
