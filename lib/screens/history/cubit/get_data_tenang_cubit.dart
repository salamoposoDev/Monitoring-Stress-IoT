import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:meta/meta.dart';
import 'package:monitoring_stress/common/models/heart_rate_data_collections.dart';

part 'get_data_tenang_state.dart';

class GetDataTenangCubit extends Cubit<GetDataTenangState> {
  final ref = FirebaseDatabase.instance.ref('data/Tenang');
  GetDataTenangCubit() : super(GetDataTenangInitial());

  Future<void> getData() async {
    try {
      final snapshot = await ref.get();
      if (snapshot.exists) {
        final jsonData = jsonEncode(snapshot.value);
        final collection = HeartRateDataCollection.fromJson(jsonData);
        emit(GetDataTenangLoaded(collection: collection));
        // log(collection.data.keys.toString());
      } else {
        emit(GetDataTenangLoaded(collection: HeartRateDataCollection({})));
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
