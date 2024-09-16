import 'package:flutter/material.dart';
import 'package:library_management_system/providers/user_provider.dart';
import 'package:library_management_system/screens/chat_screen.dart';
import 'package:library_management_system/utils/constants.dart';

class ChatsListScreen extends StatefulWidget {
  const ChatsListScreen({super.key});

  @override
  State<ChatsListScreen> createState() => _ChatsListScreenState();
}

class _ChatsListScreenState extends State<ChatsListScreen> {
  final userProvider = UserProvider();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userProvider.getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chats Screen'),
      ),
      body: FutureBuilder(
        future: userProvider.getUsers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator(
              color: Constants.primaryColor,
            ));
          } else if (snapshot.hasError) {
            return const Center(
              child: Text("Something Went Wrong"),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatScreen(
                            senderId: userProvider.userId.toString(),
                            receiverId: snapshot.data![index]['uid'],
                            name: snapshot.data![index]['name'],
                          ),
                        ));
                  },
                  title: Text(snapshot.data![index]['name'].toString()),
                  subtitle: Text(snapshot.data![index]['email'].toString()),
                );
              },
            );
          }
        },
      ),
    );
  }
}
