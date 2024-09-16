import 'package:flutter/material.dart';
import 'package:library_management_system/providers/book_provider.dart';
import 'package:library_management_system/utils/constants.dart';

class BooksToReturnScreen extends StatefulWidget {
  const BooksToReturnScreen({super.key});

  @override
  State<BooksToReturnScreen> createState() => _BooksToReturnScreenState();
}

class _BooksToReturnScreenState extends State<BooksToReturnScreen> {
  final bookProvider = BookProvider();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Books To Return"),
      ),
      body: FutureBuilder(future: bookProvider.getStudentAllocatedBooks(context),
        builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(color: Constants.primaryColor),
              );
          }else if(snapshot.data!.isEmpty) {
              return const Center(
                child: Text("No Books To Return", style: TextStyle(fontSize: 20),),
              );
            }else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(snapshot.data![index]["bookName"]),
                    subtitle: Text("Return Date: ${snapshot.data![index]["bookReturnDate"]}"),

                  );
                },
              );
            }
        },
      ),
    );
  }
}
