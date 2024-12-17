import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:library_management_system/providers/book_provider.dart';
import 'package:library_management_system/utils/constants.dart';
import 'package:screenshot/screenshot.dart';

import '../screens/std_book_detail_screen.dart';

class StdBookInfoTab extends StatefulWidget {
  final Map<String, dynamic> data;
  const StdBookInfoTab({super.key, required this.data});

  @override
  State<StdBookInfoTab> createState() => _StdBookInfoTabState();
}

class _StdBookInfoTabState extends State<StdBookInfoTab> {
  final bookProvider = BookProvider();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(height: height * 0.02),
            CachedNetworkImage(
              imageUrl: widget.data["cover_image"].toString(),
              progressIndicatorBuilder: (context, url, progress) =>
                  CircularProgressIndicator(
                value: progress.progress,
                color: Constants.primaryColor,
              ),
            ),
            Text(
              widget.data['book_name'].toString(),
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            Text(
              "Author: ${widget.data['book_author']}",
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
            Text(
              "Book Genre: ${widget.data["book_genre"]}",
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
            Text(
              "Book Publisher: ${widget.data["book_publisher"]}",
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
            Text(
              "Book Price: ${widget.data["book_price"]}",
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
            Text(
              "Late Return Fine: ${widget.data["book_fine"]}",
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
            Text(
              "Quantity: ${widget.data['book_quantity']}",
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
            Text(
              "Remaining ${widget.data['remaining']}",
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: height * 0.08,
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.symmetric(horizontal: 30),
              child: const Text("Recommended Books",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  )),
            ),
            SizedBox(height: height * 0.02),
            StreamBuilder(
              stream: bookProvider.getRecommendedBooks(
                  widget.data["book_genre"], widget.data["book_id"]),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Expanded(
                      child: Center(
                    child: Text("No Recommended Books Found"),
                  ));
                } else {
                  return Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () =>
                              moveToNextScren(context, snapshot.data![index]),
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(height: height * 0.01),
                                CachedNetworkImage(
                                  imageUrl: snapshot.data![index]["cover_image"]
                                      .toString(),
                                  progressIndicatorBuilder:
                                      (context, url, progress) =>
                                          CircularProgressIndicator(
                                    value: progress.progress,
                                    color: Constants.primaryColor,
                                  ),
                                ),
                                SizedBox(height: height * 0.01),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }

  void moveToNextScren(BuildContext context, Map<String, dynamic> data) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StdBookDetailScreen(data: data),
      ),
    );
  }
}
