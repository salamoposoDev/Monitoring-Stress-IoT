import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:meta/meta.dart';

part 'get_data_sensor_state.dart';

class GetDataSensorCubit extends Cubit<GetDataSensorState> {
  final ref = FirebaseDatabase.instance.ref('realtime');
  GetDataSensorCubit() : super(GetDataSensorInitial());

  void getData() {
    ref.onValue.listen((event) {
      if (event.snapshot.exists) {
        final jsonData = jsonEncode(event.snapshot.value);
        final Map<String, dynamic> jsonMap =
            json.decode(jsonData) as Map<String, dynamic>;
        log(jsonMap.toString());
        emit(GetDataSensorData(jsonMap: jsonMap));
      }
    });
  }
}
