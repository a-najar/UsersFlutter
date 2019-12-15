import 'package:flutter/material.dart';

void main() => runApp(UsersApp());

class UsersApp extends StatefulWidget {
  @override
  _UsersAppState createState() => _UsersAppState();
}

class _UsersAppState extends State<UsersApp> {
  List<String> users = [
    "Ahmad",
    "Ibrahim",
    "Najar",
  ];

  bool showAddUser = false;

  void showUserForm() {
    setState(() {
      showAddUser = !showAddUser;
    });
  }

  void addUserFunction(String userName) {
    setState(() {
      users.add(userName);
      showAddUser = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Users"),
          actions: <Widget>[
            IconButton(
              icon: Icon(showAddUser ? Icons.close : Icons.add),
              onPressed: showUserForm,
            )
          ],
        ),
        body: Column(
          children: <Widget>[
            AddUser(
              showForm: showAddUser,
              addUserFunction: addUserFunction,
            ),
            Users(users),
          ],
        ),
      ),
    );
  }
}

class AddUser extends StatelessWidget {
  final Function addUserFunction;
  final bool showForm;

  AddUser({this.addUserFunction, this.showForm});

  final nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return showForm
        ? Container(
            margin: EdgeInsets.all(16),
            child: Column(
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'User Name',
                  ),
                  controller: nameController,
                ),
                Container(
                  width: double.infinity,
                  child: FlatButton(
                    textColor: Theme.of(context).accentColor,
                    onPressed: () {
                      if (nameController.text.isEmpty) return;
                      addUserFunction(nameController.text);
                    },
                    child: Text("Add User Now"),
                  ),
                )
              ],
            ),
          )
        : Container();
  }
}

class Users extends StatelessWidget {
  final List<String> users;

  Users(this.users);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: ListView.builder(
          itemCount: users.length,
          itemBuilder: (ctx, index) {
            return ListTile(
              title: Text(users[index]),
            );
          }),
    );
  }
}
