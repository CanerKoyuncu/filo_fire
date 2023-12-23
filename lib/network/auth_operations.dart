import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthOperations {
  late FirebaseAuth _firebaseAuth;
  late User user;
  AuthOperations() {
    this._firebaseAuth = FirebaseAuth.instance;
  }

  Future isLoggedIn() async {
    this.user = await _firebaseAuth.currentUser!;
    if (this.user == null) {
      return false;
    }
    return true;
  }

  // Kullanıcı kaydı
  Future<String?> signUp(String email, String password) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return null; // Başarılı kayıt, hata yok
    } on FirebaseAuthException catch (e) {
      return e.message; // Hata mesajını döndür
    }
  }

  // Kullanıcı girişi
  void signIn(BuildContext context, String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      Navigator.pushNamedAndRemoveUntil(
        context,
        "/tabView",
        ModalRoute.withName("/tabView"),
      );

      // Başarılı giriş, hata yok
    } on FirebaseAuthException catch (e) {
      print(e.message); // Hata mesajını döndür
    }
  }

  // Şifre sıfırlama
  Future<String?> resetPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      return null; // Başarılı şifre sıfırlama, hata yok
    } on FirebaseAuthException catch (e) {
      return e.message; // Hata mesajını döndür
    }
  }

  // Kullanıcı çıkışı
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  // Şu anki oturum açmış kullanıcıyı al
  User? getCurrentUser() {
    return _firebaseAuth.currentUser;
  }
}
