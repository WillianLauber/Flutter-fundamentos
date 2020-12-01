import 'package:bytebank/components/centered_message.dart';
import 'package:bytebank/components/progress.dart';
import 'package:bytebank/database/dao/contacts.dart';
import 'package:bytebank/models/contact.dart';
import 'package:bytebank/screens/contacts/contact_form.dart';
import 'package:bytebank/screens/transferencias/transactions_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

final List<Contact> contacts = List();

final ContactDao _dao = ContactDao();

class ContactsList extends StatefulWidget {
  @override
  _ContactListState createState() => _ContactListState();
}

class _ContactListState extends State<ContactsList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contacts'),
      ),
      body: FutureBuilder<List<Contact>>(
        initialData: List(),
        future: _dao.findAll(),
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
              if(snapshot.hasData) {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    final Contact contact = contacts[index];
                    return _ContactItem(contact, onClick: (){
                      Navigator.of(context).push(
                          MaterialPageRoute(
                        builder: (context) => FormularioTransferencia(contact),
                        )
                      );}
                    );
                  },
                  itemCount: contacts.length,
                );
              }
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

class _ContactItem extends StatelessWidget {
  final Contact contact;
  final Function onClick;
  _ContactItem(this.contact, {@required this.onClick});

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
