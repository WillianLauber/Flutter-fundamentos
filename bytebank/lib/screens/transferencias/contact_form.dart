import 'package:bytebank/database/app_database.dart';
import 'package:bytebank/database/dao/contacts.dart';
import 'package:bytebank/models/contact.dart';
import 'package:flutter/material.dart';


final TextEditingController _nameController = TextEditingController();
final TextEditingController _accountNumberController = TextEditingController();

final ContactDao _dao = ContactDao();

class ContactForm extends StatefulWidget {
  @override
  _ContactFormState createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  @override
  Widget build(BuildContext context) {
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
                style: TextStyle(
                  fontSize: 24.0,
                )
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Account number',

                ),
                style: TextStyle(
                  fontSize: 24.0,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: SizedBox(
                width: double.maxFinite,
                child: RaisedButton(child: Text('Create'),
                    onPressed: () {
                      final String name = _nameController.text;
                      final int number = int.tryParse(
                          _accountNumberController.text);
                      final contact = new Contact(0, name, number);
                      _dao.save(contact).then((id) =>
                          Navigator.pop(context));
                    }),
              ),
            )
          ],
        ),)
      ,
    );
  }
}
