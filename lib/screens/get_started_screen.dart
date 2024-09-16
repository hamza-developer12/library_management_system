import "package:flutter/material.dart";
import "package:library_management_system/screens/login_screen.dart";
import "package:library_management_system/utils/constants.dart";
import "package:shared_preferences/shared_preferences.dart";

class GetStartedScreen extends StatefulWidget {
  const GetStartedScreen({super.key});

  @override
  State<GetStartedScreen> createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Constants.primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Image.asset(
              "assets/img/screen1.png",
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    "Welcome to QR Enhance Library",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold),
                  ),
                ),

                SizedBox(height: height * 0.04),
                GestureDetector(
                  onTap: (){
                    setPreference();
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ));
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    width: width * 1,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15)
                    ),
                    child: const Text("Get Started", style: TextStyle(
                      fontSize: 20,
                    )),
                  ),
                )
                // SizedBox(
                //   width: width * 0.8,
                //   child: ElevatedButton(
                //     style: ElevatedButton.styleFrom(
                //       backgroundColor: Colors.white,
                //       foregroundColor: Colors.black,
                //     ),
                //     onPressed: () async {
                //       setPreference();
                //       Navigator.pushReplacement(
                //           context,
                //           MaterialPageRoute(
                //             builder: (context) => const LoginScreen(),
                //           ));
                //     },
                //     child: const Text(
                //       'Get Started',
                //       style: TextStyle(
                //         fontSize: 20,
                //         fontWeight: FontWeight.bold,
                //       ),
                //     ),
                //   ),
                // ),

              ],
            ),
          )
        ],
      ),
    );
  }

  void setPreference() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    sharedPreferences.setBool("notFirstTime", true);
  }
}
