import 'package:flutter/material.dart';

import 'Message.dart';

class MessageCompose extends StatefulWidget {

  @override
  _MessageComposeState createState() => _MessageComposeState();
}

class _MessageComposeState extends State<MessageCompose> {
  String to = "";
  String subject = "";
  String body = "";

  final key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Compose a new message."),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: key,
          child: Column(
            children: <Widget>[
              ListTile(
                title: TextFormField(
                  validator: (value) => !value.contains('@') ? "`TO` must be valid email" : null,
                  onSaved: (value) => to = value,
                  decoration: InputDecoration(
                    labelText: 'TO',
                    labelStyle: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              ListTile(
                title: TextFormField(
                  validator: (value) {
                    int len = value.length;
                    if (len == 0) {
                      return "`SUBJECT` can not be empty";
                    }
                    else if (len < 4) {
                      return "`SUBJECT` must be longer then 4 chars";
                    }
                    return null;
                  },
                  onSaved: (value) => subject = value,
                  decoration: InputDecoration(
                    labelText: 'SUBJECT',
                    labelStyle: TextStyle(fontWeight: FontWeight.bold),
                  ),
                )
              ),
              Divider(),
              ListTile(
                title: TextFormField(
                onSaved: (value) => body = value,
                decoration: InputDecoration(
                  labelText: 'BODY',
                  labelStyle: TextStyle(fontWeight: FontWeight.bold),
                ),
                maxLines: 5
                )
              ),
              ListTile(
                title: RaisedButton(
                  child: Text('SEND'),
                  onPressed: () {
                    // Validation.
                    if (this.key.currentState.validate()) {
                      this.key.currentState.save();
                      Message message = Message(subject, body);
                      Navigator.pop(context, message);
                    }
                  }
                )
              )
            ]
          ),
        )
      )
    );
  }
}
