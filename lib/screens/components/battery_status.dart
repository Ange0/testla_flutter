import 'package:flutter/material.dart';

class BatteryStatus extends StatelessWidget {
  const BatteryStatus({
    Key? key,
    required this.constrains,
  }) : super(key: key);

  final BoxConstraints constrains;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text(
            '220 mi',
            style: Theme.of(context)
                .textTheme
                .headline3!
                .copyWith(color: Colors.white),
          ),
          Text(
            "62 %",
            style: Theme.of(context)
                .textTheme
                .headline5!
                .copyWith(color: Colors.white),
          ),
          const Spacer(),
          Text("Charging".toUpperCase(),
              style: const TextStyle(fontSize: 20, color: Colors.white)),
          const Text(
            "18 min remaining",
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          SizedBox(
            height: constrains.maxHeight * 0.08,
          ),
          DefaultTextStyle(
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "32 mi/hr",
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  "230 v",
                  style: TextStyle(color: Colors.white),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
