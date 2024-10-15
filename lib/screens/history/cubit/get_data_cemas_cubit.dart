import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:meta/meta.dart';
import 'package:monitoring_stress/common/models/heart_rate_data_collections.dart';

part 'get_data_cemas_state.dart';

class GetDataCemasCubit extends Cubit<GetDataCemasState> {
  final ref = FirebaseDatabase.instance.ref('data/Cemas');
  GetDataCemasCubit() : super(GetDataCemasInitial());

  Future<void> getData() async {
    try {
      final snapshot = await ref.get();
      if (snapshot.exists) {
        final jsonData = jsonEncode(snapshot.value);
        final collection = HeartRateDataCollection.fromJson(jsonData);
        emit(GetDataCemasLoaded(collection));
        log(collection.data.keys.toString());
      } else {
        emit(GetDataCemasLoaded(HeartRateDataCollection({})));
      }
    } catch (e) {}
  }

  Future<void> delete(String path) async {
    try {
      await ref.child(path).remove();
      await getData();
    } catch (e) {
      log(e.toString());
    }
  }
}
