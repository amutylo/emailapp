import 'package:emailapp/AppDrawer.dart';
import 'package:flutter/material.dart';

import 'MessageList.dart';

class InboxScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
          child: Scaffold(
            appBar: AppBar(
              title: Text("Inbox"),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.refresh),
                  onPressed: () {},)
              ],
              bottom: TabBar(
                tabs: <Widget>[
                  Tab(text: "Important"),
                  Tab(text: "Other"),
                ]
              ),
            ),
            drawer: AppDrawer(),
            body: TabBarView(
              children: <Widget>[
                MessageList(status: 'important'),
                MessageList(status: 'other'),
              ],
            ),
          ),
          length: 2,
    );
  }
}
