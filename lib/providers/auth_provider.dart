import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:library_management_system/screens/admin_dashboard_screen.dart';
import 'package:library_management_system/screens/login_screen.dart';
import 'package:library_management_system/screens/student_dashboard_screen.dart';
import 'package:library_management_system/utils/app_exception.dart';
import 'package:library_management_system/utils/flushmessage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  bool loading = false;
  final _auth = FirebaseAuth.instance;
  Future<void> signup(String name, String email,String phoneNumber, String password, String role) async {
    try {
      loading = true;
      notifyListeners();
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      User? user = userCredential.user;
      if (user != null) {
        await user.updateDisplayName(name);
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'uid': user.uid,
          'name': name,
          'email': email,
          'phoneNumber': phoneNumber,
          'role': role,
        });
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        throw EmailAlreadyInUseException(e.message);
      } else if (e.code == 'invalid-email') {
        throw InvalidEmailException(e.message);
      } else if (e.code == 'weak-password') {
        throw WeakPasswordException(e.message);
      } else {
        throw UnknownFirebaseException(e.message);
      }
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<void> login(
      String email, String password, BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    try {
      loading = true;
      notifyListeners();
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();
        var data = userSnapshot.data() as Map<String, dynamic>;

        if (data.isNotEmpty) {
          sharedPreferences.setString("role", data['role']);
          sharedPreferences.setString("email", data['email']);
          sharedPreferences.setString("userId", data['uid']);
          if (data['role'] == "admin") {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const AdminDashboardScreen(),
              ),
            );
          } else {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const StudentDashboardScreen(),
              ),
            );
          }
        }
      }
      // print(userCredential);
    } on FirebaseAuthException catch (e) {
      if (e.code == "invalid-credential") {
        throw InvalidCredentialsException("Invalid Email or Password");
      } else {
        throw UnknownFirebaseException(e.message);
      }
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<void> logout(BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove("role");
    await FirebaseAuth.instance.signOut();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
      (route) => false,
    );
  }

  User getCurrentUser() {
    return _auth.currentUser as User;
  }

  Future<Map<String,dynamic>> getUserInfo() async {
   try {
     DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection("users").doc(_auth.currentUser!.uid).get();
     return snapshot.data() as Map<String,dynamic>;
   }catch(error){
     print(error);
     return {"error": error};
   }
  }

  Future<void> forgotPassword(BuildContext context, String email) async {
    try {
      loading = true;
      notifyListeners();
     QuerySnapshot snapshot = await FirebaseFirestore.instance.collection("users").where("email", isEqualTo: email).get();

     if(snapshot.docs.isNotEmpty){
        FirebaseAuth.instance.sendPasswordResetEmail(email: email)
            .then((_){
              FlushMessage.successFlushMessage(context, "Password Reset Link Sent");
        }).catchError((err){
          print(err);
        });
      }else{
        FlushMessage.errorFlushMessage(context, "User Not Found");
      }
    }on FirebaseAuthException catch(error) {
      print("error is ${error.code}");
      if(error.code== "user-not-found") {
        FlushMessage.errorFlushMessage(context, "User Not Found");
      }
    }finally {
      loading = false;
      notifyListeners();
    }
  }
}
