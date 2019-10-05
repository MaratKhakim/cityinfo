import 'package:flutter/material.dart';

import '../model/category.dart';
import '../network/network.dart';
import '../widget/list_components.dart';
import '../widget/loading_circle.dart';
import '../widget/slide_components.dart';
import '../utils/app_localizations.dart';

class ServiceListScreen extends StatefulWidget {
  static const routName = '/service_list_screen';

  @override
  _ServiceListScreenState createState() => _ServiceListScreenState();
}

class _ServiceListScreenState extends State<ServiceListScreen> {

  void _retry() {
    setState(() {});
  }

  Widget _buildBody(AsyncSnapshot<List<dynamic>> snapshot, int index) {

    if (snapshot.connectionState != ConnectionState.done) {
      return LoadingCircle();
    }

    if (snapshot.hasData) {
      final List<Category> _categories =
          snapshot.data.map((i) => Category.fromJson(i)).toList();
      return index & 1 == 0
          ? ListComponents(_categories)
          : SlideComponents(_categories);
    } else {
      return AlertDialog(
        title: Text(AppLocalizations.of(context).translate('ERROR_OCCURED_TITLE')),
        content: Text(AppLocalizations.of(context).translate('ERROR_OCCURED_CONTENT')),
        actions: <Widget>[
          FlatButton(
            child: Text(AppLocalizations.of(context).translate('RETRY')),
            onPressed: _retry,
          )
        ],
      );
    }
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
