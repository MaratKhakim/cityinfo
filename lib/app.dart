import 'package:flutter/material.dart';

import 'widget/main_drawer.dart';
import 'widget/service_card.dart';

class MyHomePage extends StatefulWidget {

  static const routName = '/homepage';

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int cityId = 2;

  Map<int, String> _mapCities = {
    1: 'Kokand',
    2: 'Tashkent',
    3: 'Ferghana',
    4: 'Andijan',
    5: 'Namangan',
  };

  List<Widget> _buildMenu(context) {
    return List.generate(
      5,
      (int index) => ListTile(
        title: Text(_mapCities[index + 1]),
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
    List<Widget> cards =
        List.generate(count, (int index) => ServiceCard(cityId, ++index));
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
          Center(child: Text(_mapCities[cityId])),
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
