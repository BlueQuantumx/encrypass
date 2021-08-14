import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:crypto/crypto.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Encrypass',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: MyHomePage(title: 'Encrypass'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _controller = TextEditingController();
  String result = "Result";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _controller,
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
              onSubmitted: (String input) {
                var encoded = sha256
                        .convert(utf8.encode(input))
                        .toString()
                        .substring(0, 12)
                        .replaceFirstMapped(RegExp(r"[a-z]"),
                            (match) => match.group(0)!.toUpperCase()) +
                    '@';
                Clipboard.setData(ClipboardData(text: encoded));
                setState(() {
                  result = encoded;
                });
              },
            ),
            Text(result),
            TextButton(
              onPressed: () => Clipboard.setData(ClipboardData(text: result)),
              child: Text("Copy"),
            ),
          ],
        ),
      ),
    );
  }
}
