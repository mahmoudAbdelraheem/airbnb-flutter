import 'package:airbnb_flutter/core/functions/show_custom_snake_bar.dart';
import 'package:airbnb_flutter/core/widgets/custom_button.dart';
import 'package:airbnb_flutter/core/widgets/listing_loding.dart';
import 'package:airbnb_flutter/data/models/listing_model.dart';
import 'package:airbnb_flutter/init_dependancies.dart';
import 'package:airbnb_flutter/logic/favorite/favorite_bloc.dart';
import 'package:airbnb_flutter/logic/home/home_bloc.dart';
import 'package:airbnb_flutter/presentation/widgets/explore/listing_card.dart';
import 'package:airbnb_flutter/presentation/widgets/screens_header.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeBloc homeBloc = BlocProvider.of<HomeBloc>(context);
    List<ListingModel> favorites = [];
    return BlocProvider(
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
      child: BlocConsumer<FavoriteBloc, FavoriteState>(
        listener: (context, state) {
          if (state is GetFavoritesSuccessState) {
            favorites = state.favoriteListings;
          }
        },
        builder: (context, state) {
          return state is FavoriteLoadingState
              ? const ListingLoading()
              : state is GetFavoritesSuccessState && favorites.isEmpty
                  ? ListView(
                      padding: const EdgeInsets.all(15),
                      children: [
                        const SizedBox(height: 20),
                        const Text(
                          'your wishlist is empty\n\nadd some places to your wishlist to start planning your next trip',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        CustomButton(
                          text: 'add a place',
                          onTap: () {
                            homeBloc.add(
                              HomeOnPageChangedEvent(index: 0),
                            );
                          },
                        ),
                      ],
                    )
                  : state is GetFavoritesSuccessState && favorites.isNotEmpty
                      ? ListView(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.all(15).copyWith(top: 25),
                              child: Text(
                                'you have ${favorites.length} places in your wishlist',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: favorites.length,
                                itemBuilder: (context, index) {
                                  return ListingCard(
                                    listing: favorites[index],
                                    isFavorite: true,
                                    onTapFavorite: () {
                                      context.read<FavoriteBloc>().add(
                                            RemoveFavoriteEvent(
                                              listingId: favorites[index].id,
                                              userId: homeBloc.user!.uid,
                                            ),
                                          );

                                      context.read<FavoriteBloc>().add(
                                            GetFavoritesEvent(
                                              userId: homeBloc.user!.uid,
                                            ),
                                          );
                                      showCustomSnakeBar(
                                        context: context,
                                        message: "Removed from favorites",
                                      );
                                    },
                                  );
                                }),
                          ],
                        )
                      : homeBloc.user == null
                          ? ListView(
                              padding: const EdgeInsets.all(15),
                              children: const [
                                SizedBox(height: 20),
                                ScreensHeader(
                                  mainTitle: 'Wishlists',
                                  title: "Login to view your wishlists",
                                  subtitle:
                                      "you cat create, view, or edit your wishlist once you've logged in.",
                                ),
                              ],
                            )
                          : const SizedBox();
        },
      ),
    );
  }
}
