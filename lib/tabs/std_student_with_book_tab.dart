import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:library_management_system/providers/book_provider.dart';
import 'package:library_management_system/utils/constants.dart';

class StdStudentWithBookTab extends StatefulWidget {
  String bookId;
  StdStudentWithBookTab({super.key, required this.bookId});

  @override
  State<StdStudentWithBookTab> createState() => _StdStudentWithBookTabState();
}

class _StdStudentWithBookTabState extends State<StdStudentWithBookTab> {
  @override
  Widget build(BuildContext context) {
    final bookProvider = BookProvider();
    return Scaffold(
      body: FutureBuilder(
        future: bookProvider.getAllocatedBookStudents(widget.bookId, context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Constants.primaryColor,
              ),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text("No Record Found"),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) => ListTile(
                title: Text(snapshot.data![index]['studentEmail']),
                subtitle: Text(
                    "Return Date: ${snapshot.data![index]["bookReturnDate"]}"),
                trailing: Text(
                  snapshot.data![index]["status"],
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
