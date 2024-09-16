import 'package:flutter/material.dart';
import 'package:library_management_system/tabs/std_book_info_tab.dart';
import 'package:library_management_system/tabs/std_student_with_book_tab.dart';

class StdBookDetailScreen extends StatefulWidget {
  final Map<String, dynamic>? data;
  const StdBookDetailScreen({super.key, required this.data});

  @override
  State<StdBookDetailScreen> createState() => _StdBookDetailScreenState();
}

class _StdBookDetailScreenState extends State<StdBookDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
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

            ],
          ),
        ),
        body: TabBarView(
          children: [
            StdBookInfoTab(data: widget.data as Map<String,dynamic>),
            StdStudentWithBookTab(bookId: widget.data!["book_id"]),
            // BookInfoTab(data: widget.data as Map<String, dynamic>),
            // StudentWithBookTab(bookId: widget.data!["book_id"],),
            // EditBookTab(data: widget.data as Map<String,dynamic>,)
          ],
        ),
      ),
    );
  }
}
