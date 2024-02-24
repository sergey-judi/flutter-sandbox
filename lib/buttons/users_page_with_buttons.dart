// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application/service.dart';

class UsersPageWithButtons extends StatelessWidget {
  const UsersPageWithButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("Users page with buttons"),
            backgroundColor: Theme.of(context).colorScheme.inversePrimary
        ),
        body: Center(
          child: ListView(
            shrinkWrap: true,
            children: [
              ElevatedButton(
                onPressed: fetchUsers,
                child: Text("Fetch users"),
              ),
              ElevatedButton(
                onPressed: () => returnBack(context),
                child: Text("Return back"),
              )
            ]
          )
        )
    );
  }

  fetchUsers() async {
    var users = await UserService().getUsers();
    users.forEach((element) {
      print("${element.id} : ${element.fullName}");
    });
  }

  returnBack(context) {
    Navigator.pop(context);
  }

}
