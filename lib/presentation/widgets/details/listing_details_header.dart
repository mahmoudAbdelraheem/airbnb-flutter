import 'package:airbnb_flutter/core/constants/app_constants.dart';
import 'package:airbnb_flutter/core/functions/show_custom_snake_bar.dart';
import 'package:airbnb_flutter/core/widgets/my_icon.dart';
import 'package:airbnb_flutter/logic/favorite/favorite_bloc.dart';
import 'package:airbnb_flutter/logic/home/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListingDetailsHeader extends StatefulWidget {
  final bool isFavorite;
  final String listingId;
  const ListingDetailsHeader({
    super.key,
    required this.isFavorite,
    required this.listingId,
  });

  @override
  State<ListingDetailsHeader> createState() => _ListingDetailsHeaderState();
}

class _ListingDetailsHeaderState extends State<ListingDetailsHeader> {
  @override
  Widget build(BuildContext context) {
    bool favorite = widget.isFavorite;
    FavoriteBloc favoriteBloc = BlocProvider.of<FavoriteBloc>(context);
    HomeBloc homeBloc = BlocProvider.of<HomeBloc>(context);
    return Container(
      height: 55,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MyIcon(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icons.arrow_back,
          ),
          MyIcon(
            onPressed: () {
              if (homeBloc.user == null) {
                Navigator.pushNamed(context, AppConstants.loginScreen);
              } else {
                if (favorite) {
                  favoriteBloc.add(
                    RemoveFavoriteEvent(
                      userId: homeBloc.user!.uid,
                      listingId: widget.listingId,
                    ),
                  );
                  showCustomSnakeBar(
                      context: context, message: "Removed from favorites");
                } else {
                  favoriteBloc.add(
                    AddFavoriteEvent(
                      userId: homeBloc.user!.uid,
                      listingId: widget.listingId,
                    ),
                  );
                  showCustomSnakeBar(
                      context: context, message: "Added from favorites");
                }
                setState(() {
                  favorite = !favorite;
                });
              }
            },
            icon: favorite ? Icons.favorite : Icons.favorite_border_outlined,
            color: favorite ? Colors.pink[500]! : Colors.black,
          ),
        ],
      ),
    );
  }
}
