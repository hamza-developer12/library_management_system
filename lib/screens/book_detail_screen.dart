import 'package:flutter/material.dart';
import 'package:library_management_system/tabs/book_info_tab.dart';
import 'package:library_management_system/tabs/edit_book_tab.dart';
import 'package:library_management_system/tabs/student_with_book_tab.dart';

class BookDetailScreen extends StatefulWidget {
  final Map<String, dynamic>? data;
  const BookDetailScreen({super.key, required this.data});

  @override
  State<BookDetailScreen> createState() => _BookDetailScreenState();
}

class _BookDetailScreenState extends State<BookDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Book Details"),
          bottom: const TabBar(
            indicatorColor: Colors.white,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorWeight: 5,
            indicatorPadding: EdgeInsets.only(bottom: 1),
            tabs: [
              Tab(
                icon: Icon(
                  Icons.info_outline,
                  color: Colors.white,
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.person,
                  color: Colors.white,
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            BookInfoTab(data: widget.data as Map<String, dynamic>),
            StudentWithBookTab(bookId: widget.data!["book_id"],),
            EditBookTab(data: widget.data as Map<String,dynamic>,)
          ],
        ),
      ),
    );
  }
}
