part of 'get_data_tenang_cubit.dart';

@immutable
sealed class GetDataTenangState {}

final class GetDataTenangInitial extends GetDataTenangState {}

final class GetDataTenangLoaded extends GetDataTenangState {
  final HeartRateDataCollection collection;

  GetDataTenangLoaded({required this.collection});
}
