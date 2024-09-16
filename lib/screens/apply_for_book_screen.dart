import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:library_management_system/providers/book_provider.dart';
import 'package:library_management_system/utils/constants.dart';
import 'package:library_management_system/widgets/custom_button.dart';
import 'package:library_management_system/widgets/custom_textfield.dart';
import 'package:provider/provider.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ApplyForBookScreen extends StatefulWidget {
  const ApplyForBookScreen({super.key});

  @override
  State<ApplyForBookScreen> createState() => _ApplyForBookScreenState();
}

class _ApplyForBookScreenState extends State<ApplyForBookScreen> {
  String? _scanResult;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _bookNameController = TextEditingController();
  final TextEditingController _bookAuthorController = TextEditingController();
  final TextEditingController _bookGenreController = TextEditingController();
  final TextEditingController _bookIdController = TextEditingController();
  final TextEditingController _studentNameController = TextEditingController();
  final TextEditingController _studentEmailController = TextEditingController();
  final TextEditingController _bookAllocationDateController =
  TextEditingController();
  final TextEditingController _bookReturnDateController =
  TextEditingController();
  MobileScannerController scannerController = MobileScannerController();
  Barcode? _barcode;
  Future<void> scanQrCode() async {
    await showDialog(context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Scan Qr Code"),
          content: Container(
            width: 300,
            height: 300,
            child: MobileScanner(
              controller: scannerController,
              onDetect: (BarcodeCapture barCodes){
                _barcode = barCodes.barcodes.firstOrNull;
                if(_barcode != null && _barcode!.rawValue != null && _barcode!.rawValue!.isNotEmpty){
                  setState(() {
                    _scanResult = _barcode!.rawValue;
                  });
                }
                if (_scanResult != null && _scanResult!.isNotEmpty) {
                  scannerController.stop();
                  Navigator.pop(context); // Close the scanner dialog
                  _updateControllers(); // Update the controllers with the scanned result
                }
              },
            ),
          ),
        );
      },
    );
  }

  void _updateControllers() {
    if (_scanResult != null) {
      try {
        Map<String, dynamic> jsonData = jsonDecode(_scanResult!);
        _bookNameController.text = jsonData["book_name"] ?? "";
        _bookAuthorController.text = jsonData["book_author"] ?? "";
        _bookGenreController.text = jsonData["book_genre"] ?? "";
        _bookIdController.text = jsonData["book_id"] ?? "";
      } catch (e) {
        debugPrint("Error decoding JSON: $e");
        _bookNameController.clear();
        _bookAuthorController.clear();
        _bookGenreController.clear();
      }
    } else {
      _bookNameController.clear();
      _bookGenreController.clear();
      _bookAuthorController.clear();
      _bookIdController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Allocate Book"),
        actions: [
          IconButton(
            icon: const Icon(Icons.qr_code_scanner),
            onPressed: scanQrCode,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                CustomTextField(
                  controller: _bookNameController,
                  hintText: "Enter Book Name",
                  textInputType: TextInputType.name,
                  obscureText: false,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please Provide book Name";
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(height: 15),
                CustomTextField(
                  controller: _bookAuthorController,
                  textInputType: TextInputType.name,
                  hintText: "Enter Book Author Name",
                  obscureText: false,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please Provide book Author Name";
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(height: 15),
                CustomTextField(
                  textInputType: TextInputType.text,
                  controller: _bookGenreController,
                  hintText: "Enter Book Genre",
                  obscureText: false,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please Provide book Genre";
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(height: 15),
                CustomTextField(
                  controller: _bookIdController,
                  textInputType: TextInputType.text,
                  hintText: "Enter Book Id",
                  obscureText: false,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please Provide book Id";
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(height: 15),
                CustomTextField(
                  controller: _studentNameController,
                  textInputType: TextInputType.name,
                  hintText: "Enter Student Name",
                  obscureText: false,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please Provide Student Name";
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(height: 15),
                CustomTextField(
                  controller: _studentEmailController,
                  textInputType: TextInputType.emailAddress,
                  hintText: "Enter Student Email",
                  obscureText: false,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please Provide Student Email";
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(height: 15),
                CustomTextField(
                  onTap: () {
                    _selectDate(context);
                    return null;
                  },
                  controller: _bookAllocationDateController,
                  textInputType: TextInputType.datetime,
                  hintText: "Enter Book Allocation Date",
                  obscureText: false,
                  readOnly: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please Provide Allocation Date";
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(height: 15),
                CustomTextField(
                  onTap: () {
                    _selectReturnDate(context);
                    return null;
                  },
                  controller: _bookReturnDateController,
                  textInputType: TextInputType.datetime,
                  hintText: "Enter Book Returning Date",
                  obscureText: false,
                  readOnly: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please Provide Book Returning Date";
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(height: 20),
                Consumer<BookProvider>(
                  builder: (context, value, child) {
                    Map<String, dynamic> bookData = {
                      "bookName": _bookNameController.text,
                      "bookAuthor": _bookAuthorController.text,
                      "bookGenre": _bookGenreController.text,
                      "bookId": _bookIdController.text,
                      "studentName": _studentNameController.text,
                      "studentEmail": _studentEmailController.text,
                      "bookAllocationDate": _bookAllocationDateController.text,
                      "bookReturnDate": _bookReturnDateController.text,
                      "status": "pending",
                    };
                    if (value.loading) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Constants.primaryColor,
                        ),
                      );
                    } else {
                      return CustomButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              await value
                                  .allocateBooksToStudent(bookData, context)
                                  .then((_) {
                                _bookNameController.clear();
                                _bookAuthorController.clear();
                                _bookGenreController.clear();
                                _bookIdController.clear();
                                _bookAllocationDateController.clear();
                                _bookReturnDateController.clear();
                                _studentNameController.clear();
                                _studentEmailController.clear();
                              });
                            }
                          },
                          title: "Apply For Book");
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(21000));
    if (picked != null) {
      setState(() {
        _bookAllocationDateController.text = picked.toString().split(" ")[0];
      });
    }
  }

  Future<void> _selectReturnDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(21000));
    if (picked != null) {
      setState(() {
        _bookReturnDateController.text = picked.toString().split(" ")[0];
      });
    }
  }
}
