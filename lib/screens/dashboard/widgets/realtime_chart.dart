import 'dart:async';
import 'dart:developer';
import 'dart:math' as math;
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class RealtimeChart extends StatefulWidget {
  const RealtimeChart({super.key});

  @override
  State<RealtimeChart> createState() => _RealtimeChartState();
}

class _RealtimeChartState extends State<RealtimeChart> {
  late List<LiveData> chartData;
  late ChartSeriesController _chartSeriesController;
  int initialTimestamp = 0;

  @override
  void initState() {
    chartData = getChartData();
    updateDataFromDB();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      series: <LineSeries<LiveData, int>>[
        LineSeries<LiveData, int>(
          onRendererCreated: (ChartSeriesController controller) {
            _chartSeriesController = controller;
          },
          dataSource: chartData,
          color: const Color.fromRGBO(192, 108, 132, 1),
          xValueMapper: (LiveData sales, _) => _getSeconds(sales.time),
          yValueMapper: (LiveData sales, _) => sales.speed,
          dataLabelMapper: (LiveData sales, _) => _formatTimestamp(sales.time),
        ),
      ],
      primaryXAxis: NumericAxis(
          majorGridLines: const MajorGridLines(width: 0),
          edgeLabelPlacement: EdgeLabelPlacement.shift,
          interval: 3,
          title: AxisTitle(text: 'Time (seconds)')),
      primaryYAxis: NumericAxis(
        axisLine: const AxisLine(width: 0),
        majorTickLines: const MajorTickLines(size: 0),
        title: AxisTitle(text: 'Internet speed (Mbps)'),
      ),
    );
  }

  int _getSeconds(int timestamp) {
    final dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    return dateTime.second;
  }

  int time = 19;
  void updateDataSource(Timer timer) {
    chartData.add(LiveData(time++, (math.Random().nextInt(60) + 30)));
    chartData.removeAt(0);
    _chartSeriesController.updateDataSource(
        addedDataIndex: chartData.length - 1, removedDataIndex: 0);
  }

  void updateDataFromDB() {
    final ref = FirebaseDatabase.instance.ref('data');
    ref.onValue.listen((event) {
      if (event.snapshot.exists) {
        final Map<dynamic, dynamic> dataMap =
            event.snapshot.value as Map<dynamic, dynamic>;
        List<LiveData> tempData = [];
        dataMap.forEach((key, value) {
          final int time = value['time'];
          final num speed = value['data'];
          tempData.add(LiveData(time, speed));
        });

        setState(() {
          chartData = tempData;
          chartData.removeAt(0);
          _chartSeriesController.updateDataSource(
              addedDataIndex: chartData.length - 1, removedDataIndex: 0);
        });
      }
    });
  }

  String _formatTimestamp(int timestamp) {
    final dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    final formatter = DateFormat('mm:ss');
    return formatter.format(dateTime);
  }

  List<LiveData> getChartData() {
    return <LiveData>[
      LiveData(0, 42),
      LiveData(1, 47),
      LiveData(2, 43),
      LiveData(3, 49),
      LiveData(4, 54),
      LiveData(5, 41),
      LiveData(6, 58),
      LiveData(7, 51),
      LiveData(8, 98),
      LiveData(9, 41),
      LiveData(10, 53),
      LiveData(11, 72),
      LiveData(12, 86),
      LiveData(13, 52),
      LiveData(14, 94),
      LiveData(15, 92),
      LiveData(16, 86),
      LiveData(17, 72),
      LiveData(18, 94)
    ];
  }
}

class LiveData {
  LiveData(this.time, this.speed);
  final int time;
  final num speed;
}
