import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:recipe/data/exceptions/auth_exception.dart';
import 'package:recipe/data/models/ingredients.dart';
import 'package:recipe/data/models/user_model.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final _googleSignIn = GoogleSignIn(scopes: ['email']);

  User? get currentUser => _auth.currentUser;
  Future<bool> saveUserDetails(UserCredential crediential) async {
    final user = crediential.additionalUserInfo?.profile;
    final uid = crediential.user!.uid;
    final email = user?['email'];
    final name = user?['name'];
    final image = user?['picture'];

    await currentUser?.updateDisplayName(name);
    await currentUser?.updatePhotoURL(image);
    await currentUser?.reload();
    try {
      await _firestore.collection('users').doc(uid).set({
        'uid': uid,
        'email': email,
        'name': name,
        if (image != null) 'imageUrl': image,
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

  Stream<DocumentSnapshot<UserModel>> listenToCurrentUserData() {
    try {
      return _firestore
          .collection('users')
          .withConverter(
            fromFirestore: (snapshot, _) => UserModel.fromMap(snapshot.data()!),
            toFirestore: (user, _) => user.toMap(),
          )
          .doc(_auth.currentUser!.uid)
          .snapshots();
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

  Future<bool> linkCurrentUserWithGoogle() async {
    try {
      await _googleSignIn.signOut();
      final googleAccount = await _googleSignIn.signIn();
      if (googleAccount != null) {
        final auth = await googleAccount.authentication;
        final googleAuthAccessToken = auth.accessToken;
        final authCredential = GoogleAuthProvider.credential(
            accessToken: googleAuthAccessToken, idToken: auth.idToken);
        final userCredienditial =
            await _auth.currentUser!.linkWithCredential(authCredential);

        await saveUserDetails(userCredienditial);
        await _auth.currentUser?.reload();
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

  CreatorModel get _creatorModel => CreatorModel(
        id: currentUser!.uid,
        name: currentUser?.displayName ?? 'Guest',
        imageUrl: currentUser?.photoURL,
      );

  Future<Recipe> saveUserRecipeData(Recipe recipe) async {
    final uid = currentUser!.uid;
    // final uid = currentUser!.uid;

    try {
      final collection = _firestore.collection('Recipes');
      final doc = collection.doc(recipe.id);
      recipe.id = doc.id;
      if (recipe.creators.isNotEmpty &&
          recipe.creators.any((element) => element.id == uid)) {
        recipe.creators.removeWhere((element) => element.id == uid);
      } else {
        recipe.creators.add(_creatorModel);
        await _firestore.collection('users').doc(uid).update({
          'recipes': FieldValue.arrayUnion([
            {
              'id': recipe.id,
              'dateSuggested': Timestamp.now(),
            }
          ])
        });
      }

      await doc.set(
        recipe.toJson(),
        SetOptions(merge: true),
      );

      return recipe;
    } on Exception catch (e, s) {
      debugPrint('$e\n$s');
      rethrow;
    }
  }

  Future<List<Recipe>> getUserRecipeData() async {
    try {
      final result = await _firestore
          .collection('Recipes')
          .where('creators', arrayContains: _creatorModel.toJson())
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

  Future<bool> updateUser(UserModel userModel) async {
    try {
      await _firestore
          .collection('users')
          .doc(userModel.uid)
          .set(userModel.toMap(), SetOptions(merge: true));

      return true;
    } on FirebaseAuthException catch (e) {
      final message = AuthExceptionHandler.handleFirebaseAuthException(e);
      throw AuthException(message);
    } on Exception catch (e, s) {
      debugPrint('$e\n$s');
      rethrow;
    }
  }
}
