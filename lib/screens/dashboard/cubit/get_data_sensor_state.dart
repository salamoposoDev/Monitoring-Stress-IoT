part of 'get_data_sensor_cubit.dart';

@immutable
sealed class GetDataSensorState {}

final class GetDataSensorInitial extends GetDataSensorState {}

final class GetDataSensorData extends GetDataSensorState {
  final Map<String, dynamic> jsonMap;

  GetDataSensorData({required this.jsonMap});
}

final class GetDataSensorError extends GetDataSensorState {}
