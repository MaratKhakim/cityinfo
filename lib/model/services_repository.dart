import 'service.dart';

class ServicesRepository {
  static List<Service> loadServices() {
    /*var allServices = <Service>[
      Service(name: 'Taxi', imageUrl: 'assets/taxi.png'),
      Service(name: 'Restaurants',imageUrl:  'assets/restaurants.jpg'),
      Service(name: 'Sport',imageUrl:  'assets/sport.png'),
      Service(name: 'Service',imageUrl:  'assets/service.png'),
      Service(name: 'Hotel',imageUrl:  'assets/hotel.png'),
      Service(name: 'Online',imageUrl:  'assets/online.png'),
      Service(name: 'Culture',imageUrl:  'assets/culture.png'),
      Service(name: 'Transport',imageUrl:  'assets/transport.png'),
  ];*/
    var url = 'http://handbook.uz/images/service_logo';
    var allServices = <Service>[
      Service(name: 'Taxi', imageUrl: '$url/logo_taxi.png'),
      Service(name: 'Restaurants',imageUrl:  '$url/logo_cafe.png'),
      Service(name: 'Supermarket',imageUrl:  '$url/logo_supermarket.png'),
      Service(name: 'Sport',imageUrl:  '$url/logo_sport.png'),
      Service(name: 'Transport',imageUrl:  '$url/logo_transport.png'),
      Service(name: 'Service',imageUrl:  '$url/logo_service.png'),
      Service(name: 'Hotel',imageUrl:  '$url/logo_hotel.png'),
      Service(name: 'Culture',imageUrl:  '$url/logo_culture.png'),
    ];
    return allServices;
}
}