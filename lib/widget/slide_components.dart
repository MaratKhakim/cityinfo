/**
  @author: devefy
  This code is taken from https://github.com/devefy/Flutter-Story-App-UI
*/

import 'package:flutter/material.dart';
import 'dart:math';

import '../model/category.dart';
import '../network/network.dart';

var cardAspectRatio = 12.0 / 20.0;
//var cardAspectRatio = MediaQuery.of(context).size.width/MediaQuery.of(context).size.height;
var widgetAspectRatio = cardAspectRatio * 1.2;
var currentPage;

class SlideComponents extends StatefulWidget {
  final List<Category> _restaurants;

  SlideComponents(this._restaurants) {
    currentPage = _restaurants.length - 1.0;
  }

  @override
  _SlideComponentsState createState() => _SlideComponentsState();
}

class _SlideComponentsState extends State<SlideComponents> {
  @override
  Widget build(BuildContext context) {
    PageController controller =
        PageController(initialPage: widget._restaurants.length - 1);
    controller.addListener(() {
      setState(() {
        currentPage = controller.page;
      });
    });

    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        //color: Colors.deepOrange[200],
        gradient: LinearGradient(
            colors: [
              Color(0xFF1b1e44),
              Color(0xFF2d3447),
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            tileMode: TileMode.clamp),
      ),
      child: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            CardScrollWidget(widget._restaurants, currentPage),
            Positioned.fill(
              child: PageView.builder(
                itemCount: widget._restaurants.length,
                controller: controller,
                reverse: true,
                itemBuilder: (context, index) {
                  return Container();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CardScrollWidget extends StatelessWidget {
  var currentPage;
  var padding = 20.0;
  var verticalInset = 20.0;

  final List<Category> _restaurants;

  CardScrollWidget(this._restaurants, this.currentPage);

  @override
  Widget build(BuildContext context) {
    return new AspectRatio(
      aspectRatio: widgetAspectRatio,
      child: LayoutBuilder(builder: (context, constraints) {
        var width = constraints.maxWidth;
        var height = constraints.maxHeight;

        var safeWidth = width - 2 * padding;
        var safeHeight = height - 2 * padding;

        var heightOfPrimaryCard = safeHeight;
        var widthOfPrimaryCard = heightOfPrimaryCard * cardAspectRatio;

        var primaryCardLeft = safeWidth - widthOfPrimaryCard;
        var horizontalInset = primaryCardLeft / 2;

        List<Widget> cardList = new List();

        for (var i = 0; i < _restaurants.length; i++) {
          var delta = i - currentPage;
          bool isOnRight = delta > 0;

          var start = padding +
              max(
                  primaryCardLeft -
                      horizontalInset * -delta * (isOnRight ? 15 : 1),
                  0.0);

          var cardItem = Positioned.directional(
            top: padding + verticalInset * max(-delta, 0.0),
            bottom: padding + verticalInset * max(-delta, 0.0),
            start: start,
            textDirection: TextDirection.rtl,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12,
                        offset: Offset(3.0, 6.0),
                        blurRadius: 10.0)
                  ],
                ),
                child: AspectRatio(
                  aspectRatio: cardAspectRatio,
                  child: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      //Image.asset(images[i], fit: BoxFit.cover),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                            width: 2,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(
                                top: 16.0,
                              ),
                              child: Image.network(
                                '${Network.imageURL}/${_restaurants[i].imageUrl}',
                                height: 120,
                                width: 120,
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 8.0),
                              child: Text(_restaurants[i].name,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 25.0,
                                  )),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 12.0, bottom: 12.0),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 22.0, vertical: 6.0),
                                decoration: BoxDecoration(
                                    color: Colors.blueAccent,
                                    borderRadius: BorderRadius.circular(20.0)),
                                child: Text("Read Later",
                                    style: TextStyle(color: Colors.white)),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
          cardList.add(cardItem);
        }
        return Stack(
          children: cardList,
        );
      }),
    );
  }
}
