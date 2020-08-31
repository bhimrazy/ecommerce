import 'package:flutter/material.dart';

class HorizontalList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.0,
      child: ListView(scrollDirection: Axis.horizontal, children: <Widget>[
        Category(
          imageLocation: 'assets/images/categories/tshirt.png',
          imageCaption: 'shirt',
        ),
        Category(
          imageLocation: 'assets/images/categories/shoe.png',
          imageCaption: 'shoe',
        ),
        Category(
          imageLocation: 'assets/images/categories/jeans.png',
          imageCaption: 'pants',
        ),
        Category(
          imageLocation: 'assets/images/categories/informal.png',
          imageCaption: 'informal',
        ),
        Category(
          imageLocation: 'assets/images/categories/formal.png',
          imageCaption: 'formal',
        ),
        Category(
          imageLocation: 'assets/images/categories/dress.png',
          imageCaption: 'dress',
        ),
        Category(
          imageLocation: 'assets/images/categories/accessories.png',
          imageCaption: 'accessories',
        ),
      ]),
    );
  }
}

class Category extends StatelessWidget {
  final String imageLocation;
  final String imageCaption;

  const Category({Key key, this.imageLocation, this.imageCaption})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: InkWell(
        onTap: () {},
        child: Container(
          width: 100.0,
          child: ListTile(
            title: Image.asset(
              imageLocation,
              width: 100.0,
              height: 80.0,
            ),
            subtitle: Container(
              alignment: Alignment.topCenter,
              child: Text(
                imageCaption,
                style: TextStyle(fontSize: 12.0),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
