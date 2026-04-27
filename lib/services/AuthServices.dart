import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

class Authservices extends GetxService
{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Stream<User?> get authStateChanges => _auth.authStateChanges();
  Future<void> register(String email, String password) async {
    await _auth.createUserWithEmailAndPassword(email: email, password: password);
  }

  Future<void> login(String email, String password) async {
    var response = await _auth.signInWithEmailAndPassword(email: email, password: password);
    print("Login successful: ${response}");
  }

  Future<void> logout() async {
    await _auth.signOut();
  }
}