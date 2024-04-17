import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:recipe/data/exceptions/auth_exception.dart';
import 'package:recipe/data/models/ingredients.dart';
import 'package:recipe/data/models/user_model.dart';

class AuthenticationsService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final _googleSignIn = GoogleSignIn(scopes: ['email']);

  User? get currentUser => _auth.currentUser;
  Future<bool> saveUserDetails(UserCredential crediential) async {
    final user = crediential.user!;
    final email = user.email;
    final uid = user.uid;
    final name = user.displayName;
    try {
      await _firestore.collection('users').doc(uid).set({
        'uid': uid,
        'email': email,
        'name': name,
      });

      return true;
    } on FirebaseAuthException catch (e) {
      final message = AuthExceptionHandler.handleFirebaseAuthException(e);
      throw AuthException(message);
    } on Exception catch (e, s) {
      debugPrint('$e\n$s');
      rethrow;
    }
  }

  Future<UserModel> getCurrentUserData() async {
    try {
      print(_auth.currentUser!.uid);
      final response = await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .get();
      if (response.data() != null) {
        return UserModel.fromMap(response.data()!);
      }
      throw AuthException('User not found');
    } on FirebaseAuthException catch (e) {
      final message = AuthExceptionHandler.handleFirebaseAuthException(e);
      throw AuthException(message);
    } on Exception catch (e, s) {
      debugPrint('$e\n$s');
      rethrow;
    }
  }

  Future<bool> logInWithGoogleUser() async {
    try {
      await signOut();
      final googleAccount = await _googleSignIn.signIn();
      if (googleAccount != null) {
        final auth = await googleAccount.authentication;
        final googleAuthAccessToken = auth.accessToken;
        final authCredential = GoogleAuthProvider.credential(
            accessToken: googleAuthAccessToken, idToken: auth.idToken);
        final userCredienditial =
            await FirebaseAuth.instance.signInWithCredential(authCredential);
        await saveUserDetails(userCredienditial);
        return true;
      }
      throw AuthException('Error signing in with Google');
    } on FirebaseAuthException catch (e) {
      final message = AuthExceptionHandler.handleFirebaseAuthException(e);
      debugPrint('$message');
      throw AuthException(message);
    } on Exception catch (e, s) {
      debugPrint('$e\n$s');
      rethrow;
    }
  }

  Future<bool> logInSilently() async {
    try {
      await signOut();
      final crediential = await FirebaseAuth.instance.signInAnonymously();
      print(crediential);
      await saveUserDetails(crediential);
      return true;
    } on FirebaseAuthException catch (e) {
      // debugPrint('${e.message}');
      final message = AuthExceptionHandler.handleFirebaseAuthException(e);
      debugPrint('$message');
      throw AuthException(message);
    } on Exception catch (e, s) {
      debugPrint('$e\n$s');
      rethrow;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<void> saveUserRecipeData(List<Recipe> recipes) async {
    final uid = currentUser!.uid;

    try {
      for (var recipe in recipes) {
        final doc = _firestore.collection('Recipes').doc();
        await doc.set(
          {
            'id': doc.id,
            'creatorId': uid,
            'creatorName': currentUser!.displayName,
            'dateSuggested': Timestamp.now(),
            ...recipe.toJson(),
          },
        );
      }
    } on Exception catch (e, s) {
      debugPrint('$e\n$s');
      rethrow;
    }
  }

  Future<List<Recipe>> getUserRecipeData() async {
    final uid = _auth.currentUser!.uid;

    try {
      final result = await _firestore
          .collection('Recipes')
          .where('userId', isEqualTo: uid)
          .get();
      if (result.docs.isNotEmpty) {
        return result.docs.map((e) => Recipe.fromJson(e.data())).toList();
      }
    } on Exception catch (e, s) {
      debugPrint('$e\n$s');
      rethrow;
    }
    return [];
  }

  Future<List<Recipe>> getAllRecipeData() async {
    try {
      final result = await _firestore.collection('Recipes').get();
      if (result.docs.isNotEmpty) {
        return result.docs.map((e) => Recipe.fromJson(e.data())).toList();
      }
    } on Exception catch (e, s) {
      debugPrint('$e\n$s');
      rethrow;
    }
    return [];
  }
}
