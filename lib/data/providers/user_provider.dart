// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe/data/models/ingredients.dart';
import 'package:recipe/data/models/user_model.dart';
import 'package:recipe/data/providers/dashboard_provider.dart';
import 'package:recipe/data/services/firebase_service.dart';
import 'package:recipe/ui/dashboard_view.dart';
import 'package:recipe/ui/sign_in.dart';

class UserProvider extends ChangeNotifier {
  UserModel? currentUser;
  final FirebaseService _firebaseService = FirebaseService();
  bool isLoading = false;
  bool isGoogleLoading = false;
  List<Recipe> sugestedRecipeList = [];
  List<Recipe> allRecipeList = [];
  List<Recipe> searchedRecipeList = [];
  TextEditingController searchController = TextEditingController();

  void setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  Future<void> checkAuthStatus(BuildContext context) async {
    try {
      final user = _firebaseService.currentUser;
      if (user != null) {
        currentUser = await _firebaseService.getCurrentUserData();
        _goToHomeView(context);
      } else {
        _goToSignInView(context);
      }
    } on Exception catch (_) {
      _goToSignInView(context);
    }
  }

  Future<void> logInWithGoogleUser() async {
    try {
      isGoogleLoading = true;
      notifyListeners();
      await _firebaseService.logInWithGoogleUser();

      isGoogleLoading = false;
      notifyListeners();
    } on Exception catch (_) {
      isGoogleLoading = false;
      notifyListeners();
    }
  }

  Future<void> logInSilently(BuildContext context) async {
    setLoading(true);
    final response = await _firebaseService.logInSilently();
    setLoading(false);
    if (response) {
      currentUser = await _firebaseService.getCurrentUserData();

      notifyListeners();
      _goToHomeView(context);
    }
  }

  void updatePromotions(bool value) {
    currentUser!.promotions = value;
    notifyListeners();
    // _authenticationsService.updateUser(currentUser!);
  }

  void _goToHomeView(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => const DashboardView()));
  }

  void _goToSignInView(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => const SignInView()));
  }

  Future<void> connectGoogle() async {
    // final user = await _authenticationsService.linkCurrentUserWithGoogle();
    // notifyListeners();
  }

  void logOut(BuildContext context) {
    _firebaseService.signOut();
    Provider.of<DashboardProvider>(context, listen: false).onItemTapped(2);
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const SignInView()),
      (route) => false,
    );
  }
}
