import 'package:flutter/material.dart';
import 'information_validation_page.dart';
import 'resource_donation_page.dart';
import 'emergency_contacts_page.dart';
import 'chatbot_page.dart';
import 'group_chat_page.dart';  // Import the group chat page
// ignore: unused_import
import 'data_store.dart';  // Import global data store

class UserInterface extends StatelessWidget {
  final String username; // Add a parameter to accept the username

  UserInterface({required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User/Donor Interface'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(context, '/firstPage', (route) => false);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              // Clear any necessary global data here if needed
              Navigator.pushNamedAndRemoveUntil(context, '/firstPage', (route) => false);
            },
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text('Donate Resources'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return ResourceDonationPage(onResourcesUpdated: (Map<String, int> resources) {
                    // Handle resource update here if needed
                  });
                }),
              );
            },
          ),
          ListTile(
            title: Text('Emergency Contacts'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EmergencyContactsPage()),
              );
            },
          ),
          ListTile(
            title: Text('Chatbot'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ChatbotPage()),
              );
            },
          ),
          ListTile(
            title: Text('Validated Information'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => InformationValidationPage()),
              );
            },
          ),
          ListTile(
            title: Text('Group Chat'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => GroupChatPage(username: username)), // Pass the username here
              );
            },
          ),
        ],
      ),
    );
  }
}