import 'package:animation_testla_car/constanins.dart';
import 'package:animation_testla_car/home_controller.dart';
import 'package:animation_testla_car/screens/components/battery_status.dart';
import 'package:animation_testla_car/screens/components/door_lock.dart';
import 'package:animation_testla_car/screens/components/temp_details.dart';
import 'package:animation_testla_car/screens/components/testla_bottom_navigationbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final HomeController _controller = HomeController();

  late AnimationController _batteryAnimationController;
  late Animation<double> _animationBattery;
  late Animation<double> _animationBatteryStatus;

  late AnimationController _tempAnimationController;
  late Animation<double> _animationCarShift;
  late Animation<double> _animationTempShowInfos;
  late Animation<double> _animationCoolGlow;
  void setupBatteryAnimation() {
    _batteryAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _animationBattery = CurvedAnimation(
      parent: _batteryAnimationController,
//cette animation commence à O et se termine à moitié après 300 millisecondes car la moitier de 1 est 0.5 donc la moitier de 600 est 300 donc 300 ms pour le retard et 300 ms pour l'animation proprement dit
      curve: const Interval(0.0, 0.5),
    );
    _animationBatteryStatus = CurvedAnimation(
      parent: _batteryAnimationController,
      curve: const Interval(0.6, 1),
    );
  }

  void setupTempAnimation() {
    _tempAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _animationCarShift = CurvedAnimation(
      parent: _tempAnimationController,
      curve: const Interval(0.2, 0.4),
    );
    _animationTempShowInfos = CurvedAnimation(
      parent: _tempAnimationController,
      curve: const Interval(0.45, 0.65),
    );
    _animationCoolGlow = CurvedAnimation(
      parent: _tempAnimationController,
      curve: const Interval(0.7, 1),
    );
  }

  @override
  void initState() {
    setupBatteryAnimation();
    setupTempAnimation();
    super.initState();
  }

  @override
  void dispose() {
    _batteryAnimationController.dispose();
    _tempAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: Listenable.merge([
          _controller,
          _batteryAnimationController,
          _tempAnimationController
        ]),
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
                      SizedBox(
                        width: constrains.maxWidth,
                        height: constrains.maxHeight,
                      ),
                      Positioned(
                        width: constrains.maxWidth,
                        height: constrains.maxHeight,
                        left:
                            constrains.maxWidth / 2 * _animationCarShift.value,
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
                      // Battery
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
                      // Temp
                      Positioned(
                        right: -180 * (1 - _animationCoolGlow.value),
                        child: _controller.isCoolSeleted
                            ? Image.asset("assets/images/Cool_glow_2.png")
                            : Image.asset("assets/images/Hot_glow_4.png"),
                      ),
                      Positioned(
                        top: 60 * (1 - _animationTempShowInfos.value),
                        width: constrains.maxWidth,
                        height: constrains.maxHeight,
                        child: Opacity(
                          opacity: _animationTempShowInfos.value,
                          child: TempDetails(controller: _controller),
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
                if (index == 2) {
                  _tempAnimationController.forward(from: 0.1);
                } else {
                  _tempAnimationController.reverse();
                }
                _controller.onBottomNavigationTabChange(index);
              },
              selectedTab: _controller.selectedBottomTab,
            ),
          );
        });
  }
}
