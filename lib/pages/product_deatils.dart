import 'package:ecommerce/main.dart';
import 'package:flutter/material.dart';

class ProductDetails extends StatefulWidget {
  final productDetailName;
  final productDetailPicture;
  final productDetailOldPrice;
  final productDetailPrice;

  const ProductDetails(
      {Key key,
      this.productDetailName,
      this.productDetailPicture,
      this.productDetailOldPrice,
      this.productDetailPrice})
      : super(key: key);
  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.1,
        backgroundColor: Colors.red,
        title: InkWell(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => HomePage()));
            },
            child: Text('shopApp')),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: () {}),
        ],
      ),
      body: ListView(
        children: <Widget>[
          Container(
            height: 300.0,
            child: GridTile(
              child: Container(
                color: Colors.white,
                child: Image.asset(widget.productDetailPicture),
              ),
              footer: Container(
                color: Colors.white70,
                child: ListTile(
                  leading: Text(
                    widget.productDetailName,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                  ),
                  title: Row(children: <Widget>[
                    Expanded(
                        child: Text("\$${widget.productDetailOldPrice}",
                            style: TextStyle(
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough))),
                    Expanded(
                        child: Text("\$${widget.productDetailPrice}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ))),
                  ]),
                ),
              ),
            ),
          ),

          //=====================the first button=======
          Row(children: <Widget>[
            //=======the size button===================
            Expanded(
              child: MaterialButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("Size"),
                          content: Text("Choose the size"),
                          actions: <Widget>[
                            MaterialButton(
                                onPressed: () {
                                  Navigator.of(context).pop(context);
                                },
                                child: Text("close")),
                          ],
                        );
                      });
                },
                color: Colors.white,
                textColor: Colors.grey,
                elevation: 0.1,
                child: Row(children: <Widget>[
                  Expanded(
                    child: Text("Size"),
                  ),
                  Expanded(
                    child: Icon(Icons.arrow_drop_down),
                  )
                ]),
              ),
            ),
            //=======the color button===================
            Expanded(
              child: MaterialButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("Color"),
                          content: Text("Choose the color"),
                          actions: <Widget>[
                            MaterialButton(
                                onPressed: () {
                                  Navigator.of(context).pop(context);
                                },
                                child: Text("close")),
                          ],
                        );
                      });
                },
                color: Colors.white,
                textColor: Colors.grey,
                elevation: 0.2,
                child: Row(children: <Widget>[
                  Expanded(
                    child: Text("Color"),
                  ),
                  Expanded(
                    child: Icon(Icons.arrow_drop_down),
                  )
                ]),
              ),
            ),
            //=======the quantity button===================
            Expanded(
              child: MaterialButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("Quantity"),
                          content: Text("Choose the quantity"),
                          actions: <Widget>[
                            MaterialButton(
                                onPressed: () {
                                  Navigator.of(context).pop(context);
                                },
                                child: Text("close")),
                          ],
                        );
                      });
                },
                color: Colors.white,
                textColor: Colors.grey,
                elevation: 0.2,
                child: Row(children: <Widget>[
                  Expanded(
                    child: Text("Qty"),
                  ),
                  Expanded(
                    child: Icon(Icons.arrow_drop_down),
                  )
                ]),
              ),
            )
          ]),

          //=====================the second button=======
          Row(children: <Widget>[
            //=======the buy now button===================
            Expanded(
              child: MaterialButton(
                onPressed: () {},
                color: Colors.red,
                textColor: Colors.white,
                elevation: 0.1,
                child: Row(children: <Widget>[
                  Expanded(
                    child: Center(child: Text("Buy now")),
                  )
                ]),
              ),
            ),
            IconButton(
                icon: Icon(Icons.add_shopping_cart, color: Colors.red),
                onPressed: () {}),
            IconButton(
                icon: Icon(
                  Icons.favorite_border,
                  color: Colors.red,
                ),
                onPressed: () {}),
          ]),
          Divider(),
          ListTile(
            title: Text("Product Details"),
            subtitle: Text(
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged."),
          ),
          Divider(),
          Row(
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                  child: Text("Product name",
                      style: TextStyle(color: Colors.grey))),
              Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Text(widget.productDetailName))
            ],
          ),
          Row(
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                  child: Text("Product Brand",
                      style: TextStyle(color: Colors.grey))),
              Padding(padding: EdgeInsets.all(5.0), child: Text("Brand X"))
            ],
          ),
          Row(
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                  child: Text("Product Condition",
                      style: TextStyle(color: Colors.grey))),
              Padding(padding: EdgeInsets.all(5.0), child: Text("NEW"))
            ],
          ),
          //Divider
          Divider(),
          //paddingWidget
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              'Similar Products',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
          ),

          //grid view
          Container(
            height: 650,
            child: SimilarProducts(),
          ),
        ],
      ),
    );
  }
}

class SimilarProducts extends StatefulWidget {
  @override
  _SimilarProductsState createState() => _SimilarProductsState();
}

class _SimilarProductsState extends State<SimilarProducts> {
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
      "name": "Hills",
      "picture": "assets/images/products/hills1.jpeg",
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
      "name": "Skirts",
      "picture": "assets/images/products/skt1.jpeg",
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
