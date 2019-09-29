import 'package:http/http.dart' show get;
import 'dart:convert';

class Network {

  static final String URL = 'http://mwcapi1.handbook.uz/web/index.php/services';
  static final String imageURL = 'http://handbook.uz/images/service_logo';

  static Future<List<dynamic>> fetchService(int cityId, int index) async {
    var response = null;
    try {
      response = await get('$URL/$cityId?cat=$index');
    } catch (error) {

    }

    return response != null ? json.decode(response.body) : null;
  }
}