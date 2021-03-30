import 'package:bytebank/database/dao/contacts.dart';
import 'package:bytebank/models/contact.dart';
import 'package:bytebank/screens/contacts/contacts_list.dart';
import 'package:bytebank/widgets/app_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ContactForm extends StatefulWidget {

  @override
  _ContactFormState createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _accountNumberController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    final dependencies =  AppDependencies.of(context);
    return Scaffold(
      appBar: AppBar(title: Text('New contact')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
                decoration: InputDecoration(
                    labelText: 'Full name',
                ),
                controller: _nameController,
                style: TextStyle(
                  fontSize: 24.0,
                )),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: TextField(
                decoration: InputDecoration(labelText: 'Account number'),
                controller: _accountNumberController,
                style: TextStyle(
                  fontSize: 24.0,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: SizedBox(
                width: double.maxFinite,
                child: ElevatedButton(
                    child: Text('Create'),
                    onPressed: () {
                      final String name = _nameController.text;
                      final int number =
                          int.tryParse(_accountNumberController.text);
                      final contact = new Contact(0, name, number);
                      _save(dependencies.contactDao, contact, context);
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _save(ContactDao contactDao, Contact contact, BuildContext context) async{
   await contactDao.save(contact);
    Navigator.of(context)
        .pop(MaterialPageRoute(
            builder: (context) => ContactsList()));
  }
}
