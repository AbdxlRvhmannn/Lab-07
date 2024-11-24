import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(ApiApp());

class ApiApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ApiHome(),
    );
  }
}

class ApiHome extends StatefulWidget {
  @override
  _ApiHomeState createState() => _ApiHomeState();
}

class _ApiHomeState extends State<ApiHome> {
  bool _isLoading = false;
  Map<String, dynamic>? _postData;

  Future<void> _fetchPost() async {
    setState(() {
      _isLoading = true;
    });
    final response =
    await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts/1'));
    if (response.statusCode == 200) {
      setState(() {
        _postData = json.decode(response.body);
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
      throw Exception('Failed to load post');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Fetch API Data')),
      body: Center(
        child: _isLoading
            ? CircularProgressIndicator()
            : _postData == null
            ? ElevatedButton(
          onPressed: _fetchPost,
          child: Text('Fetch Post'),
        )
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Post Title: ${_postData!['title']}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('Post Body: ${_postData!['body']}'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _fetchPost,
              child: Text('Fetch Another Post'),
            ),
          ],
        ),
      ),
    );
  }
}
