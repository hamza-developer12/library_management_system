import 'package:flutter/material.dart';
import 'package:library_management_system/providers/auth_provider.dart';
import 'package:library_management_system/screens/apply_for_book_screen.dart';
import 'package:library_management_system/screens/books_to_return_screen.dart';
import 'package:provider/provider.dart';

import 'chats_list_screen.dart';

class StudentDashboardLayout extends StatefulWidget {
  Widget child;
  StudentDashboardLayout({super.key, required this.child});

  @override
  State<StudentDashboardLayout> createState() => _StudentDashboardLayoutState();
}

class _StudentDashboardLayoutState extends State<StudentDashboardLayout> {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return SafeArea(
      child: Scaffold(
        drawer: Drawer(
          shape: const BeveledRectangleBorder(borderRadius: BorderRadius.zero),
          backgroundColor: Colors.black,
          child: SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 20),
                const Text(
                  "My Library",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                const Divider(color: Colors.white),
                const SizedBox(height: 20),
                // Logout.........
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ChatsListScreen(),
                          ));
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                        border: Border(bottom: BorderSide(color: Colors.white)),
                      ),
                      padding: const EdgeInsets.only(top: 20, bottom: 5),
                      child: const Row(
                        children: [
                          Icon(
                            Icons.chat,
                            size: 40,
                            color: Colors.white,
                          ),
                          SizedBox(width: 20),
                          Text(
                            "Messages",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ApplyForBookScreen(),
                          ));
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                        border: Border(bottom: BorderSide(color: Colors.white)),
                      ),
                      padding: const EdgeInsets.only(top: 20, bottom: 5),
                      child: const Row(
                        children: [
                          Icon(
                            Icons.chat,
                            size: 40,
                            color: Colors.white,
                          ),
                          SizedBox(width: 20),
                          Text(
                            "Apply For Book",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const BooksToReturnScreen(),
                          ));
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                        border: Border(bottom: BorderSide(color: Colors.white)),
                      ),
                      padding: const EdgeInsets.only(top: 20, bottom: 5),
                      child: const Row(
                        children: [
                          Icon(
                            Icons.chat,
                            size: 40,
                            color: Colors.white,
                          ),
                          SizedBox(width: 20),
                          Text(
                            "Books To Return",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // Logout.........

                // Logout.........

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title:
                                const Text("Are You Sure You Want to logout?"),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text("No")),
                              TextButton(
                                  onPressed: () async {
                                    authProvider.logout(context);
                                  },
                                  child: const Text("Yes"))
                            ],
                          );
                        },
                      );
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                        border: Border(bottom: BorderSide(color: Colors.white)),
                      ),
                      padding: const EdgeInsets.only(top: 20, bottom: 5),
                      child: const Row(
                        children: [
                          Icon(
                            Icons.logout,
                            size: 40,
                            color: Colors.white,
                          ),
                          SizedBox(width: 20),
                          Text(
                            "Logout",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: widget.child,
      ),
    );
  }
}
