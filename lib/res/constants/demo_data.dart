

import '../../data/models/service_models.dart';
import 'media_constants.dart';

class DemoData {
  static const userName = 'Jane';

  static const _defaultAbout =
      'Hi, I’m a professional service provider with years of experience delivering top-quality services across Dubai.';
  static const _defaultAddress = 'Villa 27, Street 12, Al Barsha 2, Dubai';
  static const _gallery = [
    MediaConstants.gallery1,
    MediaConstants.gallery2,
    MediaConstants.gallery3,
  ];
  static const _certs = [MediaConstants.cert1, MediaConstants.cert2];

  static const services = [
    ServiceItem(title: 'Cleaning', icon: MediaConstants.cleaningIcon),
    ServiceItem(title: 'Carpentry', icon: MediaConstants.carpenterIcon),
    ServiceItem(title: 'Laundry', icon: MediaConstants.laundryIcon),
    ServiceItem(title: 'Painting', icon: MediaConstants.paintingIcon),
    ServiceItem(title: 'Logistics', icon: MediaConstants.logisticIcon),
    ServiceItem(title: 'Cooking', icon: MediaConstants.cookingIcon),
    ServiceItem(
      title: 'Electric work',
      icon: MediaConstants.serviceElectric,
      useImage: true,
    ),
    ServiceItem(title: 'Plumbing', icon: MediaConstants.plumbingIcon),
  ];

  static const topProviders = [
    ProviderItem(
      id: 'sam',
      name: 'Sam Davies',
      image: MediaConstants.providerSam,
      heroImage: MediaConstants.detailHero,
      rating: 4.9,
      reviewsLabel: '(1,200 reviews)',
      price: '\$22/hr',
      tags: ['Cooking', 'Laundry', 'Cleaning', 'Painting'],
      bookmarked: true,
      about:
          'Hi, I’m Sam Davies — a professional cook and laundry specialist with over 5 years of experience delivering top-quality home services across Dubai.',
      address: _defaultAddress,
      staffCount: '8 staffs',
      totalBookings: '24',
      servicesCount: '4',
      serviceChips: ['Cooking', 'Laundry', 'Cleaning'],
      gallery: _gallery,
      certifications: _certs,
      fullyBooked: true,
    ),
    ProviderItem(
      id: 'jonathan',
      name: 'Jonathan Ken',
      image: MediaConstants.providerJonathan,
      heroImage: MediaConstants.gallery1,
      rating: 4.9,
      reviewsLabel: '(1,575 reviews)',
      price: '\$30/hr',
      tags: ['Electric work', 'Cleaning', 'AC repair'],
      about:
          'Hi, I’m Jonathan Ken — a professional home cleaner with over 4 years of experience delivering top-quality cleaning services across Dubai.',
      address: _defaultAddress,
      staffCount: '12 staffs',
      totalBookings: '10',
      servicesCount: '3',
      serviceChips: ['Cooking', 'Plumbing', 'Laundry'],
      gallery: _gallery,
      certifications: _certs,
      fullyBooked: true,
    ),
    ProviderItem(
      id: 'jane',
      name: 'Jane Doe',
      image: MediaConstants.providerJaneDoe,
      heroImage: MediaConstants.gallery2,
      rating: 4.9,
      reviewsLabel: '(980 reviews)',
      price: '\$28/hr',
      tags: ['Carpentry', 'Cooking'],
      about:
          'Hi, I’m Jane Doe — a skilled carpenter and cook offering reliable home services with a focus on quality and care.',
      address: _defaultAddress,
      staffCount: '5 staffs',
      totalBookings: '18',
      servicesCount: '2',
      serviceChips: ['Carpentry', 'Cooking'],
      gallery: _gallery,
      certifications: _certs,
      fullyBooked: false,
    ),
    ProviderItem(
      id: 'david',
      name: 'David Cook',
      image: MediaConstants.providerDavid,
      heroImage: MediaConstants.gallery3,
      rating: 4.9,
      reviewsLabel: '(1,100 reviews)',
      price: '\$25/hr',
      tags: ['Plumbing', 'AC repair'],
      about:
          'Hi, I’m David Cook — a plumbing and AC repair specialist with hands-on experience across Dubai.',
      address: _defaultAddress,
      staffCount: '6 staffs',
      totalBookings: '15',
      servicesCount: '2',
      serviceChips: ['Plumbing', 'AC repair'],
      gallery: _gallery,
      certifications: _certs,
      fullyBooked: false,
    ),
  ];

  static const categoryProviders = [
    ProviderItem(
      id: 'jonathan_list',
      name: 'Jonathan Ken',
      image: MediaConstants.providerList1,
      heroImage: MediaConstants.detailHero,
      rating: 4.9,
      reviewsLabel: '(1,575 reviews)',
      price: '\$30/hr',
      tags: ['Cleaning', 'Cooking', 'Laundry'],
      bookmarked: true,
      about:
          'Hi, I’m Jonathan Ken — a professional home cleaner with over 4 years of experience delivering top-quality cleaning services across Dubai.',
      address: _defaultAddress,
      staffCount: '12 staffs',
      totalBookings: '10',
      servicesCount: '3',
      serviceChips: ['Cooking', 'Plumbing', 'Laundry'],
      gallery: _gallery,
      certifications: _certs,
      fullyBooked: true,
    ),
    ProviderItem(
      id: 'elliot',
      name: 'Elliot James',
      image: MediaConstants.providerList2,
      heroImage: MediaConstants.gallery1,
      rating: 4.5,
      reviewsLabel: '(1,100 reviews)',
      price: '\$25/hr',
      tags: ['Cleaning'],
      about:
          'Hi, I’m Elliot James — a dedicated cleaner focused on spotless homes and offices.',
      address: _defaultAddress,
      staffCount: '4 staffs',
      totalBookings: '9',
      servicesCount: '1',
      serviceChips: ['Cleaning'],
      gallery: _gallery,
      certifications: _certs,
    ),
    ProviderItem(
      id: 'sarah',
      name: 'Sarah Milner',
      image: MediaConstants.providerList3,
      heroImage: MediaConstants.gallery2,
      rating: 4.7,
      reviewsLabel: '(1,400 reviews)',
      price: '\$28/hr',
      tags: ['Cleaning', 'Laundry'],
      about:
          'Hi, I’m Sarah Milner — offering premium cleaning and laundry services across Dubai.',
      address: _defaultAddress,
      staffCount: '7 staffs',
      totalBookings: '14',
      servicesCount: '2',
      serviceChips: ['Cleaning', 'Laundry'],
      gallery: _gallery,
      certifications: _certs,
    ),
    ProviderItem(
      id: 'sam_list',
      name: 'Sam Davies',
      image: MediaConstants.providerList4,
      heroImage: MediaConstants.gallery3,
      rating: 4.6,
      reviewsLabel: '(2,200 reviews)',
      price: '\$22/hr',
      tags: ['Cooking', 'Laundry'],
      about:
          'Hi, I’m Sam Davies — a professional cook and laundry specialist with over 5 years of experience.',
      address: _defaultAddress,
      staffCount: '8 staffs',
      totalBookings: '24',
      servicesCount: '2',
      serviceChips: ['Cooking', 'Laundry'],
      gallery: _gallery,
      certifications: _certs,
      fullyBooked: true,
    ),
    ProviderItem(
      id: 'jane_mia',
      name: 'Jane Mia',
      image: MediaConstants.providerList5,
      heroImage: MediaConstants.detailHero,
      rating: 4.8,
      reviewsLabel: '(1,300 reviews)',
      price: '\$28/hr',
      tags: ['Cleaning', 'Cooking'],
      about:
          'Hi, I’m Jane Mia — providing reliable cleaning and cooking services for busy households.',
      address: _defaultAddress,
      staffCount: '3 staffs',
      totalBookings: '11',
      servicesCount: '2',
      serviceChips: ['Cleaning', 'Cooking'],
      gallery: _gallery,
      certifications: _certs,
    ),
  ];

  static ProviderItem detailFor(ProviderItem provider) {
    if (provider.about.isNotEmpty) return provider;
    return ProviderItem(
      id: provider.id,
      name: provider.name,
      image: provider.image,
      heroImage: provider.resolvedHero,
      rating: provider.rating,
      reviewsLabel: provider.reviewsLabel,
      price: provider.price,
      tags: provider.tags,
      bookmarked: provider.bookmarked,
      about: 'Hi, I’m ${provider.name} — $_defaultAbout',
      address: _defaultAddress,
      staffCount: '12 staffs',
      totalBookings: '10',
      servicesCount: '${provider.tags.isEmpty ? 3 : provider.tags.length}',
      serviceChips: provider.tags.isEmpty
          ? const ['Cooking', 'Plumbing', 'Laundry']
          : provider.tags.take(3).toList(),
      gallery: _gallery,
      certifications: _certs,
      fullyBooked: provider.fullyBooked,
    );
  }
}
