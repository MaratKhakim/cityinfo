import 'package:flutter/material.dart';

import 'widget/main_drawer.dart';
import 'widget/service_card.dart';
import 'model/service.dart';
import 'model/services_repository.dart';
import 'utils/app_localizations.dart';

class MyHomePage extends StatefulWidget {

  static const routName = '/homepage';

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int cityId = 2;

  Map<int, String> _mapCities = {
    1: 'KOKAND',
    2: 'TASHKENT',
    3: 'FERGHANA',
    4: 'ANDIJAN',
    5: 'NAMANGAN',
  };

  List<Widget> _buildMenu(context) {
    return List.generate(
      5,
      (int index) => ListTile(
        title: Text(AppLocalizations.of(context).translate(_mapCities[index + 1])),
        onTap: () {
          setState(() {
            cityId = index+1;
          });
          Navigator.of(context).pop();
        },
      ),
    );
  }

  List<Widget> _buildCards(BuildContext context, int count) {

    List<Service> _services = ServicesRepository.loadServices(context);

    List<Widget> cards =
        List.generate(count, (int index) => ServiceCard(_services, cityId, ++index));
    return cards;
  }

  void _showModal(BuildContext context) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16.0),
        ),
      ),
      context: context,
      builder: (BuildContext ctx) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: _buildMenu(context),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.deepPurple[200],
      appBar: AppBar(
        title: Text('City Info'),
        actions: <Widget>[
          Center(child: Text(AppLocalizations.of(context).translate(_mapCities[cityId]))),
          IconButton(
            icon: Icon(Icons.location_city),
            onPressed: () => _showModal(context),
          ),
        ],
      ),
      drawer: MainDrawer(),
      body: GridView.count(
        crossAxisCount: 2,
        padding: EdgeInsets.all(10.0),
        children: _buildCards(context, 8),
      ),
    );
  }
}
