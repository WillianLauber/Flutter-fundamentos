import 'package:bytebank/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
  testWidgets("Should display the main image when the dashboard is opened", (WidgetTester tester) async{
   await tester.pumpWidget(MaterialApp(home: DashBoard()));
   final mainImage = find.byType(Image);
   expect(mainImage, findsOneWidget);
  });
  testWidgets("Should display the first feature when the Dashboard is opened", (tester) async{
    await tester.pumpWidget(MaterialApp(home: DashBoard()));
    final firstFeature = find.byType(FeatureItem);
    expect(firstFeature, findsWidgets);
  });
}