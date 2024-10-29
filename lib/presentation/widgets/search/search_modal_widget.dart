import 'package:airbnb_flutter/core/constants/app_constants.dart';
import 'package:airbnb_flutter/core/widgets/custom_button.dart';
import 'package:airbnb_flutter/logic/explore/explore_bloc.dart';
import 'package:airbnb_flutter/presentation/widgets/custom_date_range_picker.dart';
import 'package:airbnb_flutter/presentation/widgets/search/bottom_actions.dart';
import 'package:airbnb_flutter/presentation/widgets/search/country_picker_widget.dart';
import 'package:airbnb_flutter/presentation/widgets/search/expandable_section.dart';
import 'package:airbnb_flutter/presentation/widgets/search/gustes_counter_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_date_pickers/flutter_date_pickers.dart' as dp;
import 'package:intl/intl.dart';

class SearchModalWidget extends StatefulWidget {
  final ExploreBloc exploreBloc;
  const SearchModalWidget({super.key, required this.exploreBloc});

  @override
  State<SearchModalWidget> createState() => _SearchModalWidgetState();
}

class _SearchModalWidgetState extends State<SearchModalWidget> {
  bool isPlaceExpanded = true;
  bool isDateExpanded = false;
  bool isGuestExpanded = false;

  // Place selection
  String selectedCountry = 'Choose a country';
  String selectedCountryCode = '';
  String selectedRegion = '';

  // Date selection
  String selectedCheckInDate = '';
  DateTimeRange? selectedDateRange;
  final DateTime _firstDate = DateTime.now();
  final DateTime _lastDate = DateTime(DateTime.now().year + 2);
  final dp.DatePeriod _initialPeriod = dp.DatePeriod(
    DateTime.now(),
    DateTime.now(),
  );

  // Guest selection
  final ValueNotifier<int> guestsCounter = ValueNotifier(0);
  final ValueNotifier<int> roomsCounter = ValueNotifier(0);
  final ValueNotifier<int> bathroomsCounter = ValueNotifier(0);

  // Helper function to format date range
  String formatDateRange(DateTimeRange range) {
    final DateFormat formatter = DateFormat('MMM dd');
    return '${formatter.format(range.start)} - ${formatter.format(range.end)}';
  }

  void toggleSection(String section) {
    setState(() {
      isPlaceExpanded = section == 'place';
      isDateExpanded = section == 'date';
      isGuestExpanded = section == 'guest';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Align(
          alignment: Alignment.topLeft,
          child: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.close),
          ),
        ),
        Expanded(
          child: ListView(
            padding:
                const EdgeInsets.symmetric(horizontal: 15).copyWith(top: 25),
            children: [
              //! Place Selection Section
              ExpandableSection(
                isExpanded: isPlaceExpanded,
                title: 'Where to?',
                selectedValue: selectedRegion != '' &&
                        selectedCountry == 'Choose a country'
                    ? selectedRegion
                    : selectedCountry,
                onTap: () => toggleSection('place'),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CountryPickerWidget(
                      selectedCountry: selectedCountry,
                      onCountrySelected: (country) {
                        setState(() {
                          selectedCountry = country['name']!;
                          selectedCountryCode = country['code']!;
                          toggleSection('date');
                        });
                      },
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 160,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: AppConstants.regions.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                for (var element in AppConstants.regions) {
                                  element['isSelected'] = false;
                                }
                                AppConstants.regions[index]['isSelected'] =
                                    true;
                                selectedRegion =
                                    AppConstants.regions[index]['label'];
                                toggleSection('date');
                                setState(() {});
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    margin: const EdgeInsetsDirectional.only(
                                      end: 15,
                                      bottom: 8,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        color: AppConstants.regions[index]
                                                ['isSelected']
                                            ? Colors.black
                                            : Colors.grey.shade300,
                                      ),
                                    ),
                                    child: Image.asset(
                                      AppConstants.regions[index]['image'],
                                      width: 140,
                                      height: 130,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  Text(
                                    AppConstants.regions[index]['label'],
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                    ),
                  ],
                ),
              ),
              //! Date Picker Section
              ExpandableSection(
                isExpanded: isDateExpanded,
                title: 'When\'s your trip?',
                height: 460,
                selectedValue: selectedCheckInDate.isNotEmpty
                    ? selectedCheckInDate
                    : 'Any week',
                onTap: () => toggleSection('date'),
                child: Container(
                  padding: const EdgeInsets.only(top: 10),
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomDateRangePicker(
                        firstDate: _firstDate,
                        lastDate: _lastDate,
                        initialSelectedPeriod: _initialPeriod,
                        onDateRangeChanged: (dp.DatePeriod newPeriod) {
                          // setState(() {
                          selectedDateRange = DateTimeRange(
                            start: newPeriod.start,
                            end: newPeriod.end,
                          );
                          selectedCheckInDate =
                              formatDateRange(selectedDateRange!);
                          // });
                        },
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: CustomButton(
                          text: 'Next',
                          onTap: () {
                            toggleSection('guest');
                          },
                          width: 80,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              //! Guest Count Section
              ExpandableSection(
                isExpanded: isGuestExpanded,
                title: 'Who\'s coming?',
                selectedValue: 'Add Guests',
                onTap: () => toggleSection('guest'),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GustesCounterWidget(
                      title: 'Guest',
                      subTitle: 'How many guests?',
                      counterNotifier: guestsCounter,
                    ),
                    GustesCounterWidget(
                      title: 'Rooms',
                      subTitle: 'How many rooms?',
                      counterNotifier: roomsCounter,
                    ),
                    GustesCounterWidget(
                      title: 'Bathrooms',
                      subTitle: 'How many bathrooms?',
                      counterNotifier: bathroomsCounter,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        BottomActions(
          onClear: () {
            selectedCountry = 'Choose a country';
            selectedRegion = '';
            selectedCheckInDate = '';
            guestsCounter.value = 0;
            roomsCounter.value = 0;
            bathroomsCounter.value = 0;
            toggleSection('place');
          },
          onSearch: () {
            Navigator.pop(context);
            widget.exploreBloc.add(
              OnListingsSearchEvent(
                locationValue: selectedCountryCode,
                category: selectedCountry,
                startDate: selectedDateRange!.start,
                endDate: selectedDateRange!.end,
                guestCount: guestsCounter.value,
                roomCount: roomsCounter.value,
                bathroomCount: bathroomsCounter.value,
              ),
            );
          },
        ),
      ],
    );
  }
}
