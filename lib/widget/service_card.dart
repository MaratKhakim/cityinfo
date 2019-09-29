import 'package:flutter/material.dart';

import '../model/service.dart';
import '../model/services_repository.dart';
import '../network/network.dart';
import '../screen/service_list_screen.dart';

class ServiceCard extends StatelessWidget {
  final int _index;
  final int _cityId;

  ServiceCard(this._cityId, this._index);

  List<Service> services = ServicesRepository.loadServices();

  List<dynamic> restaurants;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      elevation: 6,
      child: InkWell(
        onTap: () async {
          restaurants = await Network.fetchService(_cityId, _index);
          Navigator.of(context).pushNamed(
            ServiceListScreen.routName,
            arguments: {
              'index': _index.toString(),
              'title': services[_index - 1].name,
              'serviceList': restaurants,
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
                child: Image.network(services[_index - 1].imageUrl),
              ),
            ),
            Container(
              child: Text(
                services[_index - 1].name,
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
