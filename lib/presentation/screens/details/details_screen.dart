import 'package:airbnb_flutter/core/widgets/loading.dart';
import 'package:airbnb_flutter/data/models/listing_model.dart';
import 'package:airbnb_flutter/logic/details/details_bloc.dart';
import 'package:airbnb_flutter/logic/reservation/reservation_bloc.dart';
import 'package:airbnb_flutter/presentation/widgets/details/details_map_widget.dart';
import 'package:airbnb_flutter/presentation/widgets/details/host_card.dart';
import 'package:airbnb_flutter/presentation/widgets/details/host_reviews.dart';
import 'package:airbnb_flutter/presentation/widgets/details/listing_details_images.dart';
import 'package:airbnb_flutter/presentation/widgets/details/reserve_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailsScreen extends StatefulWidget {
  final ListingModel listing;
  final bool isFavorite;
  const DetailsScreen(
      {super.key, required this.listing, required this.isFavorite});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    ReservationBloc reservationBloc = BlocProvider.of<ReservationBloc>(context);
    return BlocConsumer<DetailsBloc, DetailsState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: BlocBuilder<ReservationBloc, ReservationState>(
            builder: (context, state) => state is GetReservationsSuccessState
                ? ReserveWidget(
                    listing: widget.listing,
                    reservations: state.reservations,
                    reservationBloc: reservationBloc,
                  )
                : const Loading(),
          ),
          body: ListView(
            children: [
              ListingDetailsImages(
                listing: widget.listing,
                isFavorite: widget.isFavorite,
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      widget.listing.title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '${widget.listing.roomCount} rooms . ${widget.listing.guestCount} guests . ${widget.listing.bathroomCount} bathrooms',
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      widget.listing.location,
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'About this place',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      widget.listing.description,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    Divider(
                      thickness: 1.5,
                      color: Colors.grey.shade300,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Where you’ll be',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              DetailsMapWidget(
                listingLocation: widget.listing.mapLocation,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Divider(
                      thickness: 1.5,
                      color: Colors.grey.shade300,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Meet Your Host',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 15),
                    state is DetailsLoadedState
                        ? HostCard(
                            host: state.host,
                            reviewsLength: state.reviews.length.toString(),
                            avarageRating: state.avarageRating,
                          )
                        : const Loading(),
                    const SizedBox(height: 15),
                    Divider(
                      thickness: 1.5,
                      color: Colors.grey.shade300,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'See What Guests Are Saying',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    state is DetailsLoadedState
                        ? HostReviews(reviews: state.reviews)
                        : const Loading(),
                  ],
                ),
              ),
              const SizedBox(height: 80),
            ],
          ),
        );
      },
    );
  }
}
