import 'package:flutter/material.dart';

void main() => runApp(EmailApp());

class EmailApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blueGrey, accentColor: Colors.red),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;

  var messages = const [
    'First message',
    'Second message',
    'Second one',
    'You won this game',
    'You won that game',
    'You have to read this!',
    'You won this game',
    'You won another game'
  ];
  MyHomePage({this.title});
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(this.title),
      ),
      body: ListView.separated(
        itemCount: 10,
        separatorBuilder: (context, index) => Divider(),
        itemBuilder: (BuildContext context, int index) {
          var title = messages[index];
          return ListTile(
            title: Text('Title $index'),
            isThreeLine: true,
            leading: CircleAvatar(
              child: Text('Pj'),
            ),
            subtitle: Text('$title'),
          );
        },
      )
    );
  }
}
