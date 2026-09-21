import 'package:flutter/material.dart';

/// Exercise 2: Input Widgets Demo
/// Demonstrates interactive input controls:
/// - Slider: controls a numeric value (0 - 100)
/// - Switch: toggles a boolean state (active/inactive)
/// - RadioListTile: allows selecting one option from a group (Action/Comedy)
/// - DatePicker: picks a date using showDatePicker()
class InputControlsDemo extends StatefulWidget {
  const InputControlsDemo({super.key});

  @override
  State<InputControlsDemo> createState() => _InputControlsDemoState();
}

class _InputControlsDemoState extends State<InputControlsDemo> {
  // State variables for input widgets
  double _rating = 50.0;
  bool _isActive = false;
  String? _selectedGenre;
  DateTime? _selectedDate;

  // Function to show Flutter's built-in DatePicker
  Future<void> _openDatePicker() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercise 2 – Input Controls Demo'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Section 1: Rating (Slider) ---
            const Text(
              'Rating (Slider)',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Slider(
              value: _rating,
              min: 0,
              max: 100,
              divisions: 100,
              label: _rating.round().toString(),
              onChanged: (double value) {
                setState(() {
                  _rating = value;
                });
              },
            ),
            Text(
              'Current value: ${_rating.toInt()}',
              style: const TextStyle(fontSize: 14, color: Colors.black87),
            ),
            const SizedBox(height: 20),

            // --- Section 2: Active (Switch) ---
            const Text(
              'Active (Switch)',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Is movie active?',
                  style: TextStyle(fontSize: 15),
                ),
                Switch(
                  value: _isActive,
                  onChanged: (bool value) {
                    setState(() {
                      _isActive = value;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),

            // --- Section 3: Genre (RadioListTile) ---
            const Text(
              'Genre (RadioListTile)',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            RadioGroup<String>(
              groupValue: _selectedGenre,
              onChanged: (String? value) {
                setState(() {
                  _selectedGenre = value;
                });
              },
              child: Column(
                children: const [
                  RadioListTile<String>(
                    title: Text('Action'),
                    value: 'Action',
                    contentPadding: EdgeInsets.zero,
                  ),
                  RadioListTile<String>(
                    title: Text('Comedy'),
                    value: 'Comedy',
                    contentPadding: EdgeInsets.zero,
                  ),
                ],
              ),
            ),
            Text(
              'Selected genre: ${_selectedGenre ?? "None"}',
              style: const TextStyle(fontSize: 14, color: Colors.black87),
            ),
            const SizedBox(height: 24),

            // --- Section 4: DatePicker Button ---
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: _openDatePicker,
                child: const Text(
                  'Open Date Picker',
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ),
            if (_selectedDate != null) ...[
              const SizedBox(height: 8),
              Center(
                child: Text(
                  'Selected Date: ${_selectedDate!.day.toString().padLeft(2, '0')}/${_selectedDate!.month.toString().padLeft(2, '0')}/${_selectedDate!.year}',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.blueAccent,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
