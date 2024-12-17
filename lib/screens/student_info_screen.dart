import 'package:flutter/material.dart';
import 'package:flutter_initicon/flutter_initicon.dart';
class StudentInfoScreen extends StatefulWidget {
  final Map data;
  const StudentInfoScreen({
    super.key,
    required this.data,
  });

  @override
  State<StudentInfoScreen> createState() => _StudentInfoScreenState();
}

class _StudentInfoScreenState extends State<StudentInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body:  Center(
    child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Initicon(text: widget.data["name"], size: 200,),
        const SizedBox(height: 20),
        Text("Name: ${widget.data['name']}", style: const TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
        ),
        const SizedBox(height: 20),
        Text("Email: ${widget.data['email']}",style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),  ),
        const SizedBox(height: 20),
        Text("Phone No: ${widget.data['phoneNumber']}", style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),),
        const SizedBox(height: 20),
        if(widget.data['specificRole'] != "student")
          Text("Title: ${widget.data['specificRole']}", style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),),


        if(widget.data['specificRole'] == "student")
          Text("Department: ${widget.data['department']}", style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),),
        const SizedBox(height: 20),
        if(widget.data['specificRole'] == "student")
          Text("CMS Id: ${widget.data['cmsId']}", style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),),

      ],
    ),
    )
    );
  }
}
