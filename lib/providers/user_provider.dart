import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider extends ChangeNotifier {
  SharedPreferences? sharedPreferences;
  bool loading = false;
  bool hasError = false;
  bool hasData = false;
  String? customError;
  String? role;
  String? userId;
  String? userEmail;
  Map? data;

  Future<void> getUser() async {
    sharedPreferences = await SharedPreferences.getInstance();
    role = sharedPreferences!.getString('role');
    userId = sharedPreferences!.getString("userId");
    userEmail = sharedPreferences!.getString('email');
  }

  Future<List<Map<String, dynamic>>> getUsers() async {
    // Get the current user's ID

    // Fetch users from the "users" collection in Firestore
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('users').get();

    return querySnapshot.docs
        .where((doc) => doc['email'] != userEmail)
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();
    // Map the documents to a list of user data, applying role-based filtering
    // return querySnapshot.docs
    //     .where((doc) {
    //       if (role == 'student') {
    //         // If the current user is a student, only include admins
    //         return doc['role'] == 'admin';
    //       } else if (role == 'admin') {
    //         // If the current user is an admin, only include students
    //         return doc['role'] == 'student';
    //       }
    //       // Include other roles if needed
    //       return false;
    //     })
    //     .map((doc) => doc.data() as Map<String, dynamic>)
    //     .toList();
  }
}
