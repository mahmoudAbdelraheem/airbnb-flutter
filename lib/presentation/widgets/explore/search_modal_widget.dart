import 'package:airbnb_flutter/core/widgets/custom_button.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';

class SearchModalWidget extends StatefulWidget {
  const SearchModalWidget({super.key});

  @override
  State<SearchModalWidget> createState() => _SearchModalWidgetState();
}

class _SearchModalWidgetState extends State<SearchModalWidget> {
  double expandedContainerHeight = 300;
  double collapsedContainerHeight = 60;
  bool isPlaceExpanded = true;
  bool isDateExpanded = false;
  bool isGuestExpanded = false;
  String selectedCountry = 'Choose a country';

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
      children: [
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
                selectedValue: selectedCountry,
                onTap: () => toggleSection('place'),
                child: CountryPickerWidget(
                  selectedCountry: selectedCountry,
                  onCountrySelected: (country) {
                    selectedCountry = country;
                    toggleSection('date');
                  },
                ),
              ),
              //! Date Picker Section
              ExpandableSection(
                isExpanded: isDateExpanded,
                title: 'When\'s your trip?',
                selectedValue:
                    'Any week', // This can be updated with the selected date
                onTap: () => toggleSection('date'),
                child: const Text('Date Picker Placeholder'),
              ),
              //! Guest Count Section
              ExpandableSection(
                isExpanded: isGuestExpanded,
                title: 'Who\'s coming?',
                selectedValue: 'Add Guests',
                onTap: () => toggleSection('guest'),
                child: const Text('Guest Picker Placeholder'),
              ),
            ],
          ),
        ),
        BottomActions(
          onClear: () {
            // TODO: Implement clear functionality
          },
          onSearch: () {
            // TODO: Implement search functionality
          },
        ),
      ],
    );
  }
}

// Widget to handle expandable sections
class ExpandableSection extends StatelessWidget {
  final bool isExpanded;
  final String title;
  final String selectedValue;
  final VoidCallback onTap;
  final Widget child;

  const ExpandableSection({
    super.key,
    required this.isExpanded,
    required this.title,
    required this.selectedValue,
    required this.onTap,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        height: isExpanded ? 300 : 60,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: isExpanded
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  child,
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title.toLowerCase(),
                    style: const TextStyle(fontSize: 15, color: Colors.grey),
                  ),
                  Text(
                    selectedValue,
                    style: const TextStyle(fontSize: 15, color: Colors.black),
                  ),
                ],
              ),
      ),
    );
  }
}

// Widget for Country Picker
class CountryPickerWidget extends StatelessWidget {
  final String selectedCountry;
  final ValueChanged<String> onCountrySelected;

  const CountryPickerWidget({
    super.key,
    required this.selectedCountry,
    required this.onCountrySelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showCountryPicker(
          context: context,
          showPhoneCode: false,
          onSelect: (Country country) {
            onCountrySelected(country.name);
          },
        );
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.black, width: 1.2),
        ),
        child: Text(
          selectedCountry,
          style: const TextStyle(color: Colors.black, fontSize: 16),
        ),
      ),
    );
  }
}

// Widget for Bottom Action Buttons
class BottomActions extends StatelessWidget {
  final VoidCallback onClear;
  final VoidCallback onSearch;

  const BottomActions({
    super.key,
    required this.onClear,
    required this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Colors.grey.shade300),
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            onPressed: onClear,
            child: const Text(
              'Clear all',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
                decorationThickness: 2,
                color: Colors.black,
              ),
            ),
          ),
          CustomButton(
            text: 'Search',
            width: 100,
            onTap: onSearch,
          ),
        ],
      ),
    );
  }
}
