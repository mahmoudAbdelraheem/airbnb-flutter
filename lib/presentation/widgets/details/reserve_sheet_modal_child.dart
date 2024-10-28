// reserve_sheet_modal_child.dart
import 'package:airbnb_flutter/presentation/widgets/custom_date_range_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_date_pickers/flutter_date_pickers.dart' as dp;

class ReserveSheetModalChild extends StatefulWidget {
  const ReserveSheetModalChild({
    super.key,
  });

  @override
  ReserveSheetModalChildState createState() => ReserveSheetModalChildState();
}

class ReserveSheetModalChildState extends State<ReserveSheetModalChild> {
  DateTimeRange? selectedDateRange;

  final DateTime _firstDate = DateTime.now();
  final DateTime _lastDate = DateTime(DateTime.now().year + 2);
  final dp.DatePeriod _initialPeriod = dp.DatePeriod(
    DateTime.now(),
    DateTime.now(),
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
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

          // Reusable Date Picker
          Align(
            alignment: Alignment.center,
            child: CustomDateRangePicker(
              firstDate: _firstDate,
              lastDate: _lastDate,
              initialSelectedPeriod: _initialPeriod,
              onDateRangeChanged: (dp.DatePeriod newPeriod) {
                setState(() {
                  selectedDateRange = DateTimeRange(
                    start: newPeriod.start,
                    end: newPeriod.end,
                  );
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
