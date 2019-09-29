import 'package:flutter/material.dart';

import '../model/restaurant.dart';
import '../screen/restaurants_screen.dart';
import '../network/network.dart';

class ListComponents extends StatelessWidget {

  final List<Restaurant> _restaurants;

  ListComponents(this._restaurants);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: ListView.builder(
        itemCount: _restaurants.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RestaurantScreen(_restaurants[index]),
                ),
              );
            },
            child: Card(
              elevation: 6,
              child: ListTile(
                leading: Hero(
                  tag: _restaurants[index].name,
                  child: Image.network('${Network.imageURL}/${_restaurants[index].imageUrl}'),
                ),
                title: Text(
                  _restaurants[index].name,
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  _restaurants[index].address,
                  maxLines: 1,
                ),
                trailing: Icon(
                  Icons.call,
                  color: Colors.blue,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
