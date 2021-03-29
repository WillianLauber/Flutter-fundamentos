import 'package:bytebank/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'matchers.dart';

void main(){
  testWidgets("Should display the main image when the dashboard is opened", (WidgetTester tester) async{
   await tester.pumpWidget(MaterialApp(home: DashBoard()));
   final mainImage = find.byType(Image);
   expect(mainImage, findsOneWidget);
  });
  testWidgets("Should display the transfer feature when the Dashboard is opened", (tester) async{
    await tester.pumpWidget(MaterialApp(home: DashBoard()));
    // final iconTransferFeatureItem = find.widgetWithIcon(FeatureItem, Icons.monetization_on);
    // expect(iconTransferFeatureItem, findsOneWidget);
    // final  nameTranferFeatureItem = find.widgetWithText(FeatureItem, "Transfer");
    // expect(nameTranferFeatureItem, findsOneWidget);
    final transferFeatureItem = find.byWidgetPredicate((widget) {
      return featureMatcher(widget, "Transfer", Icons.monetization_on);
    });

  });

  testWidgets("Should display the transfer feature when the Dashboard is opened", (tester) async{
    await tester.pumpWidget(MaterialApp(home: DashBoard()));
    // final iconTransactionFeedFeatureItem = find.widgetWithIcon(FeatureItem, Icons.description);
    // expect(iconTransactionFeedFeatureItem, findsOneWidget);
    // final  nameTransactionFeedFeatureItem = find.widgetWithText(FeatureItem, "Transaction feed");
    // expect(nameTransactionFeedFeatureItem, findsOneWidget);
    final nameTransactionFeedFeatureItem = find.byWidgetPredicate((widget) {
      return featureMatcher(widget, "Transaction feed", Icons.description);
    });

  });
}
