import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFFF3C7),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/cardgamelogo.png'),
                radius: 30.0,
              ),
            ),
            SizedBox(width: 8), // Add some space between the image and text
            Text('Casino game', style: TextStyle(color: Colors.black)),
          ],
        ),
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: Color(0xFFFFF3C7),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  FloatingActionButton(
                    onPressed: () {print('profile icon');},
                    mini: true,
                    backgroundColor: Colors.black,
                    child: Icon(Icons.account_circle_rounded, size: 40, color: Colors.white),
                  ),
                  SizedBox(height: 20),
                  FloatingActionButton(
                    onPressed: () {print('settings icon');},
                    mini: true,
                    backgroundColor: Colors.black,
                    child: Icon(Icons.settings, size: 40, color: Colors.white),
                  ),
                  SizedBox(height: 20),
                  FloatingActionButton(
                    onPressed: () {print('cart icon (to buy)');},
                    mini: true,
                    backgroundColor: Colors.black,
                    child: Icon(Icons.shopping_cart, size: 30, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {print('play with computer button');},
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.orange, elevation: 10),
                  child: Text(
                    'Play with computer',
                    style: TextStyle(
                      fontSize: 36,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {print('play with friends button');},
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.orange, elevation: 10),
                  child: Text(
                    'Play with friends',
                    style: TextStyle(
                      fontSize: 36,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  FloatingActionButton(
                    onPressed: () {print('win/loss icon');},
                    mini: true,
                    backgroundColor: Colors.black,
                    child: Icon(Icons.star_border, size: 40, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
