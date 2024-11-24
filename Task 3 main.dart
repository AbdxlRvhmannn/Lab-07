import 'package:flutter/material.dart';

void main() => runApp(DatabaseApp());

class DatabaseApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DatabaseHome(),
    );
  }
}

class DatabaseHome extends StatefulWidget {
  @override
  _DatabaseHomeState createState() => _DatabaseHomeState();
}

class _DatabaseHomeState extends State<DatabaseHome> {
  bool _isLoading = false;
  List<String> _data = [];

  Future<void> _fetchDatabaseData() async {
    setState(() {
      _isLoading = true;
    });
    await Future.delayed(Duration(seconds: 2)); // Simulate database delay
    setState(() {
      _data = ['Item 1', 'Item 2', 'Item 3', 'Item 4'];
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Database Query')),
      body: Center(
        child: _isLoading
            ? CircularProgressIndicator()
            : _data.isEmpty
            ? ElevatedButton(
          onPressed: _fetchDatabaseData,
          child: Text('Fetch Data'),
        )
            : ListView.builder(
          itemCount: _data.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(_data[index]),
            );
          },
        ),
      ),
    );
  }
}
