import 'package:animation_testla_car/constanins.dart';
import 'package:animation_testla_car/home_controller.dart';
import 'package:animation_testla_car/screens/components/door_lock.dart';
import 'package:animation_testla_car/screens/components/testla_bottom_navigationbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  final HomeController _controller = HomeController();
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _controller,
        builder: (context, snapshot) {
          return Scaffold(
            body: SafeArea(
              child: LayoutBuilder(
                builder: (context, constrains) {
                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      Positioned(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: constrains.maxHeight * 0.1),
                          child: SvgPicture.asset(
                            "assets/icons/Car.svg",
                            width: double.infinity,
                          ),
                        ),
                      ),
                      Positioned(
                        right: constrains.maxWidth * 0.05,
                        child: DoorLock(
                          press: _controller.updateRightDoorLock,
                          isLock: _controller.isRightDoorLock,
                        ),
                      ),
                      Positioned(
                        left: constrains.maxWidth * 0.05,
                        child: DoorLock(
                          press: _controller.updateLeftDoorLock,
                          isLock: _controller.isLeftDoorLock,
                        ),
                      ),
                      Positioned(
                        top: constrains.maxWidth * 0.20,
                        child: DoorLock(
                          press: _controller.updateBonnetDoorLock,
                          isLock: _controller.isBonnetDoorLock,
                        ),
                      ),
                      Positioned(
                        bottom: constrains.maxWidth * 0.28,
                        child: DoorLock(
                          press: _controller.updateTrunkDoorLock,
                          isLock: _controller.isTrunkDoorLock,
                        ),
                      )
                    ],
                  );
                },
              ),
            ),
            bottomNavigationBar: TestlaBottomNavigationBar(
              onTap: (index) {},
              selectedTab: 1,
            ),
          );
        });
  }
}
