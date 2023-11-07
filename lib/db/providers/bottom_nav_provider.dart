import 'package:flutter/Material.dart';

class BottomNavigationBarProvider extends ChangeNotifier {
  int selectedIndex = 0;

  void onItemTapped(int index) {
    selectedIndex = index;
    notifyListeners();
  }
}
