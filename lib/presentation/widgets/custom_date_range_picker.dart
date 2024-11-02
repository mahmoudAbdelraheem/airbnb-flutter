import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class CustomDateRangePicker extends StatefulWidget {
  final ValueChanged<DateTimeRange> onDateRangeChanged;
  final List<DateTimeRange> disabledDates;

  const CustomDateRangePicker({
    super.key,
    required this.onDateRangeChanged,
    this.disabledDates = const [],
  });

  @override
  CustomDateRangePickerState createState() => CustomDateRangePickerState();
}

class CustomDateRangePickerState extends State<CustomDateRangePicker> {
  final DateTime _firstDate = DateTime.now();
  final DateTime _lastDate = DateTime(DateTime.now().year + 2);

  bool _isDateDisabled(DateTime date) {
    for (DateTimeRange range in widget.disabledDates) {
      if (date.isAfter(range.start) && date.isBefore(range.end) ||
          date.isAtSameMomentAs(range.start) ||
          date.isAtSameMomentAs(range.end)) {
        return true;
      }
    }
    return false;
  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    if (args.value is PickerDateRange) {
      PickerDateRange selectedRange = args.value;
      if (selectedRange.startDate != null && selectedRange.endDate != null) {
        if (!_isDateDisabled(selectedRange.startDate!) &&
            !_isDateDisabled(selectedRange.endDate!)) {
          widget.onDateRangeChanged(DateTimeRange(
            start: selectedRange.startDate!,
            end: selectedRange.endDate!,
          ));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Selected date range is disabled.')),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SfDateRangePicker(
      minDate: _firstDate,
      maxDate: _lastDate,
      selectableDayPredicate: (DateTime date) => !_isDateDisabled(date),
      selectionMode: DateRangePickerSelectionMode.range,
      onSelectionChanged: _onSelectionChanged,
      todayHighlightColor: Colors.black,
      selectionColor: Colors.black,
      startRangeSelectionColor: Colors.black,
      endRangeSelectionColor: Colors.black,
      rangeSelectionColor: Colors.grey,
    );
  }
}
