import 'package:flutter/material.dart';

import '../model/category.dart';
import '../network/network.dart';
import '../widget/list_components.dart';
import '../widget/loading_circle.dart';
import '../widget/slide_components.dart';

class ServiceListScreen extends StatefulWidget {
  static const routName = '/service_list_screen';

  @override
  _ServiceListScreenState createState() => _ServiceListScreenState();
}

class _ServiceListScreenState extends State<ServiceListScreen> {
  Widget _buildBody(AsyncSnapshot<List<dynamic>> snapshot, int index) {

    print('snapshot: ${snapshot.connectionState} and ${snapshot.hasError}');
    if (snapshot.connectionState != ConnectionState.none && !snapshot.hasData) {
      return LoadingCircle();
    }
    final List<Category> _categories =
        snapshot.data.map((i) => Category.fromJson(i)).toList();
    return index & 1 == 0
        ? ListComponents(_categories)
        : SlideComponents(_categories);
  }

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;

    final String title = routeArgs['title'];
    final int _cityId = int.tryParse(routeArgs['cityId']);
    final int _index = int.tryParse(routeArgs['index']);

    return FutureBuilder(
      future: Network.fetchService(_cityId, _index),
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
        return Scaffold(
          appBar: AppBar(
            title: Text(title),
          ),
          body: _buildBody(snapshot, _index),
        );
      },
    );
  }
}
