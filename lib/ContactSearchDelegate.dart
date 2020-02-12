import 'package:flutter/material.dart';

import 'model/Contact.dart';

class ContactSearchDelegate extends SearchDelegate {
  final manager;

  ContactSearchDelegate({this.manager});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear), 
        onPressed: () {}
      )
    ];  
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.length < 3) {
      return Center(
        child: Text("Type at least 3 letters to search!")
      );
    }
    return StreamBuilder<List<Contact>>(
            stream: manager.contactListView,
            builder: (BuildContext context, AsyncSnapshot<List<Contact>> snapshot) {
              switch(snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                case ConnectionState.active:
                  return Center(child: CircularProgressIndicator());
                case ConnectionState.done:
                  List<Contact> contacts = snapshot.data;
                  return ListView.separated(
                    itemCount: contacts?.length ?? 0,
                    itemBuilder: (BuildContext context, int index) {
                      Contact _contact = contacts[index];
                      return ListTile(
                        title: Text(_contact.name),
                        subtitle: Text(_contact.email),
                        leading: CircleAvatar()
                      );
                    },
                    separatorBuilder: (context, index) => Divider(),
                  );
              }
            }
          );
}

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }


}