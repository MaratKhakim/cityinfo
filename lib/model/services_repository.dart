import 'service.dart';

import '../utils/app_localizations.dart';

class ServicesRepository {
  static List<Service> loadServices(context) {
    var url = 'http://handbook.uz/images/service_logo';
    var allServices = <Service>[
      Service(name: AppLocalizations.of(context).translate('TAXI'), imageUrl: '$url/logo_taxi.png'),
      Service(name: AppLocalizations.of(context).translate('RESTAURANT'), imageUrl: '$url/logo_cafe.png'),
      Service(name: AppLocalizations.of(context).translate('SUPERMARKET'), imageUrl: '$url/logo_supermarket.png'),
      Service(name: AppLocalizations.of(context).translate('SPORT'), imageUrl: '$url/logo_sport.png'),
      Service(name: AppLocalizations.of(context).translate('TRANSPORT'), imageUrl: '$url/logo_transport.png'),
      Service(name: AppLocalizations.of(context).translate('SERVICE'), imageUrl: '$url/logo_service.png'),
      Service(name: AppLocalizations.of(context).translate('HOTEL'), imageUrl: '$url/logo_hotel.png'),
      Service(name: AppLocalizations.of(context).translate('CULTURE'), imageUrl: '$url/logo_culture.png'),
    ];
    return allServices;
  }
}
