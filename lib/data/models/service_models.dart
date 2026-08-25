class ServiceItem {
  final String title;
  final String icon;
  final bool useImage;

  const ServiceItem({
    required this.title,
    required this.icon,
    this.useImage = false,
  });
}

class ProviderItem {
  final String id;
  final String name;
  final String image;
  final String heroImage;
  final double rating;
  final String reviewsLabel;
  final String price;
  final List<String> tags;
  final bool bookmarked;
  final String about;
  final String address;
  final String staffCount;
  final String totalBookings;
  final String servicesCount;
  final List<String> serviceChips;
  final List<String> gallery;
  final List<String> certifications;
  final bool fullyBooked;

  const ProviderItem({
    required this.id,
    required this.name,
    required this.image,
    required this.rating,
    required this.reviewsLabel,
    required this.price,
    required this.tags,
    this.heroImage = '',
    this.bookmarked = false,
    this.about = '',
    this.address = '',
    this.staffCount = '',
    this.totalBookings = '',
    this.servicesCount = '',
    this.serviceChips = const [],
    this.gallery = const [],
    this.certifications = const [],
    this.fullyBooked = false,
  });

  String get resolvedHero =>
      heroImage.isNotEmpty ? heroImage : (gallery.isNotEmpty ? gallery.first : image);

  ProviderItem copyWith({bool? bookmarked}) {
    return ProviderItem(
      id: id,
      name: name,
      image: image,
      heroImage: heroImage,
      rating: rating,
      reviewsLabel: reviewsLabel,
      price: price,
      tags: tags,
      bookmarked: bookmarked ?? this.bookmarked,
      about: about,
      address: address,
      staffCount: staffCount,
      totalBookings: totalBookings,
      servicesCount: servicesCount,
      serviceChips: serviceChips,
      gallery: gallery,
      certifications: certifications,
      fullyBooked: fullyBooked,
    );
  }
}
