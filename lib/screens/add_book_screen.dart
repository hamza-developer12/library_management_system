import 'package:flutter/material.dart';
import 'package:library_management_system/providers/book_provider.dart';
import 'package:library_management_system/utils/constants.dart';
import 'package:library_management_system/utils/flushmessage.dart';
import 'package:library_management_system/widgets/custom_button.dart';
import 'package:library_management_system/widgets/custom_textfield.dart';
import 'package:provider/provider.dart';

class AddBookScreen extends StatefulWidget {
  const AddBookScreen({super.key});

  @override
  State<AddBookScreen> createState() => _AddBookScreenState();
}

class _AddBookScreenState extends State<AddBookScreen> {
  final _formKey = GlobalKey<FormState>();
  final _bookNameController = TextEditingController();
  final _bookAuthorNameController = TextEditingController();
  final _bookPublisherController = TextEditingController();
  final _bookGenreController = TextEditingController();
  final _bookQuantityController = TextEditingController();
  final _bookFineController = TextEditingController();
  final _bookPriceController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add New Book"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: height * 0.08),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: CustomTextField(
                            controller: _bookNameController,
                            textInputType: TextInputType.text,
                            hintText: "Enter Book Name",
                            obscureText: false,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please Provide Book Name";
                              } else {
                                return null;
                              }
                            }),
                      ),
                      const SizedBox(height: 15),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: CustomTextField(
                            controller: _bookAuthorNameController,
                            textInputType: TextInputType.text,
                            hintText: "Enter Book Author Name",
                            obscureText: false,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please Provide Author Name";
                              } else {
                                return null;
                              }
                            }),
                      ),
                      const SizedBox(height: 15),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: CustomTextField(
                          controller: _bookGenreController,
                          textInputType: TextInputType.text,
                          hintText: "Enter Book Genre",
                          obscureText: false,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please Provide Book Genre";
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      const SizedBox(height: 15),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 10),
                        child: CustomTextField(
                          controller: _bookPublisherController,
                          textInputType: TextInputType.number,
                          hintText: "Enter Book Publisher",
                          obscureText: false,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please Provide Book Publisher";
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      // const SizedBox(height: 15),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 10),
                        child: CustomTextField(
                          controller: _bookQuantityController,
                          textInputType: TextInputType.number,
                          hintText: "Enter Book Quantity",
                          obscureText: false,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please Provide Book Quantity";
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      // const SizedBox(height: 15),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 10),
                        child: CustomTextField(
                          controller: _bookPriceController,
                          textInputType: TextInputType.number,
                          hintText: "Enter Book Price",
                          obscureText: false,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please Provide Book Price";
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      const SizedBox(height: 15),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: CustomTextField(
                            controller: _bookFineController,
                            textInputType: TextInputType.number,
                            hintText: "Enter Book Fine Amount",
                            obscureText: false,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please Provide Book Fine";
                              } else {
                                return null;
                              }
                            }),
                      ),

                      const SizedBox(height: 15),
                      Consumer<BookProvider>(
                        builder: (context, value, child) {
                          return Column(
                            children: [
                              GestureDetector(
                                onTap: () => value.getImage(),
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1, color: Colors.black),
                                      borderRadius: BorderRadius.circular(15)),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 20),
                                  child: Row(
                                    children: [
                                      const SizedBox(width: 10),
                                      const Icon(
                                        Icons.add_a_photo,
                                        color: Constants.primaryColor,
                                        size: 30,
                                      ),
                                      const SizedBox(width: 20),
                                      Text(value.message.toString())
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 18),
                              value.loading
                                  ? const Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : SizedBox(
                                      width: width * 0.85,
                                      child: CustomButton(
                                          onPressed: () async {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              value
                                                  .addBook(
                                                _bookNameController.text,
                                                _bookAuthorNameController.text,
                                                _bookGenreController.text,
                                                int.parse(
                                                    _bookQuantityController
                                                        .text),
                                                int.parse(
                                                  _bookFineController.text,
                                                ),
                                                int.parse(
                                                  _bookPriceController.text,
                                                ),
                                                _bookPublisherController.text,
                                                context,
                                              )
                                                  .then((_) {
                                                FlushMessage.successFlushMessage(
                                                    context,
                                                    "Book Added Successfully");
                                              });
                                            }
                                          },
                                          title: "Add Book"),
                                    ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
