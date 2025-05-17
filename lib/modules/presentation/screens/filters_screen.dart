import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

@RoutePage()
class FiltersScreen extends StatefulWidget {
  final String? selectedStatus;
  final String? selectedGender;

  const FiltersScreen({super.key, this.selectedStatus, this.selectedGender});

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  String? _status;
  final Set<String> _selectedGenders = {};

  final statuses = ['Alive', 'Dead', 'unknown'];
  final genders = ['Male', 'Female', 'Genderless'];

  @override
  void initState() {
    super.initState();
    _status = widget.selectedStatus;
    if (widget.selectedGender != null) {
      _selectedGenders.add(widget.selectedGender!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0B1E2D),
      appBar: AppBar(
        title: const Text('Filters', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xff0B1E2D),
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            const SizedBox(height: 16),
            _buildSectionTitle('Status'),
            ...statuses.map((status) {
              return _buildCheckboxTile(
                title: _localizedStatus(status),
                value: _status == status,
                onChanged: (value) {
                  setState(() {
                    _status = value! ? status : null;
                  });
                },
              );
            }),
            const Divider(color: Color(0xff5B6975)),
            _buildSectionTitle('Gender'),
            ...genders.map((gender) {
              return _buildCheckboxTile(
                title: _localizedGender(gender),
                value: _selectedGenders.contains(gender),
                onChanged: (value) {
                  setState(() {
                    if (value!) {
                      _selectedGenders.add(gender);
                    } else {
                      _selectedGenders.remove(gender);
                    }
                  });
                },
              );
            }),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff22A2BD),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: () {
                  Navigator.pop(context, {
                    'status': _status,
                    'gender':
                        _selectedGenders.isNotEmpty
                            ? _selectedGenders.first
                            : null,
                  });
                },
                child: const Text(
                  'Apply Filters',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 8),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: const TextStyle(
            color: Color(0xff5B6975),
            fontSize: 13,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }

  Widget _buildCheckboxTile({
    required String title,
    required bool value,
    required ValueChanged<bool?> onChanged,
  }) {
    return Theme(
      data: ThemeData(
        unselectedWidgetColor: const Color(0xff5B6975),
        checkboxTheme: CheckboxThemeData(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          side: const BorderSide(color: Color(0xff5B6975)),
          visualDensity: VisualDensity.compact,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
      ),
      child: CheckboxListTile(
        value: value,
        onChanged: onChanged,
        title: Text(title, style: const TextStyle(color: Colors.white)),
        contentPadding: EdgeInsets.zero,
        controlAffinity: ListTileControlAffinity.leading,
        activeColor: const Color(0xff43D049),
        checkboxShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        dense: true,
      ),
    );
  }

  String _localizedStatus(String status) {
    switch (status) {
      case 'Alive':
        return 'Alive';
      case 'Dead':
        return 'Dead';
      case 'unknown':
        return 'Unknown';
      default:
        return status;
    }
  }

  String _localizedGender(String gender) {
    switch (gender) {
      case 'Male':
        return 'Male';
      case 'Female':
        return 'Female';
      case 'Genderless':
        return 'Genderless';
      default:
        return gender;
    }
  }
}
