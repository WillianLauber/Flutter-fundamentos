import 'package:bytebank/database/dao/contacts.dart';
import 'package:bytebank/models/contact.dart';
import 'package:bytebank/screens/contacts/contacts_list.dart';
import 'package:flutter/material.dart';

final TextEditingController _nameController = TextEditingController();
final TextEditingController _accountNumberController = TextEditingController();


class ContactForm extends StatefulWidget {
  final ContactDao contactDao;
  ContactForm({@required this.contactDao});
  @override
  _ContactFormState createState() => _ContactFormState(contactDao: contactDao);
}

class _ContactFormState extends State<ContactForm> {

  final ContactDao contactDao;
  _ContactFormState({@required this.contactDao});
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
                child: RaisedButton(
                    child: Text('Create'),
                    onPressed: () {
                      final String name = _nameController.text;
                      final int number =
                          int.tryParse(_accountNumberController.text);
                      final contact = new Contact(0, name, number);
                      _save(contact, context);
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _save(Contact contact, BuildContext context) async{
   await contactDao.save(contact);
    Navigator.of(context)
        .pop(MaterialPageRoute(
            builder: (context) => ContactsList()));
  }
}
