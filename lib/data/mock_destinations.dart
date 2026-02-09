import '../models/destination.dart';
import '../models/rating.dart';

/// Mock data layer for destinations
class MockDestinations {
  // Best Destinations - Premium, highly rated destinations
  static final List<Destination> bestDestinations = [
    const Destination(
      name: 'Maldives Beach',
      location: 'Maldives',
      rating: Rating(rate: 4.9, people: 2451),
      about:
          'Experience paradise on Earth with crystal clear turquoise waters, overwater bungalows, and pristine white sandy beaches. The Maldives offers world-class diving, snorkeling, and ultimate relaxation.',
      pictures: ['assets/images/destinations/maldives_beach.png'],
      isFavorite: true,
      price: 2500,
    ),
    const Destination(
      name: 'Santorini',
      location: 'Greece',
      rating: Rating(rate: 4.8, people: 3124),
      about:
          'Iconic white and blue domed buildings cascading down cliffs overlooking the deep blue Aegean Sea. Famous for stunning sunsets, romantic atmosphere, and Mediterranean cuisine.',
      pictures: ['assets/images/destinations/santorini_greece.png'],
      isFavorite: true,
      price: 1800,
    ),
    const Destination(
      name: 'Swiss Alps',
      location: 'Switzerland',
      rating: Rating(rate: 4.9, people: 1876),
      about:
          'Majestic snow-capped peaks, crystal clear alpine lakes, and charming wooden chalets. Perfect for skiing, hiking, and experiencing breathtaking mountain scenery.',
      pictures: ['assets/images/destinations/swiss_alps.png'],
      isFavorite: false,
      price: 2200,
    ),
    const Destination(
      name: 'Kyoto',
      location: 'Japan',
      rating: Rating(rate: 4.7, people: 2890),
      about:
          'Ancient temples, traditional gardens, and stunning cherry blossoms. Experience the heart of Japanese culture with geisha districts, tea ceremonies, and zen gardens.',
      pictures: ['assets/images/destinations/kyoto_japan.png'],
      isFavorite: true,
      price: 1600,
    ),
  ];

  // Popular Destinations - Trending and most visited
  static final List<Destination> popularDestinations = [
    const Destination(
      name: 'Paris',
      location: 'France',
      rating: Rating(rate: 4.8, people: 5420),
      about:
          'The City of Light features the iconic Eiffel Tower, world-class museums, charming cafes, and romantic ambiance. A must-visit for art, culture, and cuisine lovers.',
      pictures: ['assets/images/destinations/paris_eiffel.png'],
      isFavorite: true,
      price: 1400,
    ),
    const Destination(
      name: 'Dubai',
      location: 'UAE',
      rating: Rating(rate: 4.6, people: 4210),
      about:
          'A city of superlatives featuring the Burj Khalifa, luxury shopping, futuristic architecture, and desert adventures. Experience ultimate luxury and modern marvels.',
      pictures: ['assets/images/destinations/dubai_skyline.png'],
      isFavorite: false,
      price: 1900,
    ),
    const Destination(
      name: 'Sydney',
      location: 'Australia',
      rating: Rating(rate: 4.7, people: 3150),
      about:
          'Home to the iconic Opera House and Harbour Bridge. Enjoy beautiful beaches, vibrant culture, and unique wildlife experiences.',
      pictures: ['assets/images/destinations/sydney_opera.png'],
      isFavorite: false,
      price: 2100,
    ),
    const Destination(
      name: 'Rio de Janeiro',
      location: 'Brazil',
      rating: Rating(rate: 4.5, people: 2780),
      about:
          'The Marvelous City features Christ the Redeemer, stunning beaches, vibrant carnival culture, and dramatic mountain scenery.',
      pictures: ['assets/images/destinations/rio_de_janeiro.png'],
      isFavorite: true,
      price: 1300,
    ),
  ];

  // Cheap/Budget Destinations - Affordable travel options
  static final List<Destination> cheapDestinations = [
    const Destination(
      name: 'Bali',
      location: 'Indonesia',
      rating: Rating(rate: 4.7, people: 4560),
      about:
          'Tropical paradise with lush rice terraces, ancient temples, and stunning beaches. Known for affordable luxury, yoga retreats, and vibrant culture.',
      pictures: ['assets/images/destinations/bali_indonesia.png'],
      isFavorite: true,
      price: 650,
    ),
    const Destination(
      name: 'Machu Picchu',
      location: 'Peru',
      rating: Rating(rate: 4.8, people: 2340),
      about:
          'Ancient Incan citadel nestled high in the Andes Mountains. A UNESCO World Heritage site offering breathtaking views and rich history.',
      pictures: ['assets/images/destinations/machu_picchu_peru.png'],
      isFavorite: false,
      price: 750,
    ),
    const Destination(
      name: 'Great Wall',
      location: 'China',
      rating: Rating(rate: 4.6, people: 3890),
      about:
          'One of the greatest wonders of the world, stretching over 13,000 miles. Experience ancient history and spectacular mountain views.',
      pictures: ['assets/images/destinations/great_wall_china.png'],
      isFavorite: false,
      price: 600,
    ),
    const Destination(
      name: 'Venice',
      location: 'Italy',
      rating: Rating(rate: 4.7, people: 3210),
      about:
          'The floating city of canals, gondolas, and Renaissance architecture. Explore winding waterways and historic piazzas.',
      pictures: ['assets/images/destinations/venice_italy.png'],
      isFavorite: true,
      price: 850,
    ),
  ];

  // Adventure Destinations - For thrill seekers
  static final List<Destination> adventureDestinations = [
    const Destination(
      name: 'Grand Canyon',
      location: 'USA',
      rating: Rating(rate: 4.9, people: 2890),
      about:
          'One of the world\'s most spectacular natural wonders. Experience hiking, rafting, and breathtaking views of layered red rocks.',
      pictures: ['assets/images/destinations/grand_canyon_usa.png'],
      isFavorite: true,
      price: 900,
    ),
    const Destination(
      name: 'Iceland Aurora',
      location: 'Iceland',
      rating: Rating(rate: 4.8, people: 1540),
      about:
          'Witness the magical Northern Lights, explore glaciers, geysers, and volcanic landscapes. A unique adventure destination.',
      pictures: ['assets/images/destinations/iceland_aurora.png'],
      isFavorite: false,
      price: 1500,
    ),
  ];

  // Get all destinations combined
  static List<Destination> get allDestinations => [
    ...bestDestinations,
    ...popularDestinations,
    ...cheapDestinations,
    ...adventureDestinations,
  ];

  // Get favorite destinations
  static List<Destination> get favoriteDestinations =>
      allDestinations.where((d) => d.isFavorite).toList();
}
