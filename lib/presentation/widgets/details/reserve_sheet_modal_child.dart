import 'package:flutter/material.dart';
import 'package:flutter_date_pickers/flutter_date_pickers.dart' as dp;
import 'package:intl/intl.dart';

class ReserveSheetModalChild extends StatefulWidget {
  const ReserveSheetModalChild({
    super.key,
  });

  @override
  _ReserveSheetModalChildState createState() => _ReserveSheetModalChildState();
}

class _ReserveSheetModalChildState extends State<ReserveSheetModalChild> {
  DateTimeRange? selectedDateRange;

  final DateTime _firstDate = DateTime.now();
  final DateTime _lastDate = DateTime(DateTime.now().year + 2);
  dp.DatePeriod _selectedPeriod = dp.DatePeriod(
    DateTime.now(),
    DateTime.now(),
  ); // Initialize with a default range

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.only(bottom: 15),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.grey.shade300,
              ),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_back,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Select Dates',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 15),
              const Text(
                'Add your travel dates for exact pricing.',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // Date range picker
        dp.RangePicker(
          selectedPeriod: _selectedPeriod,
          onChanged: (dp.DatePeriod newPeriod) {
            setState(() {
              _selectedPeriod = newPeriod;
              selectedDateRange = DateTimeRange(
                start: newPeriod.start,
                end: newPeriod.end,
              );
            });
          },
          firstDate: _firstDate,
          lastDate: _lastDate,
          selectableDayPredicate: (date) => true, // Customize selectable days
          datePickerStyles: dp.DatePickerRangeStyles(
            selectedPeriodStartDecoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(10.0),
            ),
            selectedPeriodLastDecoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(10.0),
            ),
            selectedPeriodMiddleDecoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.4),
            ),
            dayHeaderStyle: const dp.DayHeaderStyle(
              textStyle: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),

        // Display the selected date range
        if (selectedDateRange != null)
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Text(
              'Selected Dates: ${DateFormat('MMM dd').format(selectedDateRange!.start)} - ${DateFormat('MMM dd').format(selectedDateRange!.end)}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
      ],
    );
  }
}
