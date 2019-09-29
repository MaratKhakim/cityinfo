import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../model/restaurant.dart';
import '../network/network.dart';

class RestaurantScreen extends StatelessWidget {
  static const routName = '/restaurant';

  Restaurant _restaurant;

  RestaurantScreen(this._restaurant);

  Widget _openUrl(String scheme, String url, IconData icon) {
    return InkWell(
      child: ListTile(
        leading: Icon(
          icon,
          color: Colors.blue,
        ),
        title: Text(
          url,
          style: TextStyle(
            decoration: TextDecoration.underline,
            color: Colors.blue,
          ),
        ),
      ),
      onTap: () async {
        if (await canLaunch('$scheme:$url')) {
          await launch('$scheme:$url');
        } else {
          throw 'Could not launch $url';
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF21BFBD),
      body: Padding(
        padding: EdgeInsets.only(top: 40.0),
        child: Column(
          children: <Widget>[
            Center(
              heightFactor: 1.3,
              child: Column(
                children: <Widget>[
                  Hero(
                    tag: _restaurant.name,
                    child: Image.network(
                      '${Network.imageURL}/${_restaurant.imageUrl}',
                      height: 120,
                      width: 120,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    _restaurant.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.only(topLeft: Radius.circular(90.0)),
                ),
                child: Container(
                  decoration: BoxDecoration(
                      //color: Colors.black,
                      ),
                  width: double.infinity,
                  margin: EdgeInsets.only(left: 20, top: 40),
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        leading: Icon(Icons.location_on),
                        title: Text(_restaurant.address),
                      ),
                      _openUrl(
                          'http', _restaurant.website, Icons.open_in_browser),
                      _openUrl('mailto', _restaurant.email, Icons.email),
                      _openUrl('tel', _restaurant.phoneNumber, Icons.phone),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
