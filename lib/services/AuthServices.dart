import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

class Authservices extends GetxService
{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Stream<User?> get authStateChanges => _auth.authStateChanges();
  Future<void> register(String email, String password, String fullName) async {
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    User? user = userCredential.user;
    print("User registered: ${user?.uid}");
    if(user != null) {
      await user.updateDisplayName(fullName);
      await _firestore.collection('users').doc(user.uid).set({
        'fullName': fullName,
        'email': email,
        'createdAt': FieldValue.serverTimestamp(),
      });
    }
  }

  Future<void> login(String email, String password) async {
    var response = await _auth.signInWithEmailAndPassword(email: email, password: password);
    print("Login successful: ${response}");
  }

  Future<void> logout() async {
    await _auth.signOut();
  }

  Future<bool> checkIsLogin() async {
    User? user = _auth.currentUser;
    if (user != null) {
      return true;
    } else {
      print("No user is currently logged in.");
      throw Exception("No user is currently logged in.");
    }
  }

  Future<Map<String, dynamic>> getProfileData() async {
    User? user = _auth.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc = await _firestore.collection('users').doc(user.uid).get();
      if (userDoc.exists) {
        return userDoc.data() as Map<String, dynamic>;
      } else {
        throw Exception("User data not found.");
      }
    } else {
      throw Exception("No user is currently logged in.");
    }
  }
}