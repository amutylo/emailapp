import 'dart:convert';

import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import 'Message.dart';

class MessageList extends StatefulWidget {
  final String title;

  const MessageList({Key key, this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MessageListState();
}

class _MessageListState extends State<MessageList> {
   List<Message> messages = const [];

  //Load messages from a file in async mode.
  Future loadMessageList() async {
    // Load content from external json file.
    //String content = await rootBundle.loadString('data/messages.json');
    // Request content from external http resourse.
    http.Response  response = await http.get('http://www.mocky.io/v2/5e39870932000062bfddfb43');
    String content = response.body;
    List collection = json.decode(content);
    List<Message> _messages =
      collection.map((json) => Message.fromJson(json)).toList();

    setState(() {
      messages = _messages;
    });
  }

  void initState() {
    loadMessageList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.separated(
        itemCount: messages.length,
        separatorBuilder: (context, index) => Divider(),
        itemBuilder: (BuildContext context, int index) {
          Message message = messages[index];
          return ListTile(
            title: Text(message.subject),
            isThreeLine: true,
            leading: CircleAvatar(
              child: Text('Pj'),
            ),
            subtitle: Text(
              message.body,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          );
        },
      )
    );
  }
}
