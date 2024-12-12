import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:library_management_system/screens/generate_qr_screen.dart';
import 'package:library_management_system/utils/constants.dart';

class BookInfoTab extends StatefulWidget {
  final Map<String, dynamic> data;
  const BookInfoTab({super.key, required this.data});

  @override
  State<BookInfoTab> createState() => _BookInfoTabState();
}

class _BookInfoTabState extends State<BookInfoTab> {
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
              "Publisher: ${widget.data['book_publisher']}",
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
            Text(
              "Book Price: ${widget.data['book_price']}",
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
            Text(
              "Late Return Fine: ${widget.data['book_fine']}",
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
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Constants.primaryColor,
        foregroundColor: Colors.white,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => GenerateQrScreen(data: widget.data),
              ));
        },
        child: const Icon(Icons.qr_code_outlined),
      ),
    );
  }
}
