import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

// Singleton to manage global chat messages
class GlobalChat {
  static final GlobalChat _instance = GlobalChat._internal();
  final List<String> _messages = [];

  factory GlobalChat() {
    return _instance;
  }

  GlobalChat._internal();

  List<String> get messages => _messages;

  void addMessage(String message) {
    _messages.add(message);
  }
}

// GroupChatPage to display messages with usernames
class GroupChatPage extends StatefulWidget {
  final String username;

  GroupChatPage({required this.username});

  @override
  _GroupChatPageState createState() => _GroupChatPageState();
}

class _GroupChatPageState extends State<GroupChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final GlobalChat _globalChat = GlobalChat();

  @override
  void initState() {
    super.initState();
    // Add a listener to the messages list
    // This is to update the UI whenever the message list is updated
  }

  Future<void> _sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      setState(() {
        String message = _messageController.text;
        _globalChat.addMessage('${widget.username}: $message');
        _messageController.clear();
      });
    }
  }

  Future<void> _sendLocation() async {
    // Check for location permissions
    final status = await Geolocator.requestPermission();
    if (status == LocationPermission.whileInUse || status == LocationPermission.always) {
      try {
        Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
        String message = '${widget.username} sent their location: Latitude: ${position.latitude}, Longitude: ${position.longitude}';
        setState(() {
          _globalChat.addMessage(message);
        });
      } catch (e) {
        print('Error fetching location: $e');
      }
    } else {
      print('Location permission denied');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Group Chat'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: _globalChat.messages.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_globalChat.messages[index]),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Enter your message',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
                IconButton(
                  icon: Icon(Icons.location_on),
                  onPressed: _sendLocation,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
