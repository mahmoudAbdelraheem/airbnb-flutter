import 'package:airbnb_flutter/core/widgets/custom_button.dart';
import 'package:airbnb_flutter/data/models/reservation_model.dart';
import 'package:airbnb_flutter/logic/reservation/reservation_bloc.dart';
import 'package:airbnb_flutter/presentation/widgets/custom_date_range_picker.dart';
import 'package:flutter/material.dart';

class ReserveSheetModalChild extends StatefulWidget {
  final double price;
  final List<ReservationModel> reservations;
  final ReservationBloc reservationBloc;

  const ReserveSheetModalChild({
    super.key,
    required this.price,
    required this.reservations,
    required this.reservationBloc,
  });

  @override
  ReserveSheetModalChildState createState() => ReserveSheetModalChildState();
}

class ReserveSheetModalChildState extends State<ReserveSheetModalChild> {
  DateTimeRange? selectedDateRange;
  double totalPrice = 0;

  @override
  void initState() {
    totalPrice = widget.price;
    super.initState();
  }

  // Function to create a list of reserved DatePeriods from reservations
  List<DateTimeRange> _getDisabledPeriods() {
    return widget.reservations.map((reservation) {
      return DateTimeRange(
        start: reservation.startDate,
        end: reservation.endDate,
      );
    }).toList();
  }

  void _calculateTotalPrice() {
    if (selectedDateRange != null) {
      int daysDifference =
          selectedDateRange!.end.difference(selectedDateRange!.start).inDays +
              1;
      setState(() {
        totalPrice = daysDifference * widget.price;
      });
    }
  }

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
              disabledDates: _getDisabledPeriods(),
              onDateRangeChanged: (DateTimeRange newRange) {
                setState(() {
                  selectedDateRange = newRange;
                });

                _calculateTotalPrice();
              },
            ),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  width: 1.2,
                  color: Colors.grey.shade300,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Total Price',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      '\$${totalPrice.toStringAsFixed(0)}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                CustomButton(
                  text: 'Save',
                  onTap: () {
                    // Check if a date range is selected
                    if (selectedDateRange != null) {
                      // Save the selected date range to the reservation bloc
                      widget.reservationBloc.totalPrice = totalPrice;
                      widget.reservationBloc.startDate =
                          selectedDateRange!.start;
                      widget.reservationBloc.endDate = selectedDateRange!.end;

                      // Close the modal
                      Navigator.pop(context);
                    }
                  },
                  backgroundColor: Colors.black,
                  width: 80,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
