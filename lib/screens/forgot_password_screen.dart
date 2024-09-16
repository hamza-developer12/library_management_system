import 'package:flutter/material.dart';
import 'package:library_management_system/providers/auth_provider.dart';
import 'package:library_management_system/utils/constants.dart';
import 'package:library_management_system/widgets/custom_button.dart';
import 'package:library_management_system/widgets/custom_textfield.dart';
import 'package:provider/provider.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Forgot Password"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              children: [
                Form(
                  child: CustomTextField(
                    controller: _emailController,
                    hintText: "Enter Email",
                    obscureText: false,
                    validator: (value) {
                      if (value!.isEmpty || !value.contains("@")) {
                        return "Please Provide Me A Valid Email";
                      }
                      return null;
                    },
                    textInputType: TextInputType.emailAddress,
                  ),
                ),
                const SizedBox(height: 20),
                Consumer<AuthProvider>(
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
                          await value.forgotPassword(
                              context, _emailController.text);
                        },
                        title: "Reset Password",
                      );
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
}
