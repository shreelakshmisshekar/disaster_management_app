import 'package:flutter/material.dart';

class ResourceDonationPage extends StatefulWidget {
  final Function(Map<String, int>) onResourcesUpdated; // Callback to pass updated resources

  ResourceDonationPage({required this.onResourcesUpdated});

  @override
  _ResourceDonationPageState createState() => _ResourceDonationPageState();
}

class _ResourceDonationPageState extends State<ResourceDonationPage> {
  final Map<String, int> _resources = {
    'Food': 10,
    'Clothing': 5,
    'Medical Supplies': 20,
  }; // Default resources with quantities

  final _controller = TextEditingController();
  String _feedbackMessage = '';

  void _addResource(String resourceName) {
    if (resourceName.isNotEmpty) {
      setState(() {
        _resources[resourceName] = (_resources[resourceName] ?? 0) + 1;
        _feedbackMessage = 'You have added ${_resources[resourceName]} of $resourceName';
      });
      widget.onResourcesUpdated(_resources); // Update the resources for allocation
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Donate Resources')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _controller,
              decoration: InputDecoration(labelText: 'Add Resource'),
              onSubmitted: (value) {
                _addResource(value);
                _controller.clear();
              },
            ),
            ElevatedButton(
              onPressed: () {
                _addResource(_controller.text);
                _controller.clear();
              },
              child: Text('Add'),
            ),
            SizedBox(height: 20),
            Text(
              _feedbackMessage,
              style: TextStyle(color: Colors.green, fontSize: 16),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _resources.length,
                itemBuilder: (context, index) {
                  String resource = _resources.keys.elementAt(index);
                  return ListTile(
                    title: Text('$resource: ${_resources[resource]}'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
