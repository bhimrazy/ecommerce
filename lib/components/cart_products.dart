import 'package:flutter/material.dart';

class CartProducts extends StatefulWidget {
  @override
  _CartProductsState createState() => _CartProductsState();
}

class _CartProductsState extends State<CartProducts> {
  var productsOnTheCart = [
    {
      "name": "Blazer",
      "picture": "assets/images/products/blazer1.jpeg",
      "price": 85,
      "size": "M",
      "color": "Red",
      "quantity": 1,
    },
    {
      "name": "Blazer1",
      "picture": "assets/images/products/blazer2.jpeg",
      "price": 85,
      "size": "M",
      "color": "Red",
      "quantity": 1,
    },
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: productsOnTheCart.length,
        itemBuilder: (context, index) {
          return SingleCartProduct(
            cartProductName: productsOnTheCart[index]["name"],
            cartProductPicture: productsOnTheCart[index]["picture"],
            cartProductPrice: productsOnTheCart[index]["price"],
            cartProductSize: productsOnTheCart[index]["size"],
            cartProductColor: productsOnTheCart[index]["color"],
            cartProductQty: productsOnTheCart[index]["quantity"],
          );
        });
  }
}

class SingleCartProduct extends StatelessWidget {
  final cartProductName;
  final cartProductPicture;
  final cartProductPrice;
  final cartProductSize;
  final cartProductColor;
  final cartProductQty;

  const SingleCartProduct(
      {Key key,
      this.cartProductName,
      this.cartProductPicture,
      this.cartProductPrice,
      this.cartProductSize,
      this.cartProductColor,
      this.cartProductQty})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        //===============LEADING================//
        leading: Image.asset(
          cartProductPicture,
          width: 80,
          height: 80,
        ),
        //===============TITLE================//
        title: Text(cartProductName),
        //===============SUBTITLE SECTION================//
        subtitle: Column(
          children: <Widget>[
            //===============ROW================//
            Row(
              children: <Widget>[
                //===============SIZE================//
                Padding(
                    padding: const EdgeInsets.all(1),
                    child: Text('Size:', style: TextStyle(color: Colors.red))),
                Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(cartProductSize)),
                //===============COLOR================//
                Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 8.0, 8.0, 8.0),
                    child: Text("Color:")),
                Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      cartProductColor,
                      style: TextStyle(color: Colors.red),
                    )),
              ],
            ),
            //===============PRICE================//
            Container(
              alignment: Alignment.topLeft,
              child: Text("\$$cartProductPrice",
                  style: TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.red)),
            )
          ],
        ),
        //===============TRAILING================//
        trailing: Column(
          children: <Widget>[
            // IconButton(
            //     icon: Icon(
            //       Icons.arrow_drop_up,
            //     ),
            //     onPressed: () {}),
            Text("$cartProductQty"),
            // IconButton(
            //     icon: Icon(
            //       Icons.arrow_drop_down,
            //     ),
            //     onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
