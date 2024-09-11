import 'package:flutter/material.dart';

class ResourceAllocationPage extends StatefulWidget {
  final List<String> availableResources;

  ResourceAllocationPage({this.availableResources = const ['Water', 'Food', 'Medicine']});

  @override
  _ResourceAllocationPageState createState() => _ResourceAllocationPageState();
}

class _ResourceAllocationPageState extends State<ResourceAllocationPage> {
  final _selectedResources = <String>{};
  final Map<String, double> _populationDensity = {
    'Location A': 1000.0,
    'Location B': 1500.0,
    'Location C': 800.0,
  };
  final _newResourceController = TextEditingController();
  String? _selectedLocation;

  void _addNewResource() {
    if (_newResourceController.text.isNotEmpty) {
      setState(() {
        widget.availableResources.add(_newResourceController.text);
        _newResourceController.clear();
      });
    }
  }

  void _allocate() {
    if (_selectedLocation != null && _selectedResources.isNotEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Success'),
          content: Text('You have allocated resources to $_selectedLocation successfully!'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  _selectedResources.clear();
                  _selectedLocation = null;
                });
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please select a location and at least one resource.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Allocate Resources'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Text(
              'Population Density',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            ..._populationDensity.entries.map((entry) {
              return ListTile(
                title: Text('${entry.key}'),
                subtitle: Text('Density: ${entry.value}'),
              );
            }).toList(),
            Divider(),
            DropdownButton<String>(
              value: _selectedLocation,
              hint: Text('Select Location'),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedLocation = newValue;
                });
              },
              items: _populationDensity.keys.map<DropdownMenuItem<String>>((String location) {
                return DropdownMenuItem<String>(
                  value: location,
                  child: Text(location),
                );
              }).toList(),
            ),
            Divider(),
            Text(
              'Available Resources',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: widget.availableResources.length,
                itemBuilder: (context, index) {
                  final resource = widget.availableResources[index];
                  return CheckboxListTile(
                    title: Text(resource),
                    value: _selectedResources.contains(resource),
                    onChanged: (bool? selected) {
                      setState(() {
                        if (selected == true) {
                          _selectedResources.add(resource);
                        } else {
                          _selectedResources.remove(resource);
                        }
                      });
                    },
                  );
                },
              ),
            ),
            TextField(
              controller: _newResourceController,
              decoration: InputDecoration(
                labelText: 'Add Resource',
                suffixIcon: IconButton(
                  icon: Icon(Icons.add),
                  onPressed: _addNewResource,
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _allocate,
              child: Text('Allocate'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ResourceAllocationPage(),
  ));
}
