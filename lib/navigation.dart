// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application/api/categories_page.dart';
import 'package:flutter_application/buttons/categories_page_with_buttons.dart';
import 'package:flutter_application/buttons/users_page_with_buttons.dart';

class NavigationPage extends StatelessWidget {
  const NavigationPage({ super.key });

  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(
          title: Text("Main navigation"),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary
        ),
        body: Center(
          child: ListView(
            shrinkWrap: true,
            children: [
              ElevatedButton(
                onPressed: () => navigateToCategories(context),
                child: Text("To categories"),
              ),
              ElevatedButton(
                onPressed: () => navigateToUsers(context),
                child: Text("To users"),
              ),
            ],
          )
        )
      );
  }

  navigateToCategories(context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => CategoriesPage()));
  }

  navigateToUsers(context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => UsersPageWithButtons()));
  }

}
