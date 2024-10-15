import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:meta/meta.dart';
import 'package:monitoring_stress/common/models/heart_rate_data_collections.dart';
import 'package:monitoring_stress/common/models/history_model.dart';

part 'get_history_state.dart';

class GetHistoryCubit extends Cubit<GetHistoryState> {
  final ref = FirebaseDatabase.instance.ref('data/Rileks');
  GetHistoryCubit() : super(GetHistoryInitial());

  Future<void> getDataRileks() async {
    try {
      final snapshot = await ref.get();
      if (snapshot.exists) {
        final jsonData = jsonEncode(snapshot.value);
        final collection = HeartRateDataCollection.fromJson(jsonData);
        emit(GetHistoryLoaded(collection));
        log('State emitted: ${state.runtimeType}');
      } else {
        emit(GetHistoryLoaded(
            HeartRateDataCollection({}))); // Handle empty state
      }
    } catch (e) {
      emit(GetHistoryError(e.toString()));
      log('error= $e');
    }
  }

  Future<void> delete(String path) async {
    try {
      log('on deleted $path');
      await ref.child(path).remove();
      await getDataRileks(); // Ensure getDataRileks is awaited properly
    } catch (e) {
      log('error during delete: $e');
    }
  }
}
