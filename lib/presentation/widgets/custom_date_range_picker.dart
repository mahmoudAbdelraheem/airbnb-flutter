// custom_date_range_picker.dart
import 'package:flutter/material.dart';
import 'package:flutter_date_pickers/flutter_date_pickers.dart' as dp;

class CustomDateRangePicker extends StatefulWidget {
  final DateTime firstDate;
  final DateTime lastDate;
  final dp.DatePeriod initialSelectedPeriod;
  final ValueChanged<dp.DatePeriod> onDateRangeChanged;

  const CustomDateRangePicker({
    super.key,
    required this.firstDate,
    required this.lastDate,
    required this.initialSelectedPeriod,
    required this.onDateRangeChanged,
  });

  @override
  CustomDateRangePickerState createState() => CustomDateRangePickerState();
}

class CustomDateRangePickerState extends State<CustomDateRangePicker> {
  late dp.DatePeriod _selectedPeriod;

  @override
  void initState() {
    super.initState();
    _selectedPeriod = widget.initialSelectedPeriod;
  }

  @override
  Widget build(BuildContext context) {
    return dp.RangePicker(
      selectedPeriod: _selectedPeriod,
      onChanged: (dp.DatePeriod newPeriod) {
        setState(() {
          _selectedPeriod = newPeriod;
        });
        widget.onDateRangeChanged(newPeriod);
      },
      firstDate: widget.firstDate,
      lastDate: widget.lastDate,
      selectableDayPredicate: (date) => true,
      datePickerStyles: dp.DatePickerRangeStyles(
        selectedPeriodStartDecoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(10.0),
        ),
        selectedPeriodLastDecoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(10.0),
        ),
        selectedPeriodMiddleDecoration: BoxDecoration(
          color: Colors.black.withOpacity(0.4),
        ),
        dayHeaderStyle: const dp.DayHeaderStyle(
          textStyle: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
