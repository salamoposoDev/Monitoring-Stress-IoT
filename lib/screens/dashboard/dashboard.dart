import 'dart:async';
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monitoring_stress/screens/dashboard/cubit/get_data_sensor_cubit.dart';
import 'package:monitoring_stress/screens/dashboard/widgets/custom_percent_indicator.dart';
import 'package:monitoring_stress/screens/dashboard/widgets/duration_picker_widget.dart';
import 'package:monitoring_stress/screens/dashboard/widgets/realtime_chart.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final refTrigger = FirebaseDatabase.instance.ref('trigger/');
  int countdownDuration = 0;
  Timer? _timer;
  int _remainingTime = 0;

  void _showBottomSheet(BuildContext context) async {
    final result = await showModalBottomSheet<int>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.blueGrey.shade900,
      builder: (BuildContext context) {
        return DurationPickerWidget();
      },
    );

    if (result != null) {
      setState(() {
        countdownDuration = result;
        _startCountdown();
      });
    }
  }

  void _startCountdown() {
    if (_timer != null) {
      _timer!.cancel(); // Membatalkan timer sebelumnya jika ada
    }

    _remainingTime = countdownDuration! * 60; // Ubah menit ke detik

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingTime > 0) {
          _remainingTime = _remainingTime - 1;
        } else {
          _timer!.cancel(); // Menghentikan timer ketika countdown selesai
          refTrigger.update({
            'newName': 'null',
            'condition': 'null',
            'newMeasureTime': 0,
            'startMeasure': false
          });
        }
      });
    });
  }

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    log(_remainingTime.toString());
    return BlocProvider(
      create: (context) => GetDataSensorCubit()..getData(),
      child: BlocBuilder<GetDataSensorCubit, GetDataSensorState>(
        builder: (context, sensors) {
          if (sensors is GetDataSensorData) {
            return SafeArea(
              child: Scaffold(
                backgroundColor: Colors.grey.shade900,
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        const Row(
                          children: [
                            CircleAvatar(
                              radius: 25,
                              backgroundColor: Colors.deepPurple,
                              child: Icon(
                                Icons.person,
                                size: 40,
                              ),
                            ),
                            SizedBox(width: 16),
                            Text(
                              'Hello, Fadel',
                              style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.normal,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 20),
                        Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(16),
                              width: double.maxFinite,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: Colors.grey.shade800,
                              ),
                              child: Column(
                                children: [
                                  // Row(
                                  //   children: [
                                  //     Column(
                                  //       children: [
                                  //         Icon(Icons.cloud),
                                  //         Text('Selamat Pagi'),
                                  //       ],
                                  //     ),
                                  //     Text('Senin, 17 Agustus 2024'),
                                  //   ],
                                  // ),
                                  Row(
                                    children: [
                                      const Expanded(
                                        child: Text(
                                          'Sudah monitoring Stress hari ini?',
                                          style: TextStyle(
                                              fontSize: 28,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Image.asset(
                                        'lib/icons/icons8-heart-rate-64-2.png',
                                        scale: .8,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            GridView.builder(
                                itemCount: 2,
                                shrinkWrap: true,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 16,
                                        mainAxisSpacing: 16,
                                        mainAxisExtent: 200),
                                itemBuilder: (context, index) {
                                  final colors = [
                                    Colors.deepPurple,
                                    Colors.grey.shade800
                                  ];
                                  List<Map<String, dynamic>> sensorList = [
                                    {
                                      'name': "Max30102",
                                      'value': sensors.jsonMap['heartRate']
                                    },
                                    {
                                      'name': "ECG",
                                      'value': sensors.jsonMap['ecg']
                                    },
                                  ];

                                  return Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        color: colors[index],
                                        borderRadius:
                                            BorderRadius.circular(16)),
                                    child: Column(
                                      children: [
                                        Text(
                                          sensorList[index]['name'],
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                        CustomPercentIndicator(
                                            hearBeat:
                                                sensorList[index]['value'] > 100
                                                    ? 100
                                                    : sensorList[index]
                                                        ['value'],
                                            backgroundColor:
                                                Colors.grey.shade500,
                                            progressColor: Colors.red.shade600),
                                      ],
                                    ),
                                  );
                                }),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Container(
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade800,
                            borderRadius: BorderRadius.circular(8),
                            // border: Border.all(color: Colors.white),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    _formatTime(_remainingTime),
                                    style: const TextStyle(
                                        fontSize: 38,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                              const Text(
                                'Tetap terkoneksi dengan sensor selama waktu pengukuran',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.normal,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_remainingTime > 0) {
                                    setState(() {
                                      _timer!.cancel();
                                      _remainingTime = 0;
                                    });
                                    refTrigger.update({
                                      'newName': 'null',
                                      'condition': 'null',
                                      'newMeasureTime': 0,
                                      'startMeasure': false
                                    });
                                  } else {
                                    _showBottomSheet(context);
                                  }
                                },
                                child: Text(
                                  _remainingTime! > 0
                                      ? 'Stop Mengukur'
                                      : 'Mulai Mengukur',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                    fixedSize: const Size(0, 50),
                                    backgroundColor: Colors.red.shade800,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    )),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
          return const Column();
        },
      ),
    );
  }
}
