import 'package:animation_testla_car/constanins.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TempBtn extends StatelessWidget {
  const TempBtn(
      {Key? key,
      required this.svgSrc,
      required this.title,
      this.isActive = false,
      this.activeColor = primaryColor,
      required this.press})
      : super(key: key);

  final String svgSrc, title;
  final bool isActive;
  final Color activeColor;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Column(
        children: [
          AnimatedContainer(
            duration: const Duration(microseconds: 200),
            curve: Curves.easeInOutBack,
            height: isActive ? 76 : 50,
            width: isActive ? 76 : 50,
            child: SvgPicture.asset(
              svgSrc,
              color: isActive ? activeColor : Colors.white38,
            ),
          ),
          const SizedBox(
            height: defaultPadding / 2,
          ),
          AnimatedDefaultTextStyle(
            duration: Duration(microseconds: 200),
            style: TextStyle(
                color: isActive ? activeColor : Colors.white38,
                fontSize: 16,
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal),
            child: Text(
              title.toUpperCase(),
            ),
          )
        ],
      ),
    );
  }
}
