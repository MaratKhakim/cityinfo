import 'package:flutter/material.dart';

import '../model/restaurant.dart';
import '../widget/list_components.dart';
import '../widget/slide_components.dart';

class ServiceListScreen extends StatelessWidget {

  static const routName = '/service_list_screen';

  @override
  Widget build(BuildContext context) {

    final routeArgs = ModalRoute.of(context).settings.arguments as Map<String, dynamic> ;

    final String title = routeArgs['title'];
    final int index = int.tryParse(routeArgs['index']);

    final List<dynamic> _services = routeArgs['serviceList'];
    final List<Restaurant> _restaurants = _services.map((i) => Restaurant.fromJson(i)).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: index & 1 == 0 ? ListComponents(_restaurants) : SlideComponents(_restaurants),
    );
  }
}
