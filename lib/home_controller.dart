import 'package:flutter/cupertino.dart';

class HomeController extends ChangeNotifier {
  bool isRightDoorLock = true;
  bool isLeftDoorLock = true;
  bool isBonnetDoorLock = true;
  bool isTrunkDoorLock = true;

  int selectedBottomTab = 0;

  bool isCoolSeleted = true;
  int degreeTemp = 16;

  bool isShowTyres = false;
  bool isShowTyresSatus = false;
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

  void increaseTemp() {
    degreeTemp++;
    notifyListeners();
  }

  void decreaseTemp() {
    if (degreeTemp > 16) {
      degreeTemp--;
      notifyListeners();
    }
  }

  void showTyresController(int index) {
    if (index == 3) {
      Future.delayed(const Duration(milliseconds: 400), () {
        isShowTyres = true;
        notifyListeners();
      });
    } else {
      isShowTyres = false;
      notifyListeners();
    }
  }

  void tyreStatusController(index) {
    if (index == 3) {
      isShowTyresSatus = true;
    } else {
      isShowTyresSatus = false;
    }
    notifyListeners();
  }
}
