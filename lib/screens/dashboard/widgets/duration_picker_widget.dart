import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class DurationPickerWidget extends StatefulWidget {
  @override
  _DurationPickerWidgetState createState() => _DurationPickerWidgetState();
}

class _DurationPickerWidgetState extends State<DurationPickerWidget> {
  final ref = FirebaseDatabase.instance.ref('/trigger');
  final TextEditingController _nameController = TextEditingController();
  int selectedDuration = 0;
  String? selectedCondition;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Masukkan Nama',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                  12,
                )),
              ),
            ),
            SizedBox(height: 16.0),
            Text('Pilih Durasi Pengukuran'),
            Wrap(
              spacing: 8.0,
              children: <Widget>[
                for (int duration in [1, 2, 3, 4, 5, 6])
                  ChoiceChip(
                    label: Text('$duration menit'),
                    selected: selectedDuration == duration,
                    onSelected: (bool selected) {
                      setState(() {
                        selectedDuration = selected ? duration : 0;
                      });
                    },
                  ),
              ],
            ),
            SizedBox(height: 16.0),
            Text('Pilih Kondisi Pengukuran'),
            Wrap(
              spacing: 8.0,
              children: <Widget>[
                for (String condition in [
                  'Rileks',
                  'Tenang',
                  'Cemas',
                  'Tegang'
                ])
                  ChoiceChip(
                    label: Text(condition),
                    selected: selectedCondition == condition,
                    onSelected: (bool selected) {
                      setState(() {
                        selectedCondition = selected ? condition : null;
                      });
                    },
                  ),
              ],
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        String name = _nameController.text;
                        if (selectedDuration > 0 &&
                            name != '' &&
                            selectedCondition != null) {
                          ref.update({
                            'newName': name,
                            'condition': selectedCondition,
                            'newMeasureTime': selectedDuration,
                            'startMeasure': true
                          });
                          Navigator.pop(context, selectedDuration);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          fixedSize: Size(150, 45)),
                      child: Text(
                        'Mulai',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Cancel'),
                      style: ElevatedButton.styleFrom(fixedSize: Size(150, 45)),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
