part of 'get_data_tegang_cubit.dart';

@immutable
sealed class GetDataTegangState {}

final class GetDataTegangInitial extends GetDataTegangState {}

final class GetDataTegangLoaded extends GetDataTegangState {
  final HeartRateDataCollection collection;

  GetDataTegangLoaded({required this.collection});
}
