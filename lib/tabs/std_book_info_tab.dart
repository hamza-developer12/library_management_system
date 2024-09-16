import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:library_management_system/utils/constants.dart';

class StdBookInfoTab extends StatefulWidget {
  final Map<String, dynamic> data;
  const StdBookInfoTab({super.key, required this.data});

  @override
  State<StdBookInfoTab> createState() => _StdBookInfoTabState();
}

class _StdBookInfoTabState extends State<StdBookInfoTab> {
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
    );
  }
}
