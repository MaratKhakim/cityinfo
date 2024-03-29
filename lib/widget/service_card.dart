import 'package:flutter/material.dart';

import '../model/service.dart';
import '../screen/service_list_screen.dart';

class ServiceCard extends StatelessWidget {
  final int _index;
  final int _cityId;
  final List<Service> _services;

  ServiceCard(this._services, this._cityId, this._index);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      elevation: 6,
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(
            ServiceListScreen.routName,
            arguments: {
              'index': _index.toString(),
              'title': _services[_index - 1].name,
              'cityId': _cityId.toString(),
            },
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Container(
                height: 120,
                width: 120,
                padding: EdgeInsets.all(10.0),
                child: Image.asset(_services[_index - 1].imageUrl),
              ),
            ),
            Container(
              child: Text(
                _services[_index - 1].name,
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
