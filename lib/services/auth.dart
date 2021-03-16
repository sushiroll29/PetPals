import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Stream<String> get onAuthStateChanged => _firebaseAuth.onAuthStateChanged.map(
        (FirebaseUser user) => user?.uid,
      );

  // GET UID
  // String getCurrentUID() {
  //   return _firebaseAuth.currentUser.uid;
  // }

  // GET CURRENT USER
  Future getCurrentUser() async {
    return _firebaseAuth.currentUser;
  }

  // Email & Password Sign Up
  Future<String> signUpWithEmailAndPassword(
      String email, String password) async {
    final authResult = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  // Email & Password Sign In
  Future<String> signInWithEmailAndPassword(
      String email, String password) async {
    return (await _firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password))
        .user
        .uid;
  }

  // Sign Out
  signOut() async {
    return await _firebaseAuth.signOut();
  }

  // Reset Password
  Future sendPasswordResetEmail(String email) async {
    return _firebaseAuth.sendPasswordResetEmail(email: email);
  }
}

class NameValidator {
  static String validate(String value) {
    if (value.isEmpty) {
      return "Name can't be empty";
    }
    if (value.length < 2) {
      return "Name must be at least 2 characters long";
    }
    if (value.length > 50) {
      return "Name must be less than 50 characters long";
    }
    return null;
  }
}

class EmailValidator {
  static String validate(String value) {
    if (value.isEmpty) {
      return "Email can't be empty";
    }
    return null;
  }
}

class PasswordValidator {
  static String validate(String value) {
    if (value.isEmpty) {
      return "Password can't be empty";
    }
    return null;
  }
}
