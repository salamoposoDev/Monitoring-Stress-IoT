import 'dart:convert';

import 'package:monitoring_stress/common/models/heart_rate_data_class.dart';

class HeartRateDataCollection {
  final Map<String, List<HeartRateData>> data;

  HeartRateDataCollection(this.data);

  // Factory constructor to create a HeartRateDataCollection instance from a map
  factory HeartRateDataCollection.fromJson(String jsonString) {
    final Map<String, dynamic> jsonData = jsonDecode(jsonString);

    final Map<String, List<HeartRateData>> result = {};
    jsonData.forEach((key, value) {
      if (value is Map) {
        final List<HeartRateData> dataList = (value as Map<String, dynamic>)
            .values
            .map((item) => HeartRateData.fromMap(item))
            .toList();
        result[key] = dataList;
      }
    });

    return HeartRateDataCollection(result);
  }

  // Convert the HeartRateDataCollection instance to JSON
  String toJson() {
    final Map<String, dynamic> jsonData = {};
    data.forEach((key, value) {
      jsonData[key] = value.map((item) => item.toMap()).toList();
    });

    return jsonEncode(jsonData);
  }
}
