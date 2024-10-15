part of 'get_history_cubit.dart';

@immutable
sealed class GetHistoryState {}

final class GetHistoryInitial extends GetHistoryState {}

final class LogDataLoading extends GetHistoryState {}

class GetHistoryLoaded extends GetHistoryState {
  final HeartRateDataCollection collection;

  GetHistoryLoaded(this.collection);
}

class GetHistoryError extends GetHistoryState {
  final String error;

  GetHistoryError(this.error);
}
