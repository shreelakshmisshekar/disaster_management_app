import 'package:flutter/material.dart';
import 'resource_allocation_page.dart';
import 'group_chat_page.dart';
import 'information_validation_page.dart'; // Import the InformationValidationPage

class VolunteerInterface extends StatefulWidget {
  final String username; // Add username parameter

  VolunteerInterface({required this.username});

  @override
  _VolunteerInterfaceState createState() => _VolunteerInterfaceState();
}

class _VolunteerInterfaceState extends State<VolunteerInterface> {
  final List<String> _availableResources = []; // This should be populated with actual resources

  void _allocateResources() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResourceAllocationPage(
          availableResources: _availableResources, // Pass the actual list of available resources
        ),
      ),
    );
  }

  void _validateInformation() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => InformationValidationPage(), // Navigate to the InformationValidationPage
      ),
    );
  }

  void _chatsWithUsers() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GroupChatPage(username: widget.username), // Pass the username here
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Volunteer Interface'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(context, '/firstPage', (route) => false); // Navigate to the first page
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: _allocateResources,
              child: Text('Allocate Resources', style: TextStyle(fontSize: 18)),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _validateInformation,
              child: Text('Validate Information', style: TextStyle(fontSize: 18)),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _chatsWithUsers,
              child: Text('Chats with Users', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}
