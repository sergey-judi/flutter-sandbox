// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
      throw Exception('HTTP GET:Call for categories failed! $categoriesUrl');
    }

    final jsonResponse = jsonDecode(response.body);

    List<CategoryItem> categories = [];

    for (var i = 0; i < jsonResponse.length; i++) {
      final jsonEntry = jsonResponse[i];
      categories.add(CategoryItem.fromJson(jsonEntry));
    }

    return categories;
  }

  Future<void> createCategory(context, String name) async {
    final response = await http.post(
      Uri.parse(categoriesUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'name': name}),
    );

    if (response.statusCode != 200) {
      throw Exception('HTTP POST:Call for categories failed! $categoriesUrl');
    }

    Navigator.pop(context);
  }

  Future<void> deleteCategory(CategoryItem categoryItem) async {
    final targetUrl = "$categoriesUrl/${categoryItem.id}";
    final response = await http.delete(Uri.parse(targetUrl));

    if (response.statusCode != 200) {
      throw Exception('HTTP DELETE: Call for categories failed! $targetUrl');
    }
  }

}

class UserItem {
  final int id;
  final String fullName;
  final String email;
  final double balance;

  const UserItem({required this.id, required this.fullName, required this.email, required this.balance});

  factory UserItem.fromJson(Map<dynamic, dynamic> json) {
    return UserItem(
      id: json['id'],
      fullName: json['fullName'],
      email: json['email'],
      balance: json['balance']
    );
  }
}

class UserService {

  static const String usersUrl = "http://192.168.1.106:8181/users";

  Future<List<UserItem>> getUsers() async {
    final response = await http.get(Uri.parse(usersUrl));

    if (response.statusCode != 200) {
      throw Exception('Call for Users failed!');
    }

    final jsonResponse = jsonDecode(response.body);

    List<UserItem> users = [];

    for (var i = 0; i < jsonResponse.length; i++) {
      final jsonEntry = jsonResponse[i];
      users.add(UserItem.fromJson(jsonEntry));
    }

    return users;
  }

}
