import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe/data/models/ingredients.dart';
import 'package:recipe/data/models/user_model.dart';
import 'package:recipe/data/providers/recipe_provider.dart';
import 'package:recipe/data/services/authentication_service.dart';
import 'package:recipe/ui/home_view.dart';
import 'package:recipe/ui/sign_in.dart';

class UserProvider extends ChangeNotifier {
  UserModel? currentUser;
  final AuthenticationsService _authenticationsService =
      AuthenticationsService();
  bool isLoading = false;
  List<Recipe> sugestedRecipeList = [];
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
    } on Exception catch (e) {
      _goToSignInView(context);
    }
  }

  Future<void> logInWithGoogleUser() async {
    setLoading(true);
    await _authenticationsService.logInWithGoogleUser();
    setLoading(false);
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

  Future<void> getRecipes(BuildContext context) async {
    setLoading(true);
    sugestedRecipeList = await _authenticationsService.getUserRecipeData();
    setLoading(false);
  }

  void viewRecipeDetails(Recipe recipe, BuildContext context) {
    Provider.of<RecipeProvider>(context, listen: false)
        .viewRecipeDetails(recipe, context);
  }

  void _goToHomeView(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => const HomeView()));
  }

  void _goToSignInView(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => const SignInView()));
  }
}
