import 'package:flutter/material.dart';

class GlobalResources {
  static final GlobalResources _instance = GlobalResources._internal();
  List<String> _resources = [];

  factory GlobalResources() {
    return _instance;
  }

  GlobalResources._internal();

  List<String> get resources => _resources;

  void addResource(String resource) {
    _resources.add(resource);
  }

  void allocateResource(int index) {
    if (index >= 0 && index < _resources.length) {
      _resources.removeAt(index);
    }
  }
}

class ResourceManagementPage extends StatefulWidget {
  @override
  _ResourceManagementPageState createState() => _ResourceManagementPageState();
}

class _ResourceManagementPageState extends State<ResourceManagementPage> {
  final _controller = TextEditingController();
  final GlobalResources _globalResources = GlobalResources();

  void _addResource() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        String newResource = _controller.text;
        _globalResources.addResource(newResource);
        _controller.clear();
        print("Resource added: $newResource");  // Debugging step
        print("Current resources: ${_globalResources.resources}");  // Debugging step
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Resource Management'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _controller,
              decoration: InputDecoration(labelText: 'Add Resource'),
            ),
            ElevatedButton(
              onPressed: _addResource,
              child: Text('Add'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _globalResources.resources.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_globalResources.resources[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/allocate');
        },
        child: Icon(Icons.arrow_forward),
      ),
    );
  }
}

class ResourceAllocationPage extends StatefulWidget {
  @override
  _ResourceAllocationPageState createState() => _ResourceAllocationPageState();
}

class _ResourceAllocationPageState extends State<ResourceAllocationPage> {
  final GlobalResources _globalResources = GlobalResources();

  void _allocateResource(int index) {
    setState(() {
      _globalResources.allocateResource(index);
      print("Resource allocated at index $index");  // Debugging step
      print("Remaining resources: ${_globalResources.resources}");  // Debugging step
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Resource Allocation'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemCount: _globalResources.resources.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_globalResources.resources[index]),
                    trailing: ElevatedButton(
                      onPressed: () {
                        _allocateResource(index);
                      },
                      child: Text('Allocate'),
                    ),
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

void main() {
  runApp(MaterialApp(
    home: ResourceManagementPage(),
    routes: {
      '/allocate': (context) => ResourceAllocationPage(),
    },
  ));
}
