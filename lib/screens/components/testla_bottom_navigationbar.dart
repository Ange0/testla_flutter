import 'package:animation_testla_car/constanins.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

List<String> navigationIconsSrc = [
  "assets/icons/Lock.svg",
  "assets/icons/Charge.svg",
  "assets/icons/Temp.svg",
  "assets/icons/Tyre.svg"
];

class TestlaBottomNavigationBar extends StatelessWidget {
  const TestlaBottomNavigationBar({
    Key? key,
    required this.selectedTab,
    required this.onTap,
  }) : super(key: key);
  final int selectedTab;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedTab,
      onTap: onTap,
      backgroundColor: Colors.black,
      type: BottomNavigationBarType.fixed,
      items: List.generate(
        navigationIconsSrc.length,
        (index) => BottomNavigationBarItem(
            icon: SvgPicture.asset(
              navigationIconsSrc[index],
              color: index == selectedTab ? primaryColor : Colors.white54,
            ),
            label: ""),
      ),
    );
  }
}
