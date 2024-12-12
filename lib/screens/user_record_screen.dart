import 'package:flutter/material.dart';
import 'package:library_management_system/providers/book_provider.dart';
import 'package:library_management_system/screens/single_record_screen.dart';

class UserRecordScreen extends StatefulWidget {
  const UserRecordScreen({super.key});

  @override
  State<UserRecordScreen> createState() => _UserRecordScreenState();
}

class _UserRecordScreenState extends State<UserRecordScreen> {
  final BookProvider bookProvider = BookProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Users Record"),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: bookProvider.GetStudensRecord(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (!snapshot.hasData ||
              snapshot.data == null ||
              snapshot.data!.isEmpty) {
            return const Center(
              child: Text("No Record To Show"),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final record = snapshot.data![index];
                final name = record['name']?.toString() ?? 'Unknown Name';
                final email = record['email']?.toString() ?? 'Unknown Email';
                return ListTile(
                    title: Text(name),
                    subtitle: Text(email),
                    onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SingleRecordScreen(
                              name: name,
                              email: email,
                            ),
                          ),
                        ));
              },
            );
          }
        },
      ),
    );
  }
}
