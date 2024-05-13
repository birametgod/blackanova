class Hairdresser {
  final String name;
  final String profileImageUrl;
  final String description;
  final int rate; // Hairdresser's rate between 1 to 5 stars
  final String address; // Hairdresser's address
  final double latitude; // Latitude of the hairdresser's location
  final double longitude; // Longitude of the hairdresser's location
  final int minimumPrice;


  Hairdresser({
    required this.name,
    required this.profileImageUrl,
    required this.description,
    required this.rate,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.minimumPrice,
  });
}
