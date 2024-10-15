import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:meta/meta.dart';
import 'package:monitoring_stress/common/models/heart_rate_data_collections.dart';

part 'get_data_tegang_state.dart';

class GetDataTegangCubit extends Cubit<GetDataTegangState> {
  final ref = FirebaseDatabase.instance.ref('data/Tegang');
  GetDataTegangCubit() : super(GetDataTegangInitial()) {
    getData();
  }

  Future<void> getData() async {
    try {
      final snapshot = await ref.get();
      if (snapshot.exists) {
        final jsonData = jsonEncode(snapshot.value);
        final collection = HeartRateDataCollection.fromJson(jsonData);
        emit(GetDataTegangLoaded(collection: collection));
        log(collection.data.keys.toString());
      } else {
        emit(GetDataTegangLoaded(collection: HeartRateDataCollection({})));
      }
    } catch (e) {}
  }

  Future<void> delete(String path) async {
    try {
      log('on deleted $path');
      await ref.child(path).remove();
      await getData(); // Ensure getDataRileks is awaited properly
    } catch (e) {
      log('error during delete: $e');
    }
  }
}
