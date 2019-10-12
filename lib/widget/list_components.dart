import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../model/category.dart';
import '../network/network.dart';
import '../screen/category_screen.dart';
import '../model/service.dart';
import '../model/services_repository.dart';

class ListComponents extends StatelessWidget {
  final List<Category> _categories;
  final int _serviceIndex;

  ListComponents(this._categories, this._serviceIndex);

  @override
  Widget build(BuildContext context) {
    final List<Service> services = ServicesRepository.loadServices(context);

    return Padding(
      padding: EdgeInsets.all(8),
      child: ListView.builder(
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CategoryScreen(_categories[index]),
                ),
              );
            },
            child: Card(
              elevation: 6,
              child: ListTile(
                leading: Hero(
                  tag: _categories[index].name,
                  child: FadeInImage.assetNetwork(
                    placeholder: services[_serviceIndex-1].imageUrl,
                    image: '${Network.imageURL}/${_categories[index].imageUrl}',
                  ),
                ),
                title: Text(
                  _categories[index].name,
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  _categories[index].address,
                  maxLines: 1,
                ),
                trailing: IconButton(
                  icon: Icon(
                    Icons.call,
                    color: Colors.blue,
                  ),
                  onPressed: () {
                    canLaunch('tel:${_categories[index].phoneNumber}')
                        .then((_) {
                      launch('tel:${_categories[index].phoneNumber}')
                          .catchError((_) {
                            throw 'Could not launch phone call';
                        },
                      );
                    });
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
