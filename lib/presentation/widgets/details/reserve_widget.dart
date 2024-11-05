import '../../../core/constants/app_constants.dart';
import '../../../core/functions/show_bottom_sheet_modal.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../data/models/listing_model.dart';
import '../../../data/models/reservation_model.dart';
import '../../../logic/home/home_bloc.dart';
import '../../../logic/reservation/reservation_bloc.dart';
import 'reserve_sheet_modal_child.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class ReserveWidget extends StatelessWidget {
  final ListingModel listing;
  final List<ReservationModel> reservations;

  const ReserveWidget({
    super.key,
    required this.listing,
    required this.reservations,
  });

  @override
  Widget build(BuildContext context) {
    HomeBloc homeBloc = context.read<HomeBloc>();
    ReservationBloc reservationBloc = context.watch<ReservationBloc>();
    String formattedDate =
        DateFormat('MMM  dd').format(reservationBloc.startDate);
    String formattedEndDate = DateFormat('dd').format(reservationBloc.endDate);
    final Size screenSize = MediaQuery.sizeOf(context);
    return Container(
      width: double.infinity,
      height: 70,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.grey,
          ),
        ),
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: '\$${listing.price.toStringAsFixed(0)}',
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const TextSpan(
                      text: '  night',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  showBottomSheetModal(
                    context: context,
                    screenSize: screenSize,
                    child: ReserveSheetModalChild(
                      price: listing.price,
                      reservations: reservations,
                      reservationBloc: reservationBloc,
                    ),
                  );
                },
                child: Text(
                  reservationBloc.startDate.day != reservationBloc.endDate.day
                      ? '$formattedDate - $formattedEndDate'
                      : formattedDate,
                  style: const TextStyle(
                    decoration: TextDecoration.underline,
                    color: Colors.black,
                    height: 1.2,
                  ),
                ),
              ),
            ],
          ),
          CustomButton(
            text: 'Reserve',
            width: 150,
            onTap: () {
              if (homeBloc.user == null) {
                Navigator.pushNamed(
                  context,
                  AppConstants.loginScreen,
                );
              } else {
                reservationBloc.add(
                  AddReservationEvent(
                    reservation: ReservationModel(
                      id: '',
                      authorId: listing.userId,
                      listingId: listing.id,
                      userId: homeBloc.user!.uid,
                      startDate: reservationBloc.startDate,
                      endDate: reservationBloc.endDate,
                      createdAt: DateTime.now(),
                      totalPrice: reservationBloc.totalPrice,
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
