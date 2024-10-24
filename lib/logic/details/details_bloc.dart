import 'dart:async';

import 'package:airbnb_flutter/data/models/review_model.dart';
import 'package:airbnb_flutter/data/models/user_model.dart';
import 'package:airbnb_flutter/data/repositories/details/get_host_data_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'details_event.dart';
part 'details_state.dart';

class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  final GetHostDataRepository getHostData;

  DetailsBloc({
    required this.getHostData,
  }) : super(DetailsInitialState()) {
    on<GetHostAndReviewsDetailsEvent>(_getHostAndReviewsData);
  }
  FutureOr<void> _getHostAndReviewsData(
    GetHostAndReviewsDetailsEvent event,
    Emitter<DetailsState> emit,
  ) async {
    emit(DetailsLoadingState());

    try {
      UserModel host = await getHostData.getHostDataById(event.hostId);
      List<ReviewModel> reviews =
          await getHostData.getReviewsByHostId(event.hostId);

      double totalRate = 0.0, averageRating = 0.0;

      // Using forEach to calculate totalRate
      for (var e in reviews) {
        totalRate += e.rate;
      }

      // Calculate the average, ensuring no division by zero
      if (reviews.isNotEmpty) {
        averageRating = totalRate / reviews.length;
      }

      emit(
        DetailsLoadedState(
          host: host,
          reviews: reviews,
          avarageRating: averageRating.toStringAsFixed(1),
        ),
      );
    } catch (e) {
      emit(DetailsErrorState(message: e.toString()));
    }
  }
}
