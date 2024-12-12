import 'package:flutter/material.dart';
import 'package:library_management_system/providers/auth_provider.dart';
import 'package:library_management_system/utils/constants.dart';
import 'package:library_management_system/utils/flushmessage.dart';
import 'package:library_management_system/widgets/custom_button.dart';
import 'package:library_management_system/widgets/custom_textfield.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _cmsIdController = TextEditingController();
  final _departmentController = TextEditingController();
  final _phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign Up"),
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
                        hintText: "Enter Student Email",
                        obscureText: false,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: const Text(
                        "CMS Id",
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
                        controller: _cmsIdController,
                        textInputType: TextInputType.text,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please provide a cms id";
                          } else {
                            return null;
                          }
                        },
                        hintText: "Enter Student CMS Id",
                        obscureText: false,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: const Text(
                        "Department",
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
                        controller: _departmentController,
                        textInputType: TextInputType.text,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please provide student department";
                          } else {
                            return null;
                          }
                        },
                        hintText: "Enter Student Department",
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
                        title: "Signup",
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
          .signup(
          _nameController.text,
          _emailController.text,
          _phoneController.text,
          _passwordController.text,
          'student',
          'student',
          _departmentController.text,
          _cmsIdController.text)
          .then((_) {
        FlushMessage.successFlushMessage(context, "Student Added Successfully");
      }).catchError((error) {
        FlushMessage.errorFlushMessage(context, error.toString());
      });
    }
  }
}
