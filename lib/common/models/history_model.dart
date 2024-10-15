class HistoryModel {
  final Map<String, List<HeartData>> logs;

  HistoryModel({required this.logs});

  factory HistoryModel.fromJson(Map<String, dynamic> json) {
    Map<String, List<HeartData>> logsMap = {};
    json.forEach((key, value) {
      List<HeartData> heartDataList = [];
      (value as Map<String, dynamic>).forEach((key, value) {
        heartDataList.add(HeartData.fromJson(value));
      });
      logsMap[key] = heartDataList;
    });
    return HistoryModel(logs: logsMap);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    logs.forEach((key, value) {
      data[key] = value.map((e) => e.toJson()).toList();
    });
    return data;
  }
}

class HeartData {
  final int heartRate;
  final int ecg;

  HeartData({required this.heartRate, required this.ecg});

  factory HeartData.fromJson(Map<String, dynamic> json) {
    return HeartData(
      heartRate: json['heartRate'],
      ecg: json['ecg'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'heartRate': heartRate,
      'ecg': ecg,
    };
  }
}
