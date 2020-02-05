import 'package:flutter/material.dart';

class MessageCompose extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Compose a new message."),
      ),
      body: Center(
        child: Text("Compose a new message."),
      )
    );
  }
}
