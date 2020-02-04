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
  bool  isLoading = true;

  //Load messages from a file in async mode.
  Future loadMessageList() async {
    List<Message> _messages = await Message.browse();
    setState(() {
      messages = _messages;
      isLoading = false;
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
      body:  isLoading
      ? Center(child: CircularProgressIndicator())
      : ListView.separated(
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
