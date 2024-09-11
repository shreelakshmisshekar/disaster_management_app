// lib/emergency_contacts_page.dart
import 'package:flutter/material.dart';

class EmergencyContactsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> contacts = [
      {'name': 'Fire Department', 'phone': '123-456-7890'},
      {'name': 'Police Department', 'phone': '123-456-7891'},
      {'name': 'Ambulance Service', 'phone': '123-456-7892'},
    ];

    return Scaffold(
      appBar: AppBar(title: Text('Emergency Contacts')),
      body: ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          final contact = contacts[index];
          return ListTile(
            title: Text(contact['name']!),
            subtitle: Text(contact['phone']!),
          );
        },
      ),
    );
  }
}
