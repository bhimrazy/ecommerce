import 'package:flutter/material.dart';
import 'package:ecommerce/pages/product_deatils.dart';

class Products extends StatefulWidget {
  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  var productList = [
    {
      "name": "Blazer",
      "picture": "assets/images/products/blazer1.jpeg",
      "oldprice": 120,
      "price": 85,
    },
    {
      "name": "Blazer1",
      "picture": "assets/images/products/blazer2.jpeg",
      "oldprice": 120,
      "price": 85,
    },
    {
      "name": "Dress",
      "picture": "assets/images/products/dress1.jpeg",
      "oldprice": 120,
      "price": 85,
    },
    {
      "name": "Dress1",
      "picture": "assets/images/products/dress2.jpeg",
      "oldprice": 120,
      "price": 85,
    },
    {
      "name": "Hills",
      "picture": "assets/images/products/hills1.jpeg",
      "oldprice": 120,
      "price": 85,
    },
    {
      "name": "Hills1",
      "picture": "assets/images/products/hills2.jpeg",
      "oldprice": 120,
      "price": 85,
    },
    {
      "name": "Pants",
      "picture": "assets/images/products/pants1.jpg",
      "oldprice": 120,
      "price": 85,
    },
    {
      "name": "Pants1",
      "picture": "assets/images/products/pants2.jpeg",
      "oldprice": 120,
      "price": 85,
    },
    {
      "name": "Skirts",
      "picture": "assets/images/products/skt1.jpeg",
      "oldprice": 120,
      "price": 85,
    },
    {
      "name": "Skirts1",
      "picture": "assets/images/products/skt2.jpeg",
      "oldprice": 120,
      "price": 85,
    },
  ];
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: productList.length,
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (BuildContext context, int index) {
        return SingleProduct(
          productName: productList[index]['name'],
          prodPicture: productList[index]['picture'],
          prodOldPrice: productList[index]['oldprice'],
          prodPrice: productList[index]['price'],
        );
      },
    );
  }
}

class SingleProduct extends StatelessWidget {
  final productName;
  final prodPicture;
  final prodOldPrice;
  final prodPrice;
  const SingleProduct(
      {Key key,
      this.productName,
      this.prodPicture,
      this.prodOldPrice,
      this.prodPrice})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Hero(
      tag: Text("Hero"),
      child: Material(
        child: InkWell(
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ProductDetails(
                    //passing values to the Detail Page
                    productDetailName: productName,
                    productDetailPicture: prodPicture,
                    productDetailOldPrice: prodOldPrice,
                    productDetailPrice: prodPrice,
                  ))),
          child: GridTile(
            footer: Container(
              color: Colors.white70,
              child: ListTile(
                leading: Text(productName,
                    style: TextStyle(fontWeight: FontWeight.bold)),
                title: Text("\$$prodPrice",
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.w800)),
                subtitle: Text("\$$prodOldPrice",
                    style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.w800,
                        decoration: TextDecoration.lineThrough)),
              ),
            ),
            child: Image.asset(
              prodPicture,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    ));
  }
}
