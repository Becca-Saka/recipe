import 'package:flutter/material.dart';
import 'package:recipe/shared/app_colors.dart';
import 'package:recipe/ui/collect_ingredient_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      floatingActionButton: FloatingActionButton(onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const CollectIngredientView()),
        );
      }),
    );
  }
}
