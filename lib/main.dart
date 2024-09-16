import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:library_management_system/providers/auth_provider.dart';
import 'package:library_management_system/providers/book_provider.dart';
import 'package:library_management_system/providers/chat_provider.dart';
import 'package:library_management_system/providers/user_provider.dart';
import 'package:library_management_system/screens/check_screen.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import "package:library_management_system/utils/constants.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => ChatProvider()),
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => BookProvider()),
      ],
      child: MaterialApp(
          title: 'Library Management System',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: "Poppins",
            appBarTheme: const AppBarTheme(
              backgroundColor: Constants.primaryColor,
              foregroundColor: Colors.white,
              centerTitle: true,
            ),
            primaryColor: Constants.primaryColor,
            textTheme: const TextTheme(
              displayLarge: TextStyle(
                fontSize: Constants.largeFont,
                color: Constants.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Constants.primaryColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 100, vertical: 14)),
            ),
          ),
          home: const CheckScreen()),
    );
  }
}
