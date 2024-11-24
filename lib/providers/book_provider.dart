import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:library_management_system/screens/admin_dashboard_screen.dart';
import 'package:library_management_system/utils/flushmessage.dart';

class BookProvider extends ChangeNotifier {
  bool loading = false;
  int itemCount = 0;
  final storage = FirebaseStorage.instance;
  final firebaseAuth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;
  File? _image;
  final imagePicker = ImagePicker();
  String? message = "No Image Selected";
  XFile? pickedImage;

  Future<void> getImage() async {
    pickedImage = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      _image = File(pickedImage!.path);
      message = "Image Selected";
      notifyListeners();
    } else {
      message = "No Image Selected";
      notifyListeners();
    }
  }

  Future<void> addBook(String bookName, String bookAuthor, String bookGenre,
      int bookQuantity, BuildContext context) async {
    if (_image == null) {
      // Handle the case where no image is selected
      message = "No Image Selected";
      notifyListeners();
      return;
    }

    try {
      loading = true;
      notifyListeners();
      // Create a new document reference with an automatically generated ID
      DocumentReference docRef = firestore.collection('books').doc();

      // Use the document reference ID as the bookId
      String bookId = docRef.id;
      Reference ref = storage.ref().child('books_images/$bookId');

      UploadTask uploadTask = ref.putFile(_image!);

      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});

      String downloadUrl = await taskSnapshot.ref.getDownloadURL();

      await firestore.collection("books").doc(bookId).set({
        "book_id": bookId,
        "book_name": bookName,
        "book_author": bookAuthor,
        "book_genre": bookGenre,
        "book_quantity": bookQuantity,
        "remaining": bookQuantity,
        "cover_image": downloadUrl
      });

      loading = false;
      _image = null;
      pickedImage = null;
      message = "No Image Selected";
      notifyListeners();
      Navigator.pop(context);

      //
    } catch (e) {
      print("something went wrong: $e");
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Stream<List> getBooks() {
    return FirebaseFirestore.instance
        .collection("books")
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => doc.data()).toList();
    });
  }

  Future<void> allocateBooksToStudent(
      Map<String, dynamic> data, BuildContext context) async {
    loading = true;
    notifyListeners();
    try {
      QuerySnapshot studentSnapshot = await FirebaseFirestore.instance
          .collection("users")
          .where("email", isEqualTo: data["studentEmail"])
          .get();

      if (studentSnapshot.docs.isEmpty) {
        FlushMessage.errorFlushMessage(context, "Student Not Found");
      } else {
        Map<String, dynamic> doc =
            studentSnapshot.docs.first.data() as Map<String, dynamic>;
        DocumentReference docRef = firestore.collection('allocate_books').doc();
        DocumentSnapshot bookDoc = await FirebaseFirestore.instance
            .collection("books")
            .doc(data["bookId"])
            .get();
        FirebaseFirestore.instance
            .collection("allocate_books")
            .doc(docRef.id)
            .set({
          "id": docRef.id,
          "bookName": data["bookName"],
          "bookAuthor": data["bookAuthor"],
          "bookGenre": data["bookGenre"],
          "bookId": data["bookId"],
          "bookAllocationDate": data["bookAllocationDate"],
          "bookReturnDate": data["bookReturnDate"],
          "studentName": data["studentName"],
          "studentEmail": doc["email"],
          "status": data["status"],
        });
        Map<String, dynamic> bookData = bookDoc.data() as Map<String, dynamic>;
        int remaining = bookData["remaining"] ?? 0;

        await FirebaseFirestore.instance
            .collection("books")
            .doc(bookData["book_id"])
            .update({
          "remaining": remaining - 1,
        });

        if (context.mounted) {
          Navigator.pop(context);
          if (data["status"] == "approved") {
            FlushMessage.successFlushMessage(
                context, "Book Allocated Successfully");
          } else {
            FlushMessage.successFlushMessage(
                context, "Applied For Book Allocation");
          }
        }
      }
    } catch (err) {
      print(err);
      FlushMessage.errorFlushMessage(context, "An error occurred");
    } finally {
      loading = false;
      notifyListeners();
    }
  }
  // Student applying for book functionality here.....
  Future<void> applyForBook(
      Map<String, dynamic> data, BuildContext context) async {
    loading = true;
    notifyListeners();
    try {
      QuerySnapshot studentSnapshot = await FirebaseFirestore.instance
          .collection("users")
          .where("email", isEqualTo: data["studentEmail"])
          .get();

      if (studentSnapshot.docs.isEmpty) {
        FlushMessage.errorFlushMessage(context, "User Not Found");
      } else {
        Map<String, dynamic> doc =
        studentSnapshot.docs.first.data() as Map<String, dynamic>;
        DocumentReference docRef = firestore.collection('allocate_books').doc();
        DocumentSnapshot bookDoc = await FirebaseFirestore.instance
            .collection("books")
            .doc(data["bookId"])
            .get();
        FirebaseFirestore.instance
            .collection("allocate_books")
            .doc(docRef.id)
            .set({
          "id": docRef.id,
          "bookName": data["bookName"],
          "bookAuthor": data["bookAuthor"],
          "bookGenre": data["bookGenre"],
          "bookId": data["bookId"],
          "bookAllocationDate": data["bookAllocationDate"],
          "bookReturnDate": data["bookReturnDate"],
          "studentName": data["studentName"],
          "studentEmail": doc["email"],
          "status": "pending",
        });
        // Map<String, dynamic> bookData = bookDoc.data() as Map<String, dynamic>;
        // int remaining = bookData["remaining"] ?? 0;
        //
        // await FirebaseFirestore.instance
        //     .collection("books")
        //     .doc(bookData["book_id"])
        //     .update({
        //   "remaining": remaining - 1,
        // });
        //
        // if (context.mounted) {
        //   Navigator.pop(context);
        //   if (data["status"] == "approved") {
        //     FlushMessage.successFlushMessage(
        //         context, "Book Allocated Successfully");
        //   } else {
        //     FlushMessage.successFlushMessage(
        //         context, "Applied For Book Allocation");
        //   }
        // }
      }
    } catch (err) {
      print(err);
      FlushMessage.errorFlushMessage(context, "An error occurred");
    } finally {
      loading = false;
      notifyListeners();
    }
  }
  Future<List<Map<String, dynamic>>> getAllocatedBookStudents(
      String bookId, BuildContext context) async {
    loading = true;
    notifyListeners();
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection("allocate_books")
          .where("bookId", isEqualTo: bookId)
          .get();
      if (snapshot.docs.isEmpty) {
        throw Exception("Record Not Found");
      } else {
        return snapshot.docs
            .map((e) => e.data() as Map<String, dynamic>)
            .toList();
      }
    } catch (error) {
      rethrow;
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<void> deleteAllocatedBook(String id, String bookId,
      String studentEmail, String message, BuildContext context) async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection("books")
          .doc(bookId)
          .get();
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

      await FirebaseFirestore.instance
          .collection("books")
          .doc(data["book_id"])
          .update({
        "remaining": data["remaining"] + 1,
      });
      DocumentSnapshot query = await FirebaseFirestore.instance
          .collection("allocate_books")
          .doc(id)
          .get();
      // for(QueryDocumentSnapshot doc in query.docs) {
      //   await doc.reference.delete();
      // }

      await query.reference.delete();
      if (context.mounted) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => const AdminDashboardScreen()),
            (route) => false);
        FlushMessage.successFlushMessage(context, message);
      }
    } catch (error) {
      print(error);
    }
  }

  Future<void> updateBook(BuildContext context, Map<String, dynamic> data,
      String name, String author, String genre) async {
    loading = true;
    notifyListeners();
    try {
      await FirebaseFirestore.instance
          .collection("books")
          .doc(data["book_id"])
          .update({
        "book_name": name,
        "book_author": author,
        "book_genre": genre,
      });
      if (context.mounted) {
        Navigator.pop(context);
        FlushMessage.successFlushMessage(context, "Book Updated Successfully");
      }
    } catch (err) {
      print(err);
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<void> deleteBook(
      Map<String, dynamic> data, BuildContext context) async {
    DocumentSnapshot bookSnapshot = await FirebaseFirestore.instance
        .collection("books")
        .doc(data["book_id"])
        .get();
    QuerySnapshot allocateBookSnapShot = await FirebaseFirestore.instance
        .collection("allocate_books")
        .where("bookId", isEqualTo: data["book_id"])
        .get();
    for (QueryDocumentSnapshot doc in allocateBookSnapShot.docs) {
      await doc.reference.delete();
    }
    await bookSnapshot.reference.delete();
    if (context.mounted) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const AdminDashboardScreen()),
          (route) => false);
      FlushMessage.successFlushMessage(context, "Book Deleted Successfully");
    }
  }

  Future<List<Map<String, dynamic>>> getStudentAllocatedBooks(
      BuildContext context) async {
    try {
      String studentEmail = FirebaseAuth.instance.currentUser!.email.toString();

      QuerySnapshot allocatedBooks = await FirebaseFirestore.instance
          .collection("allocate_books")
          .where("studentEmail", isEqualTo: studentEmail)
          .get();
      return allocatedBooks.docs
          .map((e) => e.data() as Map<String, dynamic>)
          .toList();
    } catch (error) {
      throw Exception(error.toString());
    }
  }

  Stream<List> pendingRequests() {
    return FirebaseFirestore.instance
        .collection("allocate_books")
        .where('status', isEqualTo: 'pending')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => doc.data()).toList();
    });
  }

  Future<void> approveRequest(
      String id, String status, BuildContext context) async {
    loading = true;
    notifyListeners();
    try {
      DocumentSnapshot<Map<String,dynamic>> data = await FirebaseFirestore.instance
          .collection("allocate_books")
          .doc(id).get();
      Map<String,dynamic> bookData = data.data() as Map<String,dynamic>;
      DocumentSnapshot book = await FirebaseFirestore.instance.collection("books").doc(bookData["bookId"]).get();
      Map<String,dynamic> bookInfo = book.data() as Map<String,dynamic>;

      int remaining = bookInfo["remaining"] ?? 0;

      await book.reference.update({
        "remaining": remaining - 1
      });
      await data.reference.update({
        "status": "approved"
      });
      if (context.mounted) {
        Navigator.pop(context);
        FlushMessage.successFlushMessage(context, "Request Approved");
      }
    } catch (err) {
      print(err);
    } finally {
      loading = false;
      notifyListeners();
    }
  }
  Stream<List<Map<String, dynamic>>> getRecommendedBooks(String genre, String viewedBookId) {
    return firestore.collection("books")
        .where("book_genre", isEqualTo: genre)
        .snapshots()
        .map((snapshot) {

      // Convert documents to a list of maps and filter out the currently viewed book
      List<Map<String, dynamic>> books = snapshot.docs
          .where((doc) => doc.id != viewedBookId) // Exclude the viewed book
          .map((doc) => doc.data())
          .toList();

      // Shuffle the list to randomize the order
      books.shuffle(Random());

      // Take the first 10 books from the shuffled list
      return books.take(10).toList();
    });
  }

}
