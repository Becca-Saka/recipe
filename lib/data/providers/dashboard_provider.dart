import 'package:flutter/material.dart';

class DashboardProvider extends ChangeNotifier {
  int selectedIndex = 2;
  void onItemTapped(int index) {
    selectedIndex = index;
    print(selectedIndex);
    notifyListeners();
  }
}
