
import 'package:flutter/material.dart';
import 'package:flutter_initicon/flutter_initicon.dart';
import 'package:library_management_system/providers/auth_provider.dart';
import 'package:library_management_system/utils/constants.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}
Future<void> getDetails() async {
  // FirebaseAuth.instance.currentUser.phoneNumber;
}
class _ProfileScreenState extends State<ProfileScreen> {
  final authProvider = AuthProvider();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: FutureBuilder(
        future: authProvider.getUserInfo(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: Constants.primaryColor),
            );
          }else if(snapshot.hasError){
            return const Center(
              child: Text("Something Went Wrong"),
            );
          }else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Initicon(text: snapshot.data!["name"], size: 200,),
                  const SizedBox(height: 20),
                  Text("Name: ${snapshot.data!['name']}", style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                  ),
                  const SizedBox(height: 20),
                  Text("Email: ${snapshot.data!['email']}",style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),  ),
                  const SizedBox(height: 20),
                  Text("Phone No: ${snapshot.data!['phoneNumber']}", style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),),
                ],
              ),
            );
          }
        },
      ),
    );
  }

}
