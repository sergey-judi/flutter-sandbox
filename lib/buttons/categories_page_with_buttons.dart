// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application/service.dart';

class CategoriesPageWithButtons extends StatelessWidget {
  const CategoriesPageWithButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("Categories page with buttons"),
            backgroundColor: Theme.of(context).colorScheme.inversePrimary
        ),
        body: Center(
          child: ListView(
            shrinkWrap: true,
            children: [
              ElevatedButton(
                onPressed: fetchCategories,
                child: Text("Fetch categories"),
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

  fetchCategories() async {
    var categories = await CategoryService().getCategories();
    categories.forEach((element) {
      print("${element.id} : ${element.name}");
    });
  }

  returnBack(context) {
    Navigator.pop(context);
  }

}
