class AppConstants {
  //! auth screens
  static const String homeScreen = '/';
  static const String loginScreen = '/login';
  static const String registerScreen = '/register';
  static const String detailsScreen = '/details';
  static const String fullMapScreen = '/fullMap';
  static const String pesonalInfoScreen = '/pesonal_info';

  //! search regions
  static List<Map<String, dynamic>> regions = [
    {
      'label': 'I\'m flexible',
      'image': 'assets/images/world.avif',
      'isSelected': true,
    },
    {
      'label': 'Africa',
      'image': 'assets/images/africa.jfif',
      'isSelected': false,
    },
    {
      'label': 'Europe',
      'image': 'assets/images/europe.jfif',
      'isSelected': false,
    },
    {
      'label': 'Astralia',
      'image': 'assets/images/australia.png',
      'isSelected': false,
    },
    {
      'label': 'North America',
      'image': 'assets/images/north_america.jfif',
      'isSelected': false,
    },
    {
      'label': 'South America',
      'image': 'assets/images/south_amercia.jfif',
      'isSelected': false,
    },
  ];
}
