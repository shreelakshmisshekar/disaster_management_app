import 'package:flutter/material.dart';

// Singleton to manage global validated information
class GlobalValidation {
  static final GlobalValidation _instance = GlobalValidation._internal();
  List<String> _validations = [];

  factory GlobalValidation() {
    return _instance;
  }

  GlobalValidation._internal();

  List<String> get validations => _validations;

  void addValidation(String validation) {
    _validations.add(validation);
  }
}

class InformationValidationPage extends StatefulWidget {
  @override
  _InformationValidationPageState createState() => _InformationValidationPageState();
}

class _InformationValidationPageState extends State<InformationValidationPage> {
  final _infoController = TextEditingController();
  final GlobalValidation _globalValidation = GlobalValidation();

  void _validateInfo() {
    if (_infoController.text.isNotEmpty) {
      setState(() {
        String validatedInfo = _infoController.text;
        _globalValidation.addValidation(validatedInfo);
        _infoController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Information Validation'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(16.0),
            child: TextField(
              controller: _infoController,
              decoration: InputDecoration(
                labelText: 'Enter Information',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: _validateInfo,
            child: Text('Validate'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _globalValidation.validations.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Validated Info: ${_globalValidation.validations[index]}'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
