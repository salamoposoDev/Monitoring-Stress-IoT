part of 'get_data_cemas_cubit.dart';

@immutable
sealed class GetDataCemasState {}

final class GetDataCemasInitial extends GetDataCemasState {}

final class GetDataCemasLoaded extends GetDataCemasState {
  final HeartRateDataCollection collection;

  GetDataCemasLoaded(this.collection);
}
