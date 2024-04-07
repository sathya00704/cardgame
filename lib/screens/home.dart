import 'package:flutter/material.dart';
import 'package:cardgame/constants/constants.dart';
import 'package:cardgame/screens/playwithcomp.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final numericRegex = RegExp(r'^[0-9]+$');
  String username = '';

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background Image
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/bg1.jpg'), // Replace 'bg1.jpg' with your image asset
              fit: BoxFit.cover,
            ),
          ),
        ),
        Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent, // Make the app bar transparent
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
          backgroundColor: Colors.transparent, // Set the scaffold background to transparent
          body: Stack(
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () {
                        print('play with computer button');
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => PlaywithComp()),
                        );
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.green[800], elevation: 10),
                      child: Text(
                        'Play with Computer',
                        style: TextStyle(
                          fontSize: 36,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: 40),
                    ElevatedButton(
                      onPressed: () {
                        print('play with friends button');
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.green[800], elevation: 10),
                      child: Text(
                        'Play with Friends',
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
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      FloatingActionButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Profile'),
                                content: Container(
                                  constraints: BoxConstraints(maxHeight: 400),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        TextFormField(
                                          decoration: textInputDecoration.copyWith(hintText: 'Enter an username'),
                                          keyboardType: TextInputType.number,
                                          validator: (val) {
                                            if (val==null || val.isEmpty) {
                                              return 'Please enter a valid username';
                                            }
                                            if(!numericRegex.hasMatch(val)){
                                              return 'Please enter only numeric values';
                                            }
                                            final heightval = int.tryParse(val);
                                            if(heightval == null || heightval>99999){
                                              return 'Username should be greater than 99999';
                                            }
                                            return null;
                                          },
                                          onChanged: (val) {
                                            setState(() {
                                              username = val;
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        mini: true,
                        backgroundColor: Colors.black,
                        child: Icon(Icons.account_circle_rounded, size: 40, color: Colors.white),
                      ),
                      SizedBox(height: 20),
                      FloatingActionButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Settings'),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TextButton.icon(
                                      onPressed: () {
                                        // Handle language settings
                                        Navigator.of(context).pop();
                                      },
                                      icon: Icon(Icons.volume_up_outlined),
                                      label: Text('Sound'),
                                    ),
                                    TextButton.icon(
                                      onPressed: () {
                                        // Handle notifications settings
                                        Navigator.of(context).pop();
                                      },
                                      icon: Icon(Icons.notifications),
                                      label: Text('Notifications'),
                                    ),
                                    SizedBox(height: 10),
                                    Text('Privacy Policy\n\nTerms and Conditions'),
                                    SizedBox(height: 10),
                                  ],
                                ),
                              );
                            },
                          );
                        },
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
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      FloatingActionButton(
                        onPressed: () {
                          print('win/loss icon');
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Win/loss'),
                                content: Container(
                                  constraints: BoxConstraints(maxHeight: 400),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text('Win % = 67'),
                                        SizedBox(height: 5),
                                        Text('Loss % = 33'),
                                        SizedBox(height: 5),
                                        Text('Total No of games played = 12'),
                                        SizedBox(height: 5),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
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
        ),
      ],
    );
  }
}
