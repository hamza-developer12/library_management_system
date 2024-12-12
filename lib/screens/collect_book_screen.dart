import 'package:flutter/material.dart';
import 'package:library_management_system/providers/book_provider.dart';
import 'package:library_management_system/widgets/custom_button.dart';

class CollectBookScreen extends StatefulWidget {
  final String id;
  const CollectBookScreen({
    super.key,
    required this.id,
  });

  @override
  State<CollectBookScreen> createState() => _CollectBookScreenState();
}

class _CollectBookScreenState extends State<CollectBookScreen> {
  final BookProvider bookProvider = BookProvider();
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Collect Book"),

      ),
      body: FutureBuilder(future: bookProvider.getBookAllocatedDetails(widget.id),
          builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }else if(!snapshot.hasData || snapshot.data == null ){
              return Center(
                child: Text("No Record Found"),
              );
            }else{
              return Container(
                padding: EdgeInsets.symmetric(horizontal: width * 0.01),
                child: Card(
                  elevation: 5,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    width: double.infinity,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Book Name:",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              snapshot.data!["bookName"],
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: height * 0.01),
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Book Author:",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              snapshot.data!
                              ["bookAuthor"],
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: height * 0.01),
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Book Price:",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              snapshot.data!["bookPrice"]
                                  .toString(),
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: height * 0.01),
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Allocation Date:",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              snapshot.data!
                              ["bookAllocationDate"],
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: height * 0.01),
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Return Date:",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              snapshot.data!
                              ["bookReturnDate"],
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: height * 0.01),
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Fine:",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              DateTime.parse(snapshot
                                  .data!
                              ['bookReturnDate'])
                                  .isBefore(DateTime.now())
                                  ? snapshot.data!
                              ['lateFine']
                                  .toString()
                                  : "0",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: height * 0.06,
                          child: ElevatedButton(onPressed: (){
                            _deleteRecord(snapshot.data!['id'], snapshot.data!['bookId'],
                                snapshot.data!['studentEmail'], context);
                          },
                              child: Text("Collect", style: TextStyle(
                                fontSize: 16,
                              ),),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
          },),
    );
  }
  void _deleteRecord(
      String id, String bookId, String studentEmail, BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            "Are You Sure You Want To Mark It Returned",
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  bookProvider.deleteAllocatedBook(
                      id, bookId, studentEmail, "Book Returned", context);
                },
                child: const Text("Yes")),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("No"))
          ],
        );
      },
    );
  }
}
