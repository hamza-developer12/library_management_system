import 'package:flutter/material.dart';
import 'package:library_management_system/providers/book_provider.dart';
import 'package:library_management_system/utils/constants.dart';
import 'package:library_management_system/widgets/custom_button.dart';
import 'package:library_management_system/widgets/custom_textfield.dart';
import 'package:provider/provider.dart';

class EditBookTab extends StatefulWidget {
  Map<String, dynamic>? data;
  EditBookTab({super.key, required this.data});

  @override
  State<EditBookTab> createState() => _EditBookTabState();
}

class _EditBookTabState extends State<EditBookTab> {
  final bookProvider = BookProvider();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final bookNameController =
        TextEditingController(text: widget.data!["book_name"]);
    final bookAuthorController =
        TextEditingController(text: widget.data!["book_author"]);
    final bookGenreController =
        TextEditingController(text: widget.data!["book_genre"]);
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const Text(
                        "Edit Book",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      CustomTextField(
                        controller: bookNameController,
                        hintText: "Enter Book Name",
                        obscureText: false,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please Provide A Book Name";
                          } else {
                            return null;
                          }
                        },
                        textInputType: TextInputType.name,
                      ),
                      const SizedBox(height: 20),
                      CustomTextField(
                        controller: bookAuthorController,
                        hintText: "Enter Author Name",
                        obscureText: false,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please Provide Author Name";
                          } else {
                            return null;
                          }
                        },
                        textInputType: TextInputType.name,
                      ),
                      const SizedBox(height: 20),
                      CustomTextField(
                        controller: bookGenreController,
                        hintText: "Enter Book Genre",
                        obscureText: false,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please provide Book Genre";
                          } else {
                            return null;
                          }
                        },
                        textInputType: TextInputType.name,
                      ),
                      const SizedBox(height: 20),
                      Consumer<BookProvider>(
                        builder: (context, value, child) {
                          if (value.loading) {
                            return const Center(
                              child: CircularProgressIndicator(
                                color: Constants.primaryColor,
                              ),
                            );
                          } else {
                            return CustomButton(
                                onPressed: () async {
                                  value.updateBook(
                                      context,
                                      widget.data as Map<String, dynamic>,
                                      bookNameController.text,
                                      bookAuthorController.text,
                                      bookGenreController.text);
                                },
                                title: " Update ");
                          }
                        },
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.white,
        backgroundColor: Constants.primaryColor,
        child: const Icon(Icons.delete),
        onPressed: () {
          _deleteBook(context);
        },
      ),
    );
  }

  void _deleteBook(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            "Are You Sure You Want To Delete? ",
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          actions: [
            TextButton(
                onPressed: () async {
                  await bookProvider.deleteBook(
                      widget.data as Map<String, dynamic>, context);
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
