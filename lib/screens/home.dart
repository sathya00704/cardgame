import 'package:cardgame/screens/cartscreen.dart';
import 'package:flutter/material.dart';
import 'package:cardgame/constants/constants.dart';
import 'package:cardgame/screens/playwithcomp.dart';
import 'package:cardgame/screens/playwithfriends.dart';

// Home screen that allows users to navigate to different game modes and app features
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

// State class for the Home screen
class _HomeState extends State<Home> {
  final numericRegex = RegExp(r'^[0-9]+$'); // Regular expression for numeric validation
  String username = ''; // Holds the username entered by the user

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // Handle the back button to confirm if the user wants to exit the app
      onWillPop: () async {
        return await showDialog(
          context: context,
          builder: (BuildContext context) {
            // Dialog to confirm if the user wants to exit
            return AlertDialog(
              title: Text('Confirm Exit'),
              content: Text('Are you sure you want to exit?'),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false), // If 'No', do not exit
                  child: Text('No', style: TextStyle(color: Colors.red)),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true), // If 'Yes', exit
                  child: Text('Yes'),
                ),
              ],
            );
          },
        ) ?? false; // Return false if the dialog result is null
      },
      child: Stack(
        children: [
          // Background image for the entire screen
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/bg1.jpg'), // Background image asset
                fit: BoxFit.cover, // Fit the image to cover the screen
              ),
            ),
          ),
          Scaffold(
            appBar: AppBar(
              // App bar with a transparent background
              backgroundColor: Colors.transparent,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      backgroundImage: AssetImage('assets/cardgamelogo.png'), // App icon
                      radius: 30.0,
                    ),
                  ),
                  SizedBox(width: 8), // Spacing between the icon and the text
                  Text('CASINO', style: TextStyle(color: Colors.black)), // App name
                ],
              ),
              centerTitle: true, // Center the title in the app bar
              elevation: 0, // Remove shadow from the app bar
            ),
            backgroundColor: Colors.transparent, // Transparent background for the scaffold
            body: Stack(
              children: [
                // Central content with game mode buttons
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ElevatedButton(
                        // Button to play against the computer
                        onPressed: () {
                          print('Play with computer button');
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => PlaywithComp()), // Navigate to the play with computer screen
                          );
                        },
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.green[800], elevation: 10), // Style for the button
                        child: Text(
                          'Play with Computer',
                          style: TextStyle(
                            fontSize: 36,
                            color: Colors.white, // Text color
                          ),
                        ),
                      ),
                      SizedBox(height: 40), // Spacing between buttons
                      ElevatedButton(
                        // Button to play with friends
                        onPressed: () {
                          print('Play with friends button');
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => PlayWithFriends()), // Navigate to the play with friends screen
                          );
                        },
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.green[800], elevation: 10), // Button style
                        child: Text(
                          'Play with Friends',
                          style: TextStyle(
                            fontSize: 36,
                            color: Colors.white, // Text color
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Floating Action Buttons for additional features
                Align(
                  alignment: Alignment.topRight, // Position at the top right corner
                  child: Padding(
                    padding: const EdgeInsets.all(8.0), // Padding around the buttons
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end, // Align to the right
                      children: <Widget>[
                        FloatingActionButton(
                          // Profile button to enter username
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Profile'), // Title of the dialog
                                  content: Container(
                                    constraints: BoxConstraints(maxHeight: 400), // Limit the height
                                    child: SingleChildScrollView(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min, // Minimize the size
                                        children: [
                                          TextFormField(
                                            decoration: textInputDecoration.copyWith(hintText: 'Enter an username'), // Input field for username
                                            keyboardType: TextInputType.number, // Numeric keyboard
                                            validator: (val) {
                                              if (val == null || val.isEmpty) {
                                                return 'Please enter a valid username';
                                              }
                                              if (!numericRegex.hasMatch(val)) {
                                                return 'Please enter only numeric values';
                                              }
                                              final heightval = int.tryParse(val);
                                              if (heightval == null || heightval > 99999) {
                                                return 'Username should be less than or equal to 99999';
                                              }
                                              return null;
                                            },
                                            onChanged: (val) {
                                              setState(() {
                                                username = val; // Update the username state
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
                          mini: true, // Smaller size for the button
                          backgroundColor: Colors.black, // Button color
                          child: Icon(Icons.account_circle_rounded, size: 40, color: Colors.white), // Icon for the profile
                        ),
                        SizedBox(height: 20), // Spacing between buttons
                        FloatingActionButton(
                          // Settings button to access various settings
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Settings'), // Title of the dialog
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min, // Minimize the size
                                    children: [
                                      TextButton.icon(
                                        onPressed: () {
                                          // Sound settings
                                          Navigator.of(context).pop(); // Close the dialog
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              content: Text('We are currently working on it! Thanks for your patience!'), // Feedback to the user
                                              duration: Duration(seconds: 3), // Duration of the snack bar
                                            ),
                                          );
                                        },
                                        icon: Icon(Icons.volume_up_outlined), // Icon for sound settings
                                        label: Text('Sound'), // Label for sound settings
                                      ),
                                      TextButton.icon(
                                        onPressed: () {
                                          // Notifications settings
                                          Navigator.of(context).pop(); // Close the dialog
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              content: Text('We are currently working on it! Thanks for your patience!'), // Feedback for notifications
                                              duration: Duration(seconds: 3), // Duration of the snack bar
                                            ),
                                          );
                                        },
                                        icon: Icon(Icons.notifications), // Icon for notifications settings
                                        label: Text('Notifications'), // Label for notifications settings
                                      ),
                                      SizedBox(height: 10), // Spacing between elements
                                      Text('Privacy Policy\n\nTerms and Conditions'), // Information text
                                      SizedBox(height: 10), // Spacing
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          mini: true, // Smaller size
                          backgroundColor: Colors.black, // Button color
                          child: Icon(Icons.settings, size: 40, color: Colors.white), // Icon for settings
                        ),
                        SizedBox(height: 20), // Spacing
                        FloatingActionButton(
                          // Cart button to access the cart
                          onPressed: () {
                            print('Cart icon (to buy)');
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => CartScreen()), // Navigate to the cart screen
                            );
                          },
                          mini: true, // Smaller size
                          backgroundColor: Colors.black, // Button color
                          child: Icon(Icons.shopping_cart, size: 30, color: Colors.white), // Icon for cart
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft, // Position at the top left corner
                  child: Padding(
                    padding: const EdgeInsets.all(8.0), // Padding
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end, // Align to the right
                      children: <Widget>[
                        FloatingActionButton(
                          // Win/Loss statistics button
                          onPressed: () {
                            print('Win/loss icon');
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Win/Loss'), // Title of the dialog
                                  content: Container(
                                    constraints: BoxConstraints(maxHeight: 400), // Limit the height
                                    child: SingleChildScrollView(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min, // Minimize the size
                                        children: [
                                          Text('Win % = 67'), // Win percentage
                                          SizedBox(height: 5), // Spacing
                                          Text('Loss % = 33'), // Loss percentage
                                          SizedBox(height: 5), // Spacing
                                          Text('Total Number of Games Played = 12'), // Total games played
                                          SizedBox(height: 5), // Spacing
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          mini: true, // Smaller size
                          backgroundColor: Colors.black, // Button color
                          child: Icon(Icons.star_border, size: 40, color: Colors.white), // Icon for win/loss
                        ),
                        SizedBox(height: 20), // Spacing
                        FloatingActionButton(
                          // Button for reporting a bug
                          onPressed: () {
                            print('Report Bug');
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Report a Bug'), // Title of the dialog
                                  content: Container(
                                    constraints: BoxConstraints(maxHeight: 400), // Limit the height
                                    child: SingleChildScrollView(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min, // Minimize the size
                                        children: [
                                          Text('Email me at sathyanarayanan.s744@gmail.com'), // Bug report instruction
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          mini: true, // Smaller size
                          backgroundColor: Colors.black, // Button color
                          child: Icon(Icons.report, size: 30, color: Colors.white), // Icon for reporting a bug
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}