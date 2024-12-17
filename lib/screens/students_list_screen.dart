import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:library_management_system/providers/book_provider.dart';
import 'package:library_management_system/screens/profile_screen.dart';
import 'package:library_management_system/screens/student_info_screen.dart';
class StudentsListScreen extends StatefulWidget {
  const StudentsListScreen({super.key});

  @override
  State<StudentsListScreen> createState() => _StudentsListScreenState();
}

class _StudentsListScreenState extends State<StudentsListScreen> {
  final bookProvider = BookProvider();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Students"),
      ),
      body: StreamBuilder(
          stream: bookProvider.getStudents(),
          builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }else if(!snapshot.hasData || snapshot.data!.length == 0){
              return Center(
                child: Text("No Student Found"),
              );
            }else{
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => StudentInfoScreen(
                                  data: snapshot.data![index],
                                ),
                            )
                        );
                      },
                      child: ListTile(
                        title: Text(snapshot.data![index]['name']),
                        subtitle: Text(snapshot.data![index]['email']),
                      ),
                    );
                  },
              );
            }
          },
      ),
    );
  }
}
