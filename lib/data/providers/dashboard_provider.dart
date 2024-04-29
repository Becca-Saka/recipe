import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe/data/models/ingredients.dart';
import 'package:recipe/data/providers/recipe_provider.dart';
import 'package:recipe/data/services/firebase_service.dart';

class DashboardProvider extends ChangeNotifier {
  final FirebaseService _firebaseService = FirebaseService();
  TextEditingController searchController = TextEditingController();
  int selectedIndex = 2;
  bool isLoading = false;
  bool isGoogleLoading = false;
  List<Recipe> sugestedRecipeList = [];
  List<Recipe> allRecipeList = [];
  List<Recipe> searchedRecipeList = [];
  void onItemTapped(int index) {
    selectedIndex = index;
    if (index == 0) {
      getAllRecipes();
    } else if (index == 2) {
      getUserRecipes();
    }
    notifyListeners();
  }

  void setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  Future<void> getUserRecipes() async {
    setLoading(true);
    sugestedRecipeList = await _firebaseService.getUserRecipeData();

    setLoading(false);
  }

  Future<void> getAllRecipes() async {
    setLoading(true);
    allRecipeList = await _firebaseService.getAllRecipeData();
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
}
