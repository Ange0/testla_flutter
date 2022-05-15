import 'package:animation_testla_car/constanins.dart';
import 'package:animation_testla_car/home_controller.dart';
import 'package:animation_testla_car/models/TyrePsi.dart';
import 'package:animation_testla_car/screens/components/battery_status.dart';
import 'package:animation_testla_car/screens/components/door_lock.dart';
import 'package:animation_testla_car/screens/components/temp_details.dart';
import 'package:animation_testla_car/screens/components/testla_bottom_navigationbar.dart';
import 'package:animation_testla_car/screens/components/tyre_psi_card.dart';
import 'package:animation_testla_car/screens/components/tyres.dart';
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

  late AnimationController _tyreAnimationController;
  // chaque info de chaque  pneu aura son animation
  late Animation<double> _animationTyre1Psi;
  late Animation<double> _animationTyre2Psi;
  late Animation<double> _animationTyre3Psi;
  late Animation<double> _animationTyre4Psi;
  late List<Animation<double>> _tyreAnimation;

  void setupBatteryAnimation() {
    _batteryAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
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
      duration: const Duration(milliseconds: 600),
    );
    _animationCarShift = CurvedAnimation(
      parent: _tempAnimationController,
      curve: const Interval(0.4, 0.8),
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

  void setupTyreAnimation() {
    _tyreAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 1000, // 1200
      ),
    );
    // cette animation commence avec un retard de 1200 * 0.34 = 408 ms et se termine en  (1200 * 0.5) - 400 = (600 - 408) = 192 ms
    _animationTyre1Psi = CurvedAnimation(
      parent: _tyreAnimationController,
      curve: const Interval(0.0, 0.5),
    );
    // cette animation commence avec un retard de 1200 * 0.5 = 600ms et se termine en  (1200 * 0.66 - 600) = (792 - 600) = 192 ms
    _animationTyre2Psi = CurvedAnimation(
      parent: _tyreAnimationController,
      curve: const Interval(0.5, 0.66),
    );
    // cette animation commence avec un retard de 1200 * 0.66 = 792ms et se termine en  (1200 * 0.82 - 792) = (984 - 792) = 192 ms
    _animationTyre3Psi = CurvedAnimation(
      parent: _tyreAnimationController,
      curve: const Interval(0.66, 0.82),
    );
    // cette animation commence avec un retard de 1200 * 0.82 = 984ms et se termine en  (1200 * 1 - 984) = (1200 - 984) = 216 ms
    _animationTyre4Psi = CurvedAnimation(
      parent: _tyreAnimationController,
      curve: const Interval(0.82, 1),
    );
  }

  @override
  void initState() {
    setupBatteryAnimation();
    setupTempAnimation();
    setupTyreAnimation();
    _tyreAnimation = [
      _animationTyre1Psi,
      _animationTyre2Psi,
      _animationTyre3Psi,
      _animationTyre4Psi
    ];
    super.initState();
  }

  @override
  void dispose() {
    _batteryAnimationController.dispose();
    _tempAnimationController.dispose();
    _tyreAnimationController.dispose();
    _tyreAnimation = [
      _animationTyre1Psi,
      _animationTyre2Psi,
      _animationTyre3Psi,
      _animationTyre4Psi
    ];
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: Listenable.merge([
          _controller,
          _batteryAnimationController,
          _tempAnimationController,
          _tyreAnimationController
        ]),
        builder: (context, snapshot) {
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
                      // Temp
                      Positioned(
                        right: -180 * (1 - _animationCoolGlow.value),
                        child: AnimatedSwitcher(
                          duration: defaultDuration,
                          child: _controller.isCoolSeleted
                              ? Image.asset(
                                  "assets/images/Cool_glow_2.png",
                                  key: UniqueKey(),
                                )
                              : Image.asset(
                                  "assets/images/Hot_glow_4.png",
                                  key: UniqueKey(),
                                ),
                        ),
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
                      ...[
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
                              ? constrains.maxWidth * 0.2
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
                      ],
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
                      // Tyre
                      if (_controller.isShowTyres) ...tyres(constrains),
                      if (_controller.isShowTyresSatus)
                        GridView.builder(
                          itemCount: 4,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: defaultPadding,
                            crossAxisSpacing: defaultPadding,
                            childAspectRatio:
                                constrains.maxWidth / constrains.maxHeight,
                          ),
                          itemBuilder: (context, index) => ScaleTransition(
                            scale: _tyreAnimation[index],
                            child: TyrePsiCard(
                              isBottomTwoTyre: index > 1,
                              tyrePsi: demoPsiList[index],
                            ),
                          ),
                        )
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
                if (_controller.selectedBottomTab != 2 && index == 2) {
                  _tempAnimationController.forward(from: 0.1);
                } else {
                  _tempAnimationController.reverse();
                }
                if (index == 3)
                  _tyreAnimationController.forward();
                else {
                  _tyreAnimationController.reverse();
                }
                _controller.showTyresController(index);
                _controller.tyreStatusController(index);
                _controller.onBottomNavigationTabChange(index);
              },
              selectedTab: _controller.selectedBottomTab,
            ),
          );
        });
  }
}
