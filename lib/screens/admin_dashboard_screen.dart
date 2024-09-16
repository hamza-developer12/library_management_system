import 'package:flutter/material.dart';
import 'package:library_management_system/providers/book_provider.dart';
import 'package:library_management_system/screens/book_detail_screen.dart';
import 'package:library_management_system/screens/profile_screen.dart';
import 'package:library_management_system/utils/constants.dart';
import 'package:library_management_system/utils/dashboard_layout.dart';
import 'package:cached_network_image/cached_network_image.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreen();
}

class _AdminDashboardScreen extends State<AdminDashboardScreen> {
  final bookProvider = BookProvider();
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return DashboardLayout(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Builder(builder: (context) {
                  return IconButton(
                    icon: const Icon(
                      Icons.menu,
                      color: Constants.primaryColor,
                      size: 40,
                    ),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                  );
                }),
                const SizedBox(width: 5),
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search a book by name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: const BorderSide(color: Colors.black),
                      ),
                      filled: true,
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 0.0, horizontal: 20.0),
                      fillColor: Colors.grey[200],
                      prefixIcon: const Icon(Icons.search),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _searchQuery = value.toLowerCase();
                      });
                    },
                  ),
                ),
                const SizedBox(width: 5),
                CircleAvatar(
                  maxRadius: 24,
                  backgroundColor: Constants.primaryColor,
                  foregroundColor: Colors.white,
                  child: IconButton(
                    iconSize: 30,
                    icon: const Icon(
                      Icons.person,
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ProfileScreen()));
                      // Add your onPressed code here!
                    },
                  ),
                ),
              ],
            ),
          ),
          StreamBuilder(
            stream: bookProvider.getBooks(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Expanded(
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Constants.primaryColor,
                    ),
                  ),
                );
              } else if (snapshot.hasError) {
                return const Expanded(
                  child: Center(
                    child: Text("Something Went Wrong"),
                  ),
                );
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Expanded(
                  child: Center(
                    child: Text("No Books Found"),
                  ),
                );
              } else {
                // Filtering logic
                final books = snapshot.data!.where((book) {
                  final bookName = book["book_name"].toString().toLowerCase();
                  final bookAuthor =
                      book["book_author"].toString().toLowerCase();
                  return bookName.contains(_searchQuery) ||
                      bookAuthor.contains(_searchQuery);
                }).toList();

                return Expanded(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
                    ),
                    itemCount: books.length,
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () => moveToNextScren(context, books[index]),
                      child: Card(
                        elevation: 4,
                        color: Colors.white,
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(height: height * 0.01),
                              CachedNetworkImage(
                                imageUrl:
                                    books[index]["cover_image"].toString(),
                                progressIndicatorBuilder:
                                    (context, url, progress) =>
                                        CircularProgressIndicator(
                                  value: progress.progress,
                                  color: Constants.primaryColor,
                                ),
                              ),
                              SizedBox(height: height * 0.02),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  void moveToNextScren(BuildContext context, Map<String, dynamic> data) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookDetailScreen(data: data),
      ),
    );
  }
}
