import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:monitoring_stress/common/models/heart_rate_data_class.dart';
import 'package:monitoring_stress/common/models/heart_rate_data_collections.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key, required this.name, required this.collection});
  final String name;
  final HeartRateDataCollection collection;

  String determineStressCondition(double averageHeartRate) {
    if (averageHeartRate > 100) {
      return 'Tegang';
    } else if (averageHeartRate >= 90) {
      return 'Cemas';
    } else if (averageHeartRate >= 70) {
      return 'Tenang';
    } else if (averageHeartRate >= 60) {
      return 'Rileks';
    } else {
      return 'Tidak Diketahui';
    }
  }

  @override
  Widget build(BuildContext context) {
    final data = collection.data[name];
    if (data == null || data.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Data $name'),
        ),
        body: Center(child: Text('No data available')),
      );
    }

    // Calculate the average, highest, and lowest values
    int totalECG = 0;
    int totalHeartRate = 0;
    int minECG = 0;
    int maxECG = 0;
    int minHeartRate = 0;
    int maxHeartRate = 0;

    for (var record in data) {
      totalECG += record.ecg;
      totalHeartRate += record.heartRate;
      if (record.ecg < minECG) minECG = record.ecg;
      if (record.ecg > maxECG) maxECG = record.ecg;
      if (record.heartRate < minHeartRate) minHeartRate = record.heartRate;
      if (record.heartRate > maxHeartRate) maxHeartRate = record.heartRate;
    }

    final averageECG = totalECG / data.length;
    final averageHeartRate = totalHeartRate / data.length;

    // Tentukan kondisi stress
    final stressCondition = determineStressCondition(averageECG);

    log(averageHeartRate.toString());
    return Scaffold(
      appBar: AppBar(
        title: Text('Data $name'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(16),
              margin: EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: Colors.grey.shade900,
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Stress Level: $stressCondition',
                    style: GoogleFonts.roboto(fontSize: 22),
                  ),
                  Divider(),
                  Text(
                    'Average',
                    style: GoogleFonts.roboto(fontSize: 22),
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Heart Rate: ${averageHeartRate.toStringAsFixed(2)} BPM",
                        style: GoogleFonts.roboto(fontSize: 16),
                      ),
                      Text(
                        "ECG: ${averageECG.toStringAsFixed(2)} BPM",
                        style: GoogleFonts.roboto(fontSize: 16),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        'Detail',
                        style: GoogleFonts.roboto(fontSize: 22),
                      ),
                      Icon(Icons.keyboard_arrow_down)
                    ],
                  ),
                  Text(
                    'Total ${data.length}',
                    style: GoogleFonts.roboto(fontSize: 22),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: ListView.builder(
                  itemCount: data.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 2),
                      child: ListTile(
                        style: ListTileStyle.list,
                        tileColor: Colors.grey.shade900,
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('ECG: ${data[index].ecg}'),
                            Text('Heart Rate: ${data[index].heartRate}'),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
