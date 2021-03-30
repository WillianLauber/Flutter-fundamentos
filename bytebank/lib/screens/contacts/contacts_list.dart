import 'package:bytebank/components/centered_message.dart';
import 'package:bytebank/components/progress.dart';
import 'package:bytebank/database/dao/contacts.dart';
import 'package:bytebank/models/contact.dart';
import 'package:bytebank/screens/contacts/contact_form.dart';
import 'package:bytebank/screens/transferencias/transactions_form.dart';
import 'package:bytebank/widgets/app_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

final List<Contact> contacts = List();


  class ContactsList extends StatefulWidget {
  @override
  _ContactsListState createState() => _ContactsListState();
  }

  class _ContactsListState extends State<ContactsList> {
  @override
  Widget build(BuildContext context) {
  final dependencies = AppDependencies.of(context);
  return Scaffold(
  appBar: AppBar(
  title: Text('Transfer'),
  ),
  body: FutureBuilder<List<Contact>>(
  initialData: List(),
  future: dependencies.contactDao.findAll(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return Progress();
              break;
            case ConnectionState.active:
              break;
            case ConnectionState.done:
             final List<Contact> contacts = snapshot.data;
            return ListView.builder(
            itemBuilder: (context, index) {
              final Contact contact = contacts[index];
              return ContactItem(contact, onClick: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => TransactionForm(contact),),
                );
              },);
              },
              itemCount: contacts.length,
            );
              break;
          }
          return CenteredMessage(
            'No contacts found',
            icon: Icons.warning,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => ContactForm()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class ContactItem extends StatelessWidget {
  final Contact contact;
  final Function onClick;

  ContactItem(this.contact, {@required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () => onClick(),
        title: Text(contact.name),
        subtitle: Text(contact.accountNumber.toString()),
      ),
    );
  }
}
