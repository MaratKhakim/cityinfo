import 'service.dart';

import '../utils/app_localizations.dart';

class ServicesRepository {
  static List<Service> loadServices(context) {
    var allServices = <Service>[
      Service(name: AppLocalizations.of(context).translate('TAXI'), imageUrl: 'assets/images/taxi.png'),
      Service(name: AppLocalizations.of(context).translate('RESTAURANT'), imageUrl: 'assets/images/cafe.png'),
      Service(name: AppLocalizations.of(context).translate('SUPERMARKET'), imageUrl: 'assets/images/market.png'),
      Service(name: AppLocalizations.of(context).translate('SPORT'), imageUrl: 'assets/images/sport.png'),
      Service(name: AppLocalizations.of(context).translate('TRANSPORT'), imageUrl: 'assets/images/transport.png'),
      Service(name: AppLocalizations.of(context).translate('SERVICE'), imageUrl: 'assets/images/service.png'),
      Service(name: AppLocalizations.of(context).translate('HOTEL'), imageUrl: 'assets/images/hotel.png'),
      Service(name: AppLocalizations.of(context).translate('CULTURE'), imageUrl: 'assets/images/culture.png'),
    ];
    return allServices;
  }
}
