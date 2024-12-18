import 'package:flutter/material.dart';
import 'package:library_management_system/providers/book_provider.dart';
import 'package:library_management_system/screens/collect_book_screen.dart';
import 'package:library_management_system/utils/constants.dart';

class StudentWithBookTab extends StatefulWidget {
  String bookId;
  StudentWithBookTab({super.key, required this.bookId});

  @override
  State<StudentWithBookTab> createState() => _StudentWithBookTabState();
}

class _StudentWithBookTabState extends State<StudentWithBookTab> {
  final bookProvider = BookProvider();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // bookProvider.getAllocatedBookStudents(widget.bookId, context);
  }

  @override
  Widget build(BuildContext context) {
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
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: (){
                    Navigator.push(context,
                        MaterialPageRoute(
                          builder: (context) => CollectBookScreen(
                            id: widget.bookId,
                          ),
                        ),
                    );
                  },
                  child: Container(
                    color: Colors.transparent,
                    child: Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                snapshot.data![index]['studentEmail'],
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(snapshot.data![index]['bookReturnDate']),
                            ],
                          ),
                          Row(
                            children: [
                              Text(snapshot.data![index]['status']),
                    
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }


}
