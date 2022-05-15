import 'package:animation_testla_car/constanins.dart';
import 'package:animation_testla_car/home_controller.dart';
import 'package:animation_testla_car/screens/components/temp_btn.dart';
import 'package:flutter/material.dart';

class TempDetails extends StatelessWidget {
  const TempDetails({
    Key? key,
    required HomeController controller,
  })  : _controller = controller,
        super(key: key);

  final HomeController _controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              TempBtn(
                isActive: _controller.isCoolSeleted,
                svgSrc: "assets/icons/coolShape.svg",
                title: "Cool",
                press: () {
                  _controller.updateCoolSelectedTab();
                },
              ),
              const SizedBox(
                width: defaultPadding,
              ),
              TempBtn(
                isActive: !_controller.isCoolSeleted,
                svgSrc: "assets/icons/heatShape.svg",
                title: "Heat",
                activeColor: redColor,
                press: () {
                  _controller.updateCoolSelectedTab();
                },
              ),
            ],
          ),
          const SizedBox(
            height: 40,
          ),
          Column(
            children: [
              IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  _controller.increaseTemp();
                },
                icon: const Icon(
                  Icons.arrow_drop_up,
                  size: 48,
                  color: Colors.white,
                ),
              ),
              Text(
                "${_controller.degreeTemp}" "\u2103",
                style: const TextStyle(fontSize: 88, color: Colors.white),
              ),
              IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  _controller.decreaseTemp();
                },
                icon: const Icon(
                  Icons.arrow_drop_down,
                  size: 48,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Spacer(),
          Text(
            "Current Temperature".toUpperCase(),
            style: const TextStyle(color: Colors.white),
          ),
          const SizedBox(
            height: defaultPadding,
          ),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Inside".toUpperCase(),
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(color: Colors.white),
                  ),
                  Text(
                    "20" "\u2103",
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(
                width: defaultPadding,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Inside".toUpperCase(),
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(color: Colors.white54),
                  ),
                  Text(
                    "30" "\u2103",
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(color: Colors.white54),
                  )
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
