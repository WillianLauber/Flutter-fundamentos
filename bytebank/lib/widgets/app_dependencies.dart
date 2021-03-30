import 'package:bytebank/database/dao/contacts.dart';
import 'package:bytebank/http/webClients/transaction_webClient.dart';
import 'package:flutter/cupertino.dart';

class AppDependencies extends InheritedWidget{
  final ContactDao contactDao;

  final TransactionWebClient webClient;

  AppDependencies({
    @required this.contactDao,
    @required this.webClient,
    @required Widget child}): super(child: child);

  static AppDependencies of(BuildContext context){
    return context.dependOnInheritedWidgetOfExactType<AppDependencies>();
  }
  @override
  bool updateShouldNotify(covariant AppDependencies oldWidget) {
    // TODO: implement updateShouldNotify
    return contactDao != oldWidget.contactDao || webClient != oldWidget.webClient;
  }

}