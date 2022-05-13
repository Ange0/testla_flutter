import 'package:animation_testla_car/constanins.dart';
import 'package:animation_testla_car/home_controller.dart';
import 'package:animation_testla_car/screens/components/battery_status.dart';
import 'package:animation_testla_car/screens/components/door_lock.dart';
import 'package:animation_testla_car/screens/components/testla_bottom_navigationbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final HomeController _controller = HomeController();
  late AnimationController _batteryAnimationController;
  late Animation<double> _animationBattery;
  late Animation<double> _animationBatteryStatus;

  void setupBatteryAnimation() {
    _batteryAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(microseconds: 10000),
    );

    _animationBattery = CurvedAnimation(
      parent: _batteryAnimationController,
//cette animation commence à O et se termine à moitié après 300 millisecondes car la moitier de 1 est 0.5 donc la moitier de 600 est 300 donc 300 ms pour le retard et 300 ms pour l'animation proprement dit
      curve: const Interval(0.0, 0.5),
    );
    _animationBatteryStatus = CurvedAnimation(
      parent: _batteryAnimationController,
      curve: const Interval(0.8, 1),
    );
  }

  @override
  void initState() {
    setupBatteryAnimation();
    super.initState();
  }

  @override
  void dispose() {
    _batteryAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: Listenable.merge([_controller, _batteryAnimationController]),
        builder: (context, snapshot) {
          print('ee');
          print(_animationBattery.value);
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
                      AnimatedPositioned(
                        duration: defaultDuration,
                        right: _controller.selectedBottomTab == 0
                            ? constrains.maxWidth * 0.05
                            : constrains.maxWidth / 2,
                        child: AnimatedOpacity(
                          duration: defaultDuration,
                          opacity: _controller.selectedBottomTab == 0 ? 1 : 0,
                          child: DoorLock(
                            press: _controller.updateRightDoorLock,
                            isLock: _controller.isRightDoorLock,
                          ),
                        ),
                      ),
                      AnimatedPositioned(
                        duration: defaultDuration,
                        left: _controller.selectedBottomTab == 0
                            ? constrains.maxWidth * 0.05
                            : constrains.maxWidth / 2,
                        child: AnimatedOpacity(
                          duration: defaultDuration,
                          opacity: _controller.selectedBottomTab == 0 ? 1 : 0,
                          child: DoorLock(
                            press: _controller.updateLeftDoorLock,
                            isLock: _controller.isLeftDoorLock,
                          ),
                        ),
                      ),
                      AnimatedPositioned(
                        duration: defaultDuration,
                        top: _controller.selectedBottomTab == 0
                            ? constrains.maxWidth * 0.20
                            : constrains.maxWidth / 2,
                        child: AnimatedOpacity(
                          duration: defaultDuration,
                          opacity: _controller.selectedBottomTab == 0 ? 1 : 0,
                          child: DoorLock(
                            press: _controller.updateBonnetDoorLock,
                            isLock: _controller.isBonnetDoorLock,
                          ),
                        ),
                      ),
                      AnimatedPositioned(
                        duration: defaultDuration,
                        bottom: _controller.selectedBottomTab == 0
                            ? constrains.maxWidth * 0.28
                            : constrains.maxWidth / 2,
                        child: AnimatedOpacity(
                          duration: defaultDuration,
                          opacity: _controller.selectedBottomTab == 0 ? 1 : 0,
                          child: DoorLock(
                            press: _controller.updateTrunkDoorLock,
                            isLock: _controller.isTrunkDoorLock,
                          ),
                        ),
                      ),
                      Opacity(
                        opacity: _animationBattery.value,
                        child: SvgPicture.asset(
                          "assets/icons/Battery.svg",
                          width: constrains.maxWidth * 0.4,
                        ),
                      ),
                      Positioned(
                        top: 50 * (1 - _animationBatteryStatus.value),
                        height: constrains.maxHeight,
                        width: constrains.maxWidth,
                        child: Opacity(
                          opacity: _animationBattery.value,
                          child: BatteryStatus(
                            constrains: constrains,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            bottomNavigationBar: TestlaBottomNavigationBar(
              onTap: (index) {
                if (index == 1) {
                  _batteryAnimationController.forward();
                } else if (_controller.selectedBottomTab == 1 && index != 1) {
                  _batteryAnimationController.reverse(from: 0.7);
                }
                _controller.onBottomNavigationTabChange(index);
              },
              selectedTab: _controller.selectedBottomTab,
            ),
          );
        });
  }
}
