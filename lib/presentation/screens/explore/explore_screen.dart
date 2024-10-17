import 'package:airbnb_flutter/core/widgets/loading.dart';
import 'package:airbnb_flutter/init_dependancies.dart';
import 'package:airbnb_flutter/logic/explore/explore_bloc.dart';
import 'package:airbnb_flutter/presentation/widgets/explore/nav_bar.dart';
import 'package:airbnb_flutter/presentation/widgets/explore/listing_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          serviceLocator<ExploreBloc>()..add(GetListingsAndCategoriesEvent()),
      child: BlocConsumer<ExploreBloc, ExploreState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return Column(children: [
            state is GetListingsAndCategoriesSuccessState
                ? NavBar(categoties: state.categories)
                : state is GetListingsAndCategoriesLoadingState
                    ? const Loading()
                    : const SizedBox(),
            state is GetListingsAndCategoriesSuccessState
                ? Expanded(
                    child: ListView.builder(
                      itemCount: state.listings.length,
                      itemBuilder: (context, index) {
                        return ListingCard(
                          listing: state.listings[index],
                        );
                      },
                    ),
                  )
                : State is GetListingsAndCategoriesLoadingState
                    ? const Loading()
                    : const SizedBox(),
          ]);
        },
      ),
    );
  }
}
