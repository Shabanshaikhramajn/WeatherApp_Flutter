import 'package:flutter/material.dart';

class HourlyForecastCard extends StatelessWidget {
  final dynamic humidity;
  const HourlyForecastCard({super.key, required this.humidity});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: SizedBox(
          width: 100,
          child: Card(
            elevation: 6,
            child: Column(
              children: [
                SizedBox(
                  height: 15,
                ),
                Text(
                  '12.00',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: 8,
                ),
                Icon(
                  Icons.wb_sunny,
                  color: Colors.amber,
                  size: 35,
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  '${humidity}',
                  style: TextStyle(fontSize: 15),
                ),
                SizedBox(
                  height: 15,
                )
              ],
            ),
          )),
    );
  }
}
