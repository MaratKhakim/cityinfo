import 'package:flutter/material.dart';

import '../model/category.dart';
import '../network/network.dart';
import '../screen/category_screen.dart';

class ListComponents extends StatelessWidget {
  final List<Category> _categories;

  ListComponents(this._categories);

  @override
  Widget build(BuildContext context) {
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
                  child: Image.network(
                      '${Network.imageURL}/${_categories[index].imageUrl}'),
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
