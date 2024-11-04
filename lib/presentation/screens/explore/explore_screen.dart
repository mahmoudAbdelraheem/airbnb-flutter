import 'package:airbnb_flutter/core/constants/app_constants.dart';
import 'package:airbnb_flutter/core/functions/show_bottom_sheet_modal.dart';
import 'package:airbnb_flutter/core/functions/show_custom_snake_bar.dart';
import 'package:airbnb_flutter/core/widgets/custom_button.dart';
import 'package:airbnb_flutter/core/widgets/explore_screen_loading.dart';
import 'package:airbnb_flutter/core/widgets/listing_loding.dart';
import 'package:airbnb_flutter/init_dependancies.dart';
import 'package:airbnb_flutter/logic/explore/explore_bloc.dart';
import 'package:airbnb_flutter/logic/favorite/favorite_bloc.dart';
import 'package:airbnb_flutter/logic/home/home_bloc.dart';
import 'package:airbnb_flutter/presentation/widgets/explore/nav_bar.dart';
import 'package:airbnb_flutter/presentation/widgets/explore/listing_card.dart';
import 'package:airbnb_flutter/presentation/widgets/search/search_modal_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  @override
  Widget build(BuildContext context) {
    final HomeBloc homeBloc = BlocProvider.of<HomeBloc>(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => serviceLocator<ExploreBloc>()
            ..add(
              GetListingsAndCategoriesEvent(),
            ),
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
      child: BlocConsumer<ExploreBloc, ExploreState>(
        listener: (context, state) {
          //TODO: add listener
        },
        builder: (context, state) {
          ExploreBloc exploreBloc = BlocProvider.of<ExploreBloc>(context);
          return Column(
            children: [
              state is GetListingsAndCategoriesSuccessState
                  ? NavBar(
                      categoties: state.categories,
                      place: exploreBloc.placeValue,
                      date: exploreBloc.dateValue,
                      guest: exploreBloc.guestValue,
                      exploreBloc: exploreBloc,
                      icon: state.isSearch
                          ? Icons.arrow_back_rounded
                          : Icons.search_outlined,
                      openSearchModal: () {
                        if (state.isSearch) {
                          exploreBloc.add(
                            GetListingsAndCategoriesEvent(),
                          );
                        } else {
                          showBottomSheetModal(
                            context: context,
                            screenSize: MediaQuery.sizeOf(context),
                            child: SearchModalWidget(
                              exploreBloc: exploreBloc,
                            ),
                          );
                        }
                      })
                  : state is GetListingsAndCategoriesLoadingState
                      ? const Expanded(child: ExploreScreenLoading())
                      : const SizedBox(),
              state is GetListingsAndCategoriesSuccessState
                  ? state.listings.isEmpty
                      ? Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text(
                                  'No listing found',
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                CustomButton(
                                  text: 'Try again',
                                  onTap: () {
                                    exploreBloc.add(
                                      GetListingsAndCategoriesEvent(),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        )
                      : Expanded(
                          child: ListView.builder(
                            itemCount: state.listings.length,
                            itemBuilder: (context, index) {
                              bool isFavorite = false;

                              isFavorite = context
                                  .watch<FavoriteBloc>()
                                  .favoritesIds
                                  .contains(
                                    state.listings[index].id,
                                  );

                              return ListingCard(
                                listing: state.listings[index],
                                isFavorite: isFavorite,
                                onTapFavorite: () {
                                  if (homeBloc.user == null) {
                                    Navigator.pushNamed(
                                      context,
                                      AppConstants.loginScreen,
                                    );
                                    return;
                                  }
                                  if (isFavorite) {
                                    context.read<FavoriteBloc>().add(
                                          RemoveFavoriteEvent(
                                            listingId: state.listings[index].id,
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
                                            listingId: state.listings[index].id,
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
                        )
                  : State is GetListingsAndCategoriesLoadingState
                      ? const Expanded(
                          child: ListingLoading(),
                        )
                      : const SizedBox(),
            ],
          );
        },
      ),
    );
  }
}
