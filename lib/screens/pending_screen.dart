import 'package:flutter/material.dart';
import 'package:library_management_system/providers/book_provider.dart';
import 'package:library_management_system/utils/constants.dart';

class PendingScreen extends StatefulWidget {
  const PendingScreen({super.key});

  @override
  State<PendingScreen> createState() => _PendingScreenState();
}

class _PendingScreenState extends State<PendingScreen> {
  final bookProvider = BookProvider();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pending Approvals"),
      ),
      body: StreamBuilder(
        stream: bookProvider.pendingRequests(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Constants.primaryColor,
              ),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text("Something Went Wrong"),
            );
          } else if (snapshot.data!.isEmpty) {
            return const Center(
              child: Text("No Pending Request Found"),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(snapshot.data![index]["bookName"]),
                  subtitle: Text(snapshot.data![index]['studentEmail']),
                  trailing: Wrap(
                    children: [
                      IconButton(
                          onPressed: () async {
                            _removeRequest(
                              snapshot.data![index]["id"],
                              snapshot.data![index]["bookId"],
                              snapshot.data![index]["studentEmail"],
                            );
                          },
                          icon: const Icon(
                            Icons.close,
                            color: Colors.red,
                            size: 30,
                          )),
                      IconButton(
                          onPressed: () async {
                            _approveRequest(
                              snapshot.data![index]["id"],
                              "approved",
                            );
                          },
                          icon: const Icon(
                            Icons.task_alt,
                            color: Colors.green,
                            size: 30,
                          ))
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  Future<void> _removeRequest(
      String id, String bookId, String studentEmail) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          "Are You Sure You Want To Reject?",
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        actions: [
          TextButton(
              onPressed: () {
                bookProvider.deleteAllocatedBook(
                    id, bookId, studentEmail, "Request Removed", context);
              },
              child: const Text("Yes")),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("No"),
          )
        ],
      ),
    );
  }

  Future<void> _approveRequest(String id, String status) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          "Are You Sure You Want To Accept?",
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        actions: [
          TextButton(
              onPressed: () {
                bookProvider.approveRequest(id, status, context);
              },
              child: const Text("Yes")),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("No"),
          )
        ],
      ),
    );
  }
}
