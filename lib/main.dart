// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: CategoriesPage(),
    );
  }
}

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<StatefulWidget> createState() => _CategoriesPage();
}

class _CategoriesPage extends State<CategoriesPage> {
  late Future<List<CategoryItem>> futureCategories;

  @override
  void initState() {
    super.initState();
    futureCategories = CategoryService().getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Categories")),
      body: Center(
        child: FutureBuilder<List<CategoryItem>>(
          future: futureCategories,
          builder: (context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text("Error: ${snapshot.error}");
            }

            Text('I have data! ${snapshot.data}');

            return ListView.separated(
              itemBuilder:(context, index) {
                CategoryItem category = snapshot.data[index];

                return ListTile(
                  title: Text(category.name),
                  // subtitle: Text(category.id.toString()),
                  trailing: Icon(Icons.chevron_right_outlined)
                );
              },
              separatorBuilder:(context, index) {
                return Divider(color: Colors.black26);
              },
              itemCount: snapshot.data.length,
            );
          },
        )
      )
    );
  }

}

class Categories extends StatelessWidget {

  Categories({super.key}) {
    // loadCategories();
  }

  loadCategories() async {
    final results = await CategoryService().getCategories();

    print(results.length);
    
    results.forEach((element) {
      print("${element.id} ${element.name}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Categories list")),
        body: Icon(Icons.phone)
      )
    );
  }

}

class CategoryItem {
  final int id;
  final String name;

  const CategoryItem({required this.id, required this.name});

  factory CategoryItem.fromJson(Map<dynamic, dynamic> json) {
    return CategoryItem(id: json['id'], name: json['name']);
  }
}

class CategoryService {
  static const String categoriesUrl = "http://192.168.1.106:8181/categories";

  Future<List<CategoryItem>> getCategories() async {
    final response = await http.get(Uri.parse(categoriesUrl));

    if (response.statusCode != 200) {
      throw Exception('Call for categories failed!');
    }

    final jsonResponse = jsonDecode(response.body);

    List<CategoryItem> categories = [];

    for (var i = 0; i < jsonResponse.length; i++) {
      final jsonEntry = jsonResponse[i];
      categories.add(CategoryItem.fromJson(jsonEntry));
    }

    return categories;
  }
}
