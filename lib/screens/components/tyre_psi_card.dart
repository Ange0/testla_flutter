import 'package:animation_testla_car/constanins.dart';
import 'package:animation_testla_car/models/TyrePsi.dart';
import 'package:flutter/material.dart';

class TyrePsiCard extends StatelessWidget {
  const TyrePsiCard({
    Key? key,
    required this.isBottomTwoTyre,
    required this.tyrePsi,
  }) : super(key: key);

  final bool isBottomTwoTyre;
  final TyrePsi tyrePsi;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: tyrePsi.isLowPressure
            ? Colors.red.withOpacity(0.1)
            : Colors.white10,
        border:
            Border.all(color: tyrePsi.isLowPressure ? redColor : primaryColor),
        borderRadius: BorderRadius.circular(10),
      ),
      child: isBottomTwoTyre
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${tyrePsi.temp} \u2103",
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                lowPressureText(context),
                const Spacer(),
                psiText(context, psi: "${tyrePsi.psi}"),
                const SizedBox(
                  height: defaultPadding,
                ),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                psiText(context, psi: "${tyrePsi.psi}"),
                const SizedBox(
                  height: defaultPadding,
                ),
                Text(
                  "${tyrePsi.temp}" " \u2103",
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                const Spacer(),
                lowPressureText(context),
              ],
            ),
    );
  }

  Column lowPressureText(BuildContext context) {
    return Column(
      children: [
        Text(
          "Low".toLowerCase(),
          style: Theme.of(context)
              .textTheme
              .headline3!
              .copyWith(color: Colors.white),
        ),
        Text(
          "Pressure".toLowerCase(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        )
      ],
    );
  }

  Text psiText(BuildContext context, {required String psi}) {
    return Text.rich(
      TextSpan(
          text: psi,
          style: Theme.of(context).textTheme.headline4!.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
          children: const [
            TextSpan(text: "psi", style: TextStyle(fontSize: 20))
          ]),
    );
  }
}
