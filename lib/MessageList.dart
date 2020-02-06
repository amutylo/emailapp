
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'ComposeButton.dart';
import 'Message.dart';
import 'MessageDetail.dart';

class MessageList extends StatefulWidget {
  final String title;

  const MessageList({Key key, this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MessageListState();
}

class _MessageListState extends State<MessageList> {
  Future<List<Message>> future;
  List<Message> messages;

  void initState() {
    super.initState();
    fetch();
  }

  void fetch() async {
    future = Message.browse();
    messages = await future;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.refresh), onPressed: () async {
            var _messages = await Message.browse();
            setState(() {
              messages = _messages;
            });
          },)
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text("amutylo@gmail.com"),
              accountEmail: Text("AndriiM"),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage("https://avatars1.githubusercontent.com/u/1333401?s=460&v=4")
              ),
              otherAccountsPictures: <Widget>[
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("Adding new account ..."));
                      }
                    );
                  },
                  child: CircleAvatar(
                    child: Icon(Icons.add)
                  ),
                )
              ]
            ),
            Padding(
              padding: EdgeInsets.only(top:20),
              ),
            ListTile(
              leading: Icon(FontAwesomeIcons.inbox),
              title: Text('Inbox'),
              trailing: Chip(
                label: Text("11", style: TextStyle(fontWeight: FontWeight.bold)),
                backgroundColor: Colors.blue[100]
              ),
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.edit),
              title: Text('Draft')
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.archive),
              title: Text('Archive')
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.paperPlane),
              title: Text('Sent')
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.trashAlt),
              title: Text('Trash')
            ),
            Divider(),
            Expanded(
              child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: ListTile(
                  leading: Icon(FontAwesomeIcons.cog),
                  title: Text("Settings")
                ),
              ),
            ),
          ],
        ),
      ),
      body: FutureBuilder(
        future: future,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch(snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
            case ConnectionState.active:
              return Center(child: CircularProgressIndicator());
            case ConnectionState.done:
            if (snapshot.hasError) return Text("There was an error: ${snapshot.error}");
            var messages = snapshot.data;
            return ListView.separated(
              itemCount: messages.length,
              separatorBuilder: (context, index) => Divider(),
              itemBuilder: (BuildContext context, int index) {
                Message message = messages[index];
                return ListTile(
                  title: Text(message.subject),
                  isThreeLine: true,
                  leading: CircleAvatar(
                    child: Text('Pa'),
                  ),
                  subtitle: Text(
                    message.body,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  onTap: () {
                    Navigator.push(context,
                      MaterialPageRoute(
                        builder: (BuildContext context) =>
                        MessageDetail(message.subject, message.body)
                    ));
                  }
                );
              },
            );
          }
        },
      ),
      floatingActionButton: ComposeButton(messages),
    );
  }
}
