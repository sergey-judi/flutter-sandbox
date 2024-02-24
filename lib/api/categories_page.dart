// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application/service.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {

  late Future<List<CategoryItem>> futureCategories;

  @override
  void initState() {
    super.initState();

    futureCategories = CategoryService().getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("Categories page with buttons"),
            backgroundColor: Theme.of(context).colorScheme.inversePrimary
        ),
        body: RefreshIndicator(
          child: Center(
            child: FutureBuilder(
              future: futureCategories,
              builder: (context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text("Error: ${snapshot.error}");
                }

                return ListView.separated(
                  itemBuilder: (context, index)  {
                    CategoryItem categoryItem = snapshot.data[index];
                    return ListTile(
                      title: Text(categoryItem.name),
                      subtitle: Text("Id#${categoryItem.id}"),
                      trailing: GestureDetector(
                        child: Icon(Icons.delete),
                        onTap: () async {
                          await CategoryService().deleteCategory(categoryItem);
                          refreshState();
                        }
                      )
                    );
                  },
                  separatorBuilder: (context, index) => Divider(color: Colors.black26),
                  itemCount: snapshot.data.length,
                );
              }
            )
          ),
          onRefresh: () => refreshState()
        )
    );
  }

  refreshState() async {
    var updatedCategories = await CategoryService().getCategories();
    setState(() {
      futureCategories = Future.value(updatedCategories);
    });
  }

  returnBack(context) {
    Navigator.pop(context);
  }
}

// TODO: implement creating category
class AddCategoryPage extends StatefulWidget {
  const AddCategoryPage({ Key? key }) : super(key: key);

  @override
  _AddCategoryPage createState() => _AddCategoryPage();
}

class _AddCategoryPage extends State<AddCategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}
