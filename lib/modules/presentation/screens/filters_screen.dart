import 'package:flutter/material.dart';

class FiltersScreen extends StatefulWidget {
  final String? selectedStatus;
  final String? selectedGender;

  const FiltersScreen({super.key, this.selectedStatus, this.selectedGender});

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  String? _status;
  String? _gender;

  final statuses = ['Alive', 'Dead', 'unknown'];
  final genders = ['Male', 'Female', 'Genderless', 'unknown'];

  @override
  void initState() {
    super.initState();
    _status = widget.selectedStatus;
    _gender = widget.selectedGender;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Filter Characters'),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Status',
              style: TextStyle(color: Color(0xff5B6975), fontSize: 18),
            ),
            Wrap(
              spacing: 8,
              children:
                  statuses.map((status) {
                    return ChoiceChip(
                      label: Text(status),
                      selected: _status == status,
                      onSelected: (selected) {
                        setState(() {
                          _status = selected ? status : null;
                        });
                      },
                      selectedColor: Colors.green,
                      backgroundColor: Colors.grey[500],
                      labelStyle: const TextStyle(color: Colors.white),
                    );
                  }).toList(),
            ),
            const SizedBox(height: 20),
            const Text(
              'Gender',
              style: TextStyle(color: Color(0xff5B6975), fontSize: 18),
            ),
            Wrap(
              spacing: 8,
              children:
                  genders.map((gender) {
                    return ChoiceChip(
                      label: Text(gender),
                      selected: _gender == gender,
                      onSelected: (selected) {
                        setState(() {
                          _gender = selected ? gender : null;
                        });
                      },
                      selectedColor: Colors.blue,
                      backgroundColor: Colors.grey[500],
                      labelStyle: const TextStyle(color: Colors.white),
                    );
                  }).toList(),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, {
                    'status': _status,
                    'gender': _gender,
                  });
                },
                child: const Text('Apply Filters'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
