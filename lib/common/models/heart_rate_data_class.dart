class HeartRateData {
  final int heartRate;
  final int ecg;

  HeartRateData({required this.heartRate, required this.ecg});

  // Factory constructor to create a HeartRateData instance from a map
  factory HeartRateData.fromMap(Map<String, dynamic> map) {
    return HeartRateData(
      heartRate: map['heartRate'] ?? 0, // Default to 0 if null
      ecg: map['ecg'] ?? 0, // Default to 0 if null
    );
  }

  // Convert the HeartRateData instance to a map
  Map<String, dynamic> toMap() {
    return {
      'heartRate': heartRate,
      'ecg': ecg,
    };
  }
}
