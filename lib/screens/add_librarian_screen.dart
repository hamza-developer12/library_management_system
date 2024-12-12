import 'package:flutter/material.dart';
import 'package:library_management_system/providers/auth_provider.dart';
import 'package:library_management_system/utils/constants.dart';
import 'package:library_management_system/utils/flushmessage.dart';
import 'package:library_management_system/widgets/custom_button.dart';
import 'package:library_management_system/widgets/custom_textfield.dart';
import 'package:provider/provider.dart';

class AddLibrarianScreen extends StatefulWidget {
  const AddLibrarianScreen({super.key});

  @override
  State<AddLibrarianScreen> createState() => _AddLibrarianScreenState();
}

class _AddLibrarianScreenState extends State<AddLibrarianScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _specificRoleController = TextEditingController();
  final _phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Librarian"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: const Text(
                        "Name",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      alignment: Alignment.center,
                      width: width * 0.9,
                      child: CustomTextField(
                        controller: _nameController,
                        textInputType: TextInputType.text,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please provide a name";
                          } else {
                            return null;
                          }
                        },
                        hintText: "Enter Name",
                        obscureText: false,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: const Text(
                        "Email",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: width * 0.9,
                      child: CustomTextField(
                        controller: _emailController,
                        textInputType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value!.isEmpty || !value.contains("@")) {
                            return "Please provide a valid email";
                          } else {
                            return null;
                          }
                        },
                        hintText: "Enter Email",
                        obscureText: false,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: const Text(
                        "Title",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: width * 0.9,
                      child: CustomTextField(
                        controller: _specificRoleController,
                        textInputType: TextInputType.text,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please provide a title";
                          } else {
                            return null;
                          }
                        },
                        hintText: "Library Manager, Assistant",
                        obscureText: false,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: const Text(
                        "Phone Number",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: width * 0.9,
                      child: CustomTextField(
                        controller: _phoneController,
                        hintText: "Enter Phone Number",
                        textInputType: TextInputType.text,
                        obscureText: false,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please provide a valid phone number";
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: const Text(
                        "Password",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: width * 0.9,
                      child: CustomTextField(
                        controller: _passwordController,
                        textInputType: TextInputType.text,
                        hintText: "Enter Password",
                        obscureText: true,
                        validator: (value) {
                          if (value!.length < 6) {
                            return "Password must be 6 characters long";
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Consumer<AuthProvider>(
                builder: (context, value, child) {
                  if (value.loading == true) {
                    return const Center(
                        child: CircularProgressIndicator(
                          color: Constants.primaryColor,
                        ));
                  } else {
                    return SizedBox(
                      width: width * 0.85,
                      child: CustomButton(
                        onPressed: () {
                          _register(value);
                        },
                        title: "Add Librarian",
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _register(AuthProvider value) {
    if (_formKey.currentState!.validate()) {
      value
          .signup(_nameController.text, _emailController.text,_phoneController.text,
          _passwordController.text, "admin",
          _specificRoleController.text,
          "",
          ""
      )
          .then((_) {
        FlushMessage.successFlushMessage(context, "Librarian Added Successfully");
      }).catchError((error) {
        FlushMessage.errorFlushMessage(context, error.toString());
      });
    }
  }
}
