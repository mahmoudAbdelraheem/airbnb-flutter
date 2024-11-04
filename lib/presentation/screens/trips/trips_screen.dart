import 'package:airbnb_flutter/core/functions/show_custom_snake_bar.dart';
import 'package:airbnb_flutter/core/widgets/listing_loding.dart';
import 'package:airbnb_flutter/init_dependancies.dart';
import 'package:airbnb_flutter/logic/favorite/favorite_bloc.dart';
import 'package:airbnb_flutter/logic/reservation/reservation_bloc.dart';
import 'package:airbnb_flutter/presentation/widgets/explore/listing_card.dart';
import 'package:airbnb_flutter/presentation/widgets/screens_header.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../logic/home/home_bloc.dart';

class TripsScreen extends StatefulWidget {
  const TripsScreen({super.key});

  @override
  State<TripsScreen> createState() => _TripsScreenState();
}

class _TripsScreenState extends State<TripsScreen> {
  @override
  Widget build(BuildContext context) {
    final HomeBloc homeBloc = BlocProvider.of<HomeBloc>(context);

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) {
            if (homeBloc.user == null) {
              return serviceLocator<ReservationBloc>();
            } else {
              return serviceLocator<ReservationBloc>()
                ..add(
                  GetReservationsByUserIdEvent(
                    userId: homeBloc.user!.uid,
                  ),
                );
            }
          },
        ),
        BlocProvider(
          create: (_) {
            if (homeBloc.user == null) {
              return serviceLocator<FavoriteBloc>();
            } else {
              return serviceLocator<FavoriteBloc>()
                ..add(
                  GetFavoritesEvent(
                    userId: homeBloc.user!.uid,
                  ),
                );
            }
          },
        ),
      ],
      child: BlocConsumer<ReservationBloc, ReservationState>(
        listener: (context, state) {
          //TODO: add reservations bloc listener
        },
        builder: (context, state) {
          if (homeBloc.user == null) {
            return ListView(
              padding: const EdgeInsets.all(15),
              children: const [
                SizedBox(height: 20),
                ScreensHeader(
                  mainTitle: 'Trips',
                  title: "No trips yet",
                  subtitle:
                      "When you're ready to plan your next trip, we're here to help you!.",
                ),
              ],
            );
          }
          if (state is ReservationLoadingState) {
            return const ListingLoading();
          } else if (state is GetReservationsSuccessState) {
            return ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15).copyWith(top: 25),
                  child: Text(
                    'you have ${state.reservations.length} reservations in your trips',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: state.reservations.length,
                  itemBuilder: (context, index) {
                    bool isFavorite = false;

                    isFavorite =
                        context.watch<FavoriteBloc>().favoritesIds.contains(
                              state.reservations[index].listingId,
                            );
                    return ListingCard(
                      listing: state.reservations[index].listing!,
                      reservation: state.reservations[index],
                      isFavorite: isFavorite,
                      onReservationCanceled: () {
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.error,
                          animType: AnimType.rightSlide,
                          title: 'Cancel reservation',
                          desc:
                              'Are you sure you want to cancel this reservation?',
                          descTextStyle: const TextStyle(
                            fontSize: 16,
                          ),
                          btnCancelColor: Colors.black,
                          btnOkColor: Colors.pink[500],
                          btnCancelOnPress: () {},
                          btnOkOnPress: () {
                            context.read<ReservationBloc>().add(
                                  CancelReservationEvent(
                                    reservationId: state.reservations[index].id,
                                    userId: homeBloc.user!.uid,
                                  ),
                                );
                          },
                        ).show();
                      },
                      onTapFavorite: () {
                        if (isFavorite) {
                          context.read<FavoriteBloc>().add(
                                RemoveFavoriteEvent(
                                  listingId:
                                      state.reservations[index].listingId,
                                  userId: homeBloc.user!.uid,
                                ),
                              );
                          showCustomSnakeBar(
                            context: context,
                            message: "Removed from favorites",
                          );
                        } else {
                          context.read<FavoriteBloc>().add(
                                AddFavoriteEvent(
                                  listingId:
                                      state.reservations[index].listingId,
                                  userId: homeBloc.user!.uid,
                                ),
                              );
                          showCustomSnakeBar(
                            context: context,
                            message: "Added to favorites",
                          );
                        }
                        setState(() {});
                      },
                    );
                  },
                ),
              ],
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
