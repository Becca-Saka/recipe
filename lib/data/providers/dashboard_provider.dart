import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:recipe/data/models/ingredients.dart';
import 'package:recipe/data/providers/recipe_provider.dart';
import 'package:recipe/data/services/firebase_service.dart';
import 'package:recipe/data/services/search_engine_key.dart';

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
    notifyListeners();
  }

  void setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  Future<void> getUserRecipes(BuildContext context) async {
    setLoading(true);
    sugestedRecipeList = await _firebaseService.getUserRecipeData();
    print(sugestedRecipeList);
    setLoading(false);
  }

  Future<void> getAllRecipes(BuildContext context) async {
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

  Future<void> searchImage() async {
    String query = 'rice grain';
    String baseUrl = 'https://api.pexels.com/v1/search?query=$query';

    // Assemble the URL used for the REST API request.
    // final String url = '$baseUrl?q=$query&cx=$cx&key=$apiKey';
    StreamedResponse response;
    try {
      final req = Request('GET', Uri.parse(baseUrl));
      req.headers.addAll({
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': pexelsAPI
      });

      response = await req.send();
    } catch (e) {
      throw Exception('Search failed with exception, $e');
    }

    // A 200 status means the search was successful
    if (response.statusCode == 200) {
      var body = json.decode(await response.stream.bytesToString());
      // body = (body['items'] as List);

      log(body.toString());
      // body = (body['items'] as List)
      //     .map((e) => e['pagemap']['cse_image'])
      //     .toList();
      // log(body.toString());
    }
    // Throw an exception for unsuccessful requests
    else {
      throw Exception(
        'Failed to load search results with status, ${response.statusCode}, and message, ${response.reasonPhrase}',
      );
    }
  }
}
