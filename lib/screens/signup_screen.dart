import 'package:flutter/material.dart';
import 'package:library_management_system/screens/login_screen.dart';
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
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
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
              SingleChildScrollView(
                child: Form(
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
                          textInputType: TextInputType.name,
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
                          hintText: "Enter Password",
                          textInputType: TextInputType.text,
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
              ),
              const SizedBox(height: 20),
              Consumer<AuthProvider>(
                builder: (context, value, child) {
                  if (value.loading == true) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return SizedBox(
                      width: width * 0.85,
                      child: CustomButton(
                        onPressed: () {
                          _register(value);
                        },
                        title: "Sign Up",
                      ),
                    );
                  }
                },
              ),
              const SizedBox(height: 18),
              Container(
                width: width * 0.9,
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account?",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 12),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                          (route) => false,
                        );
                      },
                      child: const Text(
                        "Log In",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Constants.primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
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
              _passwordController.text, 'student')
          .then((_) {
        FlushMessage.successFlushMessage(context, "Registration Successfull");
      }).catchError((error) {
        FlushMessage.errorFlushMessage(context, error.toString());
      });
    }
  }
}
