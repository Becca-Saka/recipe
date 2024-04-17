// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe/data/models/ingredients.dart';
import 'package:recipe/data/models/user_model.dart';
import 'package:recipe/data/providers/recipe_provider.dart';
import 'package:recipe/data/services/authentication_service.dart';
import 'package:recipe/ui/dashboard_view.dart';
import 'package:recipe/ui/sign_in.dart';

class UserProvider extends ChangeNotifier {
  UserModel? currentUser;
  final AuthenticationsService _authenticationsService =
      AuthenticationsService();
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
      final user = _authenticationsService.currentUser;
      if (user != null) {
        currentUser = await _authenticationsService.getCurrentUserData();
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
      await _authenticationsService.logInWithGoogleUser();

      isGoogleLoading = false;
      notifyListeners();
    } on Exception catch (_) {
      isGoogleLoading = false;
      notifyListeners();
    }
  }

  Future<void> logInSilently(BuildContext context) async {
    setLoading(true);
    final response = await _authenticationsService.logInSilently();
    setLoading(false);
    if (response) {
      currentUser = await _authenticationsService.getCurrentUserData();

      notifyListeners();
      _goToHomeView(context);
    }
  }

  Future<void> getUserRecipes(BuildContext context) async {
    setLoading(true);
    sugestedRecipeList = await _authenticationsService.getUserRecipeData();
    setLoading(false);
  }

  Future<void> getAllRecipes(BuildContext context) async {
    setLoading(true);
    allRecipeList = await _authenticationsService.getAllRecipeData();
    setLoading(false);
    searchController.addListener(() => searchRecipes(searchController.text));
  }

  Future<void> searchRecipes(String searchText) async {
    if (searchText.isEmpty) {
      searchedRecipeList = allRecipeList;
      return;
    }
    searchedRecipeList = allRecipeList
        .where(
          (element) =>
              element.name.toLowerCase().contains(searchText.toLowerCase()) ||
              element.ingredients.any(
                (ingredient) => ingredient.name
                    .toLowerCase()
                    .contains(searchText.toLowerCase()),
              ),
        )
        .toList();
    notifyListeners();
  }

  void viewRecipeDetails(Recipe recipe, BuildContext context) {
    Provider.of<RecipeProvider>(context, listen: false)
        .viewRecipeDetails(recipe, context);
  }

  void _goToHomeView(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => const DashboardView()));
  }

  void _goToSignInView(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => const SignInView()));
  }
}
