import 'package:airbnb_flutter/core/widgets/loading.dart';
import 'package:airbnb_flutter/init_dependancies.dart';
import 'package:airbnb_flutter/logic/explore/explore_bloc.dart';
import 'package:airbnb_flutter/logic/favorite/favorite_bloc.dart';
import 'package:airbnb_flutter/logic/home/home_bloc.dart';
import 'package:airbnb_flutter/presentation/widgets/explore/nav_bar.dart';
import 'package:airbnb_flutter/presentation/widgets/explore/listing_card.dart';
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
          create: (_) => serviceLocator<FavoriteBloc>()
            ..add(
              GetFavoritesEvent(
                userId: homeBloc.user!.uid,
              ),
            ),
        ),
      ],
      child: BlocConsumer<ExploreBloc, ExploreState>(
        listener: (context, state) {
          //TODO: add listener
        },
        builder: (context, state) {
          return Column(children: [
            state is GetListingsAndCategoriesSuccessState
                ? NavBar(categoties: state.categories)
                : state is GetListingsAndCategoriesLoadingState
                    ? const SizedBox(height: 150, child: Loading())
                    : const SizedBox(),
            state is GetListingsAndCategoriesSuccessState
                ? Expanded(
                    child: ListView.builder(
                      itemCount: state.listings.length,
                      itemBuilder: (context, index) {
                        bool isFavorite = false;
                        // if (homeBloc.userModel != null) {
                        //   isFavorite = homeBloc.userModel!.favoriteIds
                        //       .contains(state.listings[index].id);
                        // }
                        isFavorite =
                            context.read<FavoriteBloc>().favoritesIds.contains(
                                  state.listings[index].id,
                                );

                        return ListingCard(
                          listing: state.listings[index],
                          isFavorite: isFavorite,
                          onTapFavorite: () {
                            if (isFavorite) {
                              context.read<FavoriteBloc>().add(
                                    RemoveFavoriteEvent(
                                      listingId: state.listings[index].id,
                                      userId: homeBloc.user!.uid,
                                    ),
                                  );
                            } else {
                              context.read<FavoriteBloc>().add(
                                    AddFavoriteEvent(
                                      listingId: state.listings[index].id,
                                      userId: homeBloc.user!.uid,
                                    ),
                                  );
                            }
                            setState(() {});
                          },
                        );
                      },
                    ),
                  )
                : State is GetListingsAndCategoriesLoadingState
                    ? const Expanded(child: SizedBox(child: Loading()))
                    : const SizedBox(),
          ]);
        },
      ),
    );
  }
}
