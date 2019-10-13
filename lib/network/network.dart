import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'dart:convert';
import 'dart:io';

import '../model/category.dart';

class Network {

  static final String URL = 'http://mwcapi1.handbook.uz/web/index.php/services';
  static final String imageURL = 'http://handbook.uz/images/service_logo';

  static Future<List<Category>> fetchService(int cityId, int index) async {
    final File fetchedFile = await DefaultCacheManager().getSingleFile('$URL/$cityId?cat=$index');
    print(fetchedFile.path);
    List<String> list = await fetchedFile.readAsLines();

    List<dynamic> category = json.decode(list[0]);

    return category.map((i) => Category.fromJson(i)).toList();
  }
}