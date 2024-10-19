import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<String> getNemotronResponse(String prompt) async {
  final response = await http.post(
    Uri.parse('https://api.nemotron.com/models/nemotron-70b'),
    headers: {
      'Authorization': 'Bearer YOUR_API_KEY',
    },
    body: jsonEncode({
      'prompt': prompt,
    }),
  );
  if (response.statusCode == 200) {
    return jsonDecode(response.body)['content'];
  } else {
    throw Exception('Failed to get response from Nemotron 70B');
  }
}

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Nemotron App'),
        ),
        body: Center(
          child: MyHomePage(),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String response = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TextField(
          onSubmitted: (prompt) async {
            String result = await getNemotronResponse(prompt);
            setState(() {
              response = result;
            });
          },
          decoration: InputDecoration(
            hintText: 'Enter your prompt',
          ),
        ),
        Text(response),
      ],
    );
  }
}
