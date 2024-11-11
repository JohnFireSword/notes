import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:notes_app/models/auth_data.dart';
import 'package:http/http.dart' as http;
import 'package:notes_app/models/network_data.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final _storage = const FlutterSecureStorage();

  Future<AuthData> authenticate(String email,String password)async{
    var url = Uri.https('');
    final response = await http.post(url,body:{
      'email' : email,
      'password': password,
    });

     if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['result'] == 'success') {
        await _storage.write(
            key: D.loggedInUserid, value: data['userId'].toString());
        await _storage.write(
            key: D.loggedInToken, value: data['token'].toString());
        return AuthData.fromJson(data);
      } else {
        return AuthData.empty();
      }
    } else {
      return AuthData.networkError();
    }
  }

   Future<String?> getToken() async {
    return await _storage.read(key: D.loggedInToken);
  }

  Future<void> removeToken() async {
    await _storage.delete(key: D.loggedInToken);
  }

  Future<void> removeUserID() async {
    await _storage.delete(key: D.loggedInUserid);
  }



  // Sign in with Google
  Future<User?> signInWithGoogle() async {
    try {
      // Trigger the Google Authentication flow
      final GoogleSignInAccount? gUser = await _googleSignIn.signIn();
      if (gUser == null) return null; // User cancelled the sign-in

      // Obtain the auth details from the request
      final GoogleSignInAuthentication gAuth = await gUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      );

      // This token can be used to authenticate with Firebase
      UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      return userCredential.user;
    } catch (error) {
      print("Error signing in with Google: $error");
      return null; // Handle errors as needed
    }
  }

  // Sign out
  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }
}
