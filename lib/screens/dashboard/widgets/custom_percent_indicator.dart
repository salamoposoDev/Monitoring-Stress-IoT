import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class CustomPercentIndicator extends StatelessWidget {
  const CustomPercentIndicator({
    super.key,
    required this.hearBeat,
    required this.backgroundColor,
    required this.progressColor,
  });
  final int hearBeat;
  final Color backgroundColor;
  final Color progressColor;

  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      radius: 70,
      lineWidth: 15,
      percent: hearBeat / 100,
      backgroundColor: backgroundColor,
      progressColor: progressColor,
      circularStrokeCap: CircularStrokeCap.round,
      center: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            hearBeat.toString(),
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(width: 12),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.monitor_heart_outlined,
                color: progressColor,
              ),
              Text(
                'BPM',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
