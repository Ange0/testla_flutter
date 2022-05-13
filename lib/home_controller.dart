import 'package:flutter/cupertino.dart';

class HomeController extends ChangeNotifier {
  bool isRightDoorLock = true;
  bool isLeftDoorLock = true;
  bool isBonnetDoorLock = true;
  bool isTrunkDoorLock = true;

  int selectedBottomTab = 0;

  bool isCoolSeleted = true;

  void updateRightDoorLock() {
    isRightDoorLock = !isRightDoorLock;
    notifyListeners();
  }

  void updateLeftDoorLock() {
    isLeftDoorLock = !isLeftDoorLock;
    notifyListeners();
  }

  void updateBonnetDoorLock() {
    isBonnetDoorLock = !isBonnetDoorLock;
    notifyListeners();
  }

  void updateTrunkDoorLock() {
    isTrunkDoorLock = !isTrunkDoorLock;
    notifyListeners();
  }

  void onBottomNavigationTabChange(index) {
    selectedBottomTab = index;
    notifyListeners();
  }

  void updateCoolSelectedTab() {
    isCoolSeleted = !isCoolSeleted;
    notifyListeners();
  }
}
