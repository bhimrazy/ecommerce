import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';

//myOwn imports
import 'package:ecommerce/components/horizontal_listview.dart';
import 'package:ecommerce/components/products.dart';
import 'package:ecommerce/pages/cart.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Widget imageCarousel = Container(
      height: 200.0,
      child: Carousel(
        boxFit: BoxFit.cover,
        images: [
          AssetImage('assets/images/carousel/c1.jpg'),
          AssetImage('assets/images/carousel/m1.jpg'),
          AssetImage('assets/images/carousel/m2.jpg'),
          AssetImage('assets/images/carousel/w1.jpg'),
          AssetImage('assets/images/carousel/w3.jpg'),
          AssetImage('assets/images/carousel/w4.jpg'),
        ],
        autoplay: false,
        dotSize: 5.0,
        indicatorBgPadding: 10.0,
        dotBgColor: Colors.transparent,
        animationCurve: Curves.fastOutSlowIn,
        animationDuration: Duration(milliseconds: 1000),
      ),
    );
    return Scaffold(
      appBar: AppBar(
        elevation: 0.1,
        centerTitle: true,
        backgroundColor: Colors.red,
        title: Text('ShopApp'),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: () {}),
          IconButton(
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Cart()));
              })
        ],
      ),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            //header
            UserAccountsDrawerHeader(
              accountName: Text('John Doe'),
              accountEmail: Text('doejohn@gmail.com'),
              currentAccountPicture: GestureDetector(
                  child: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.person,
                  color: Colors.red,
                ),
              )),
              decoration: BoxDecoration(color: Colors.red),
            ),
            //body
            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text('Home Page'),
                leading: Icon(
                  Icons.home,
                  color: Colors.red,
                ),
              ),
            ),
            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text('My Account'),
                leading: Icon(
                  Icons.person,
                  color: Colors.red,
                ),
              ),
            ),
            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text('My Orders'),
                leading: Icon(
                  Icons.shopping_basket,
                  color: Colors.red,
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Cart()));
              },
              child: ListTile(
                title: Text('Shopping Cart'),
                leading: Icon(
                  Icons.shopping_cart,
                  color: Colors.red,
                ),
              ),
            ),
            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text('Favourites'),
                leading: Icon(
                  Icons.favorite,
                  color: Colors.red,
                ),
              ),
            ),
            Divider(),
            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text('Settings'),
                leading: Icon(
                  Icons.settings,
                ),
              ),
            ),
            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text('About'),
                leading: Icon(
                  Icons.help,
                ),
              ),
            ),
          ],
        ),
      ),
      //mainBody
      body: ListView(
        children: <Widget>[
          //imagecarousel
          imageCarousel,
          //paddingWidget
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              'Categories',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          //Horizontal List View begins Here
          HorizontalList(),

          //paddingWidget
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              'Recent Products',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
          ),

          //grid view
          Container(
            height: 400,
            child: Products(),
          ),
        ],
      ),
    );
  }
}
